import Foundation

/// A type representing any key value.
///
/// Use this type as a `CodingKey` when the keys of a container are unknown.
struct AnyCodingKey: CodingKey {
  let stringValue: String
  let intValue: Int?

  init(_ stringValue: String) {
    self.stringValue = stringValue
    self.intValue = nil
  }

  init?(stringValue: String) {
    self.stringValue = stringValue
    self.intValue = nil
  }

  init?(intValue: Int) {
    self.stringValue = intValue.description
    self.intValue = intValue
  }
}

extension AnyCodingKey: ExpressibleByStringLiteral {
  init(stringLiteral value: StringLiteralType) {
    self.init(value)
  }
}

extension AnyCodingKey {
  static let description: AnyCodingKey = "$description"

  static let type: AnyCodingKey = "$type"

  static let value: AnyCodingKey = "$value"
}
