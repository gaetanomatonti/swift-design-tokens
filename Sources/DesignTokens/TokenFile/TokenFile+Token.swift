import Foundation

extension TokenFile {
  /// A type representing a token in a design token file.
  struct Token: Decodable, Equatable, Hashable {
    let name: String
    let value: String
    let description: String?
    let type: ValueType?
    let path: [String]

    init(name: String, value: String, description: String? = nil, type: ValueType? = nil, path: [String]) {
      self.name = name
      self.value = value
      self.description = description
      self.type = type
      self.path = path
    }

    init(from decoder: any Decoder) throws {
      let container = try decoder.container(keyedBy: AnyCodingKey.self)

      self.name = container.codingPath.last!.stringValue

      self.value = try container.decode(String.self, forKey: .value)
      self.description = try container.decodeIfPresent(String.self, forKey: .description)
      self.type = try container.decodeIfPresent(ValueType.self, forKey: .type)

      self.path = container.codingPath.map(\.stringValue)
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(name)
    }
  }
}
