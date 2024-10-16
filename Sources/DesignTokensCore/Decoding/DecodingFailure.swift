import Foundation

/// The possible reasons for a decoding failure.
enum DecodingFailure: Error {
  /// The coding path from the decoding process is invalid.
  case invalidCodingPath

  /// The token is missing a type.
  case missingType

  case invalidColorValue(tokenName: String, tokenPath: [String], valueFailure: ColorValueFailure)
  
  case invalidDimensionValue(tokenName: String, tokenPath: [String], valueFailure: DimensionValueFailure)
  
  case invalidAliasValue(tokenName: String, tokenPath: [String], valueFailure: AliasValueFailure)
}

extension DecodingFailure: Equatable {}

protocol ValueFailure: Error, Equatable {}

enum ColorValueFailure: ValueFailure {
  /// The value is not a valid hexadecimal string.
  case invalidHexString
}

enum DimensionValueFailure: ValueFailure {
  /// The value does not represent a valid dimension.
  case invalidStringValue

  /// The value of the dimension is not a valid number.
  case invalidValue
}

enum AliasValueFailure: ValueFailure {
  /// The value of the alias is not a valid token reference.
  case invalidReferenceSyntax
}
