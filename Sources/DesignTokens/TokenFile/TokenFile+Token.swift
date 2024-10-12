import Foundation

struct TokenConfiguration {
  let type: TokenFile.ValueType?

  init(type: TokenFile.ValueType? = nil) {
    self.type = type
  }
}

extension TokenFile {
  /// A type representing a token in a design token file.
  struct Token: DecodableWithConfiguration, Equatable, Hashable {

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

    init(from decoder: any Decoder, configuration: TokenConfiguration) throws {
      let container = try decoder.container(keyedBy: AnyCodingKey.self)

      guard let type = try container.decodeIfPresent(ValueType.self, forKey: .type) ?? configuration.type else {
        throw Failure.missingType
      }

      guard let name = container.codingPath.last else {
        throw Failure.invalidCodingPath
      }

      self.name = name.stringValue
      self.description = try container.decodeIfPresent(String.self, forKey: .description)
      self.value = try container.decode(String.self, forKey: .value)
      self.type = type
      self.path = container.codingPath.map(\.stringValue)
    }

    // MARK: - Functions

    func hash(into hasher: inout Hasher) {
      hasher.combine(name)
    }
  }
}
