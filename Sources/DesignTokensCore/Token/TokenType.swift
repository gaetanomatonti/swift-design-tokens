import Foundation

/// The possible types for a token.
package enum TokenType: String, Decodable, CaseIterable {
  /// The `"color"` type.
  case color

  /// The `"dimension"` type.
  case dimension

  /// The `"number"` type.
  case number

  /// The `"gradient"` type.
  case gradient
}
