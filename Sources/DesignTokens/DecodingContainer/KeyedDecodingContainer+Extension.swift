import Foundation

extension KeyedDecodingContainer<AnyCodingKey> {
  func isTokenContainer(for key: AnyCodingKey) throws -> Bool {
    let container = try nestedContainer(keyedBy: AnyCodingKey.self, forKey: key)
    return container.allKeys.allSatisfy(\.isPropertyKey)
  }
}
