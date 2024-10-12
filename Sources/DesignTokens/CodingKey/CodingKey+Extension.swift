import Foundation

extension CodingKey {
  var isValueKey: Bool {
    stringValue.hasPrefix("$")
  }

  var isNameKey: Bool {
    !isValueKey
  }
}
