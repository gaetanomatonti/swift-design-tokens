import Foundation

extension TokenFile {
  /// A type representing a group in a design token file.
  struct Group: Decodable, Equatable, Hashable {

    // MARK: - Stored Properties

    let name: String
    let description: String?
    let type: String?
    let groups: Set<Group>
    let tokens: Set<Token>

    // MARK: - Init

    init(name: String, description: String? = nil, type: String? = nil, groups: Set<Group> = [], tokens: Set<Token> = []) {
      self.name = name
      self.description = description
      self.type = type
      self.groups = groups
      self.tokens = tokens
    }

    init(from decoder: any Decoder) throws {
      let container = try decoder.container(keyedBy: AnyCodingKey.self)

      self.name = container.codingPath.last!.stringValue
      self.description = try container.decodeIfPresent(String.self, forKey: AnyCodingKey(stringValue: "$description")!)
      self.type = try container.decodeIfPresent(String.self, forKey: AnyCodingKey(stringValue: "$type")!)

      var groups: Set<Group> = []
      var tokens: Set<Token> = []

      for key in container.allKeys where key.isNameKey {
        let nestedContainer = try container.nestedContainer(keyedBy: AnyCodingKey.self, forKey: key)

        if nestedContainer.allKeys.allSatisfy(\.isPropertyKey) {
          let token = try container.decode(Token.self, forKey: key)
          tokens.insert(token)
        } else {
          let subgroup = try container.decode(Group.self, forKey: key)
          groups.insert(subgroup)
        }
      }

      self.groups = groups
      self.tokens = tokens
    }

    // MARK: - Functions

    func hash(into hasher: inout Hasher) {
      hasher.combine(name)
    }
  }
}
