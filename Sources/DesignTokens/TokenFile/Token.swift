import Foundation

// A type defining the structure of a design token.
struct Token {
  /// The possible values of a design token.
  enum Value: Equatable {
    case color(Color)
    case dimension(Dimension)
    case alias(Path)
  }

  typealias Path = [String]

  /// The name of the token.
  let name: String

  /// The optional description of the token.
  let description: String?

  /// The value of the token.
  let value: Value

  /// The path to the token.
  ///
  /// If the token is not contained in a group, this array contains only the `name` of the token.
  let path: Path

  init(name: String, description: String? = nil, value: Value, path: Path) {
    self.name = name
    self.description = description
    self.value = value
    self.path = path
  }
}

extension Token: DecodableWithConfiguration {
  init(from decoder: any Decoder, configuration: TokenDecodingConfiguration) throws {
    let container = try decoder.container(keyedBy: AnyCodingKey.self)

    let type = try container.decodeIfPresent(TokenType.self, forKey: .type) ?? configuration.type
    let valueString = try container.decode(String.self, forKey: .value)

    switch type {
    case .some(.color):
      let color = try Color(valueString)
      self.value = .color(color)

    case .some(.dimension):
      let dimension = try Dimension(valueString)
      self.value = .dimension(dimension)

    case .none:
      // Check alias, else fail
      throw DecodingFailure.missingType
    }

    guard let name = container.codingPath.last else {
      throw DecodingFailure.invalidCodingPath
    }

    self.name = name.stringValue
    self.description = try container.decodeIfPresent(String.self, forKey: .description)
    self.path = container.codingPath.map(\.stringValue)
  }
}

extension Token: Equatable {}

extension Token: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
}
