import Foundation

package typealias Path = [String]

/// The possible values of a design token.
package enum TokenValue: Equatable {
  case color(Color)
  case dimension(Dimension)
  case alias(Path)
}

extension TokenValue {
  /// Decodes the token value from its string value.
  /// - Parameters:
  ///   - stringValue: The string value of the token.
  ///   - type: The type of the token.
  /// - Returns: The decoded `TokenValue`.
  static func from(_ stringValue: String, name: String, path: [String], type: TokenType?) throws(DecodingFailure) -> TokenValue {
    do {
      return try attemptAliasDecoding(stringValue, name: name, path: path)
    } catch {
      guard let type else {
        do {
          return try attemptAliasDecoding(stringValue, name: name, path: path)
        } catch {
          throw .missingType(tokenName: name, tokenPath: path)
        }
      }
      
      return try decodeValue(stringValue, of: type, name: name, path: path)
    }
  }
  
  private static func decodeValue(_ stringValue: String, of type: TokenType, name: String, path: [String]) throws(DecodingFailure) -> TokenValue {
    switch type {
    case .color:
      do {
        let color = try Color(stringValue)
        return .color(color)
      } catch {
        throw .invalidColorValue(tokenName: name, tokenPath: path, valueFailure: error)
      }
      
    case .dimension:
      do {
        let dimension = try Dimension(stringValue)
        return .dimension(dimension)
      } catch {
        throw .invalidDimensionValue(tokenName: name, tokenPath: path, valueFailure: error)
      }
    }
  }
  
  private static func attemptAliasDecoding(_ stringValue: String, name: String, path: [String]) throws(AliasValueFailure) -> TokenValue {
    let alias = try Alias(stringValue)
    return .alias(alias.path)
  }
}
