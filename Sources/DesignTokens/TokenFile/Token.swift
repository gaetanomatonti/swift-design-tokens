import Foundation

/// A type representing a token in a design token file.
struct Token {

  // MARK: - Stored Properties

  let name: String
  let description: String?
  let value: String
  let type: ValueType
  let path: [String]

  // MARK: - Init

  init(name: String, description: String? = nil, value: String, type: ValueType, path: [String]) {
    self.name = name
    self.description = description
    self.value = value
    self.type = type
    self.path = path
  }
}

extension Token: DecodableWithConfiguration {
  init(from decoder: any Decoder, configuration: TokenDecodingConfiguration) throws {
    let container = try decoder.container(keyedBy: AnyCodingKey.self)

    guard let type = try container.decodeIfPresent(ValueType.self, forKey: .type) ?? configuration.type else {
      throw DecodingFailure.missingType
    }

    guard let name = container.codingPath.last else {
      throw DecodingFailure.invalidCodingPath
    }

    self.name = name.stringValue
    self.description = try container.decodeIfPresent(String.self, forKey: .description)
    self.value = try container.decode(String.self, forKey: .value)
    self.type = type
    self.path = container.codingPath.map(\.stringValue)
  }
}

extension Token: Equatable {}

extension Token: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
}
