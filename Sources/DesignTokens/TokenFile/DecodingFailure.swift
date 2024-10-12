import Foundation

/// The possible reasons for a decoding failure.
enum DecodingFailure: Error {
  enum ValueFailure {
    case invalidHexString
    case invalidDimensionString
    case invalidDimensionValue
  }

  /// The coding path from the decoding process is invalid.
  case invalidCodingPath

  /// The token is missing a type.
  case missingType

  case invalidValue(ValueFailure)
}
