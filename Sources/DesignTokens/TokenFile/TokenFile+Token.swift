import Foundation

extension TokenFile {
  /// A type representing a token in a design token file.
  struct Token: Decodable, Equatable, Hashable {
    enum CodingKeys: String, CodingKey {
      case name
      case value = "$value"
      case description = "$description"
      case type = "$type"
    }

    let name: String
    let value: String
    let description: String?
    let type: String?
    let path: [String]

    init(name: String, value: String, description: String? = nil, type: String? = nil, path: [String]) {
      self.name = name
      self.value = value
      self.description = description
      self.type = type
      self.path = path
    }

    init(from decoder: any Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)

      self.name = container.codingPath.last!.stringValue

      self.value = try container.decode(String.self, forKey: .value)
      self.description = try container.decodeIfPresent(String.self, forKey: .description)
      self.type = try container.decodeIfPresent(String.self, forKey: .type)

      self.path = container.codingPath.map(\.stringValue)
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(name)
    }
  }
}
