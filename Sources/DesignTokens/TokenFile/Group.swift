import Foundation

/// A type representing a group in a design token file.
struct Group {

  // MARK: - Stored Properties

  /// The name of the group.
  let name: String

  /// The optional description of the group.
  let description: String?

  /// The subgroups of the groups.
  let subgroups: Set<Group>

  /// The tokens in the group.
  let tokens: Set<Token>

  // MARK: - Init

  init(name: String, description: String? = nil, subgroups: Set<Group> = [], tokens: Set<Token> = []) {
    self.name = name
    self.description = description
    self.subgroups = subgroups
    self.tokens = tokens
  }
}

extension Group: DecodableWithConfiguration {
  init(from decoder: any Decoder, configuration: GroupDecodingConfiguration) throws {
    let container = try decoder.container(keyedBy: AnyCodingKey.self)

    guard let name = container.codingPath.last else {
      throw DecodingFailure.invalidCodingPath
    }

    self.name = name.stringValue
    self.description = try container.decodeIfPresent(String.self, forKey: .description)
    let type = try container.decodeIfPresent(TokenType.self, forKey: .type) ?? configuration.type

    var subgroups: Set<Group> = []
    var tokens: Set<Token> = []

    for key in container.allKeys where key.isNameKey {
      if try container.isTokenContainer(for: key) {
        let token = try container.decode(Token.self, forKey: key, configuration: TokenDecodingConfiguration(type: type))
        tokens.insert(token)
      } else {
        let subgroup = try container.decode(Group.self, forKey: key, configuration: GroupDecodingConfiguration(type: type))
        subgroups.insert(subgroup)
      }
    }

    self.subgroups = subgroups
    self.tokens = tokens
  }
}

extension Group: Equatable {}

extension Group: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
}
