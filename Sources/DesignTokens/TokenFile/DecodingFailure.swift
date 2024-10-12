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

    /// The value of the alias is not a valid token reference.
    case invalidReferenceSyntax

    /// The value of the token reference is not valid.
    case invalidReferenceValue
  }

  /// The coding path from the decoding process is invalid.
  case invalidCodingPath

  /// The token is missing a type.
  case missingType

  /// The token has an invalid value.
  case invalidValue(ValueFailure)
}

extension DecodingFailure: Equatable {}

extension DecodingFailure.ValueFailure: Equatable {}
