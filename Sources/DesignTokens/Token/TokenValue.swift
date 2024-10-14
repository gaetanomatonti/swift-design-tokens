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
  static func from(_ stringValue: String, type: TokenType?) throws -> TokenValue {
    switch type {
    case .some(.color):
      let color = try Color(stringValue)
      return .color(color)

    case .some(.dimension):
      let dimension = try Dimension(stringValue)
      return .dimension(dimension)

    case .none:
      do {
        let alias = try Alias(stringValue)
        return .alias(alias.path)
      } catch .invalidValue(.invalidReferenceSyntax) {
        throw DecodingFailure.missingType
      } catch {
        throw error
      }
    }
  }
}
