import Foundation

/// The possible reasons for a decoding failure.
enum DecodingFailure: Error {
  /// The coding path from the decoding process is invalid.
  case invalidCodingPath

  /// The token is missing a type.
  case missingType(tokenName: String, tokenPath: [String])

  /// The decoded color value is invalid.
  case invalidColorValue(tokenName: String, tokenPath: [String], valueFailure: ColorValueFailure)
  
  /// The decoded dimension value is invalid.
  case invalidDimensionValue(tokenName: String, tokenPath: [String], valueFailure: DimensionValueFailure)
  
  /// The decoded alias value is invalid.
  case invalidAliasValue(tokenName: String, tokenPath: [String], valueFailure: AliasValueFailure)
  
  /// The decoded gradient value is invalid.
  case invalidGradientValue(tokenName: String, tokenPath: [String])
}

extension DecodingFailure: Equatable {}

extension DecodingFailure: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .invalidCodingPath:
      return "The coding path from the decoding process is invalid."
      
    case let .missingType(tokenName, tokenPath):
      return "The token '\(tokenName)' at path '\(tokenPath)' is missing its type."
      
    case let .invalidColorValue(tokenName, tokenPath, valueFailure):
      return """
      The decoded color value for token '\(tokenName) at path \(tokenPath) is invalid. 
      Reason: \(valueFailure)
      """
      
    case let .invalidDimensionValue(tokenName, tokenPath, valueFailure):
      return """
      The decoded dimension value for token '\(tokenName) at path \(tokenPath) is invalid. 
      Reason: \(valueFailure.localizedDescription)
      """

    case let .invalidAliasValue(tokenName, tokenPath, valueFailure):
      return """
      The decoded alias value for token '\(tokenName) at path \(tokenPath) is invalid. 
      Reason: \(valueFailure.localizedDescription)
      """

    case let .invalidGradientValue(tokenName, tokenPath):
      return """
      The decoded value for token '\(tokenName) at path \(tokenPath) is invalid.
      """
    }
  }
}
