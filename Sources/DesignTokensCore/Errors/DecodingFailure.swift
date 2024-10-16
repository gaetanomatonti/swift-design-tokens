import Foundation

/// The possible reasons for a decoding failure.
enum DecodingFailure: Error {
  /// The coding path from the decoding process is invalid.
  case invalidCodingPath

  /// The token is missing a type.
  case missingType

  /// The decoded color value is invalid.
  case invalidColorValue(tokenName: String, tokenPath: [String], valueFailure: ColorValueFailure)
  
  /// The decoded dimension value is invalid.
  case invalidDimensionValue(tokenName: String, tokenPath: [String], valueFailure: DimensionValueFailure)
  
  /// The decoded alias value is invalid.
  case invalidAliasValue(tokenName: String, tokenPath: [String], valueFailure: AliasValueFailure)
}

extension DecodingFailure: Equatable {}
