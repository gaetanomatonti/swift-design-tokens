import Foundation

/// The possible failures related to color values.
enum ColorValueFailure: ValueFailure {
  /// The value is not a valid hexadecimal string.
  case invalidHexString
}
