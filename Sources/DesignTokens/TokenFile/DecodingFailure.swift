import Foundation

/// The possible reasons for a decoding failure.
enum DecodingFailure: Error {
  /// The possible failures for values.
  enum ValueFailure: Error {
    /// The value is not a valid hexadecimal string.
    case invalidHexString

    /// The value does not represent a valid dimension.
    case invalidDimensionString

    /// The value of the dimension is not a valid number.
    case invalidDimensionValue
  }

  /// The coding path from the decoding process is invalid.
  case invalidCodingPath

  /// The token is missing a type.
  case missingType

  /// The token has an invalid value.
  case invalidValue(ValueFailure)
}
