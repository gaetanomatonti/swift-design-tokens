import Foundation

extension CodingKey {
  /// Whether the key matches a token property.
  var isPropertyKey: Bool {
    stringValue.hasPrefix("$")
  }

  /// Whether the key matches the name of a group or token.
  var isNameKey: Bool {
    !isPropertyKey
  }
}
