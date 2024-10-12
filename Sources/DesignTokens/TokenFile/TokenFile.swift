import Foundation

/// A type representing a design tokens file.
struct TokenFile: Decodable, Equatable {

  // MARK: - Stored Properties
  
  let tokens: Set<Token>

  let groups: Set<Group>

  // MARK: - Init

  init(tokens: Set<Token>, groups: Set<Group>) {
    self.tokens = tokens
    self.groups = groups
  }

  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: AnyCodingKey.self)

    var tokens: Set<Token> = []
    var groups: Set<Group> = []

    for key in container.allKeys {
      if try container.isTokenContainer(for: key) {
        let token = try container.decode(Token.self, forKey: key, configuration: TokenConfiguration())
        tokens.insert(token)
      } else {
        let group = try container.decode(Group.self, forKey: key, configuration: GroupConfiguration())
        groups.insert(group)
      }
    }

    self.tokens = tokens
    self.groups = groups
  }
}
