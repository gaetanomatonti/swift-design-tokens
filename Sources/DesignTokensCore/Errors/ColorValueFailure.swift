import Foundation

/// The possible failures related to color values.
enum ColorValueFailure: ValueFailure {
  /// The value is not a valid hexadecimal string.
  case invalidHexString
}

extension ColorValueFailure: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .invalidHexString:
      return "The value is not a valid hexadecimal string."
    }
  }
}
