import Foundation

/// The possible types for a token.
enum TokenType: String, Decodable {
  /// The `"color"` type.
  case color

  /// The `"dimension"` type.
  case dimension
}
