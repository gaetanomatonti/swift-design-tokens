import Foundation

/// A type representing a color token.
package struct ColorToken: Token {
  /// The name of the token.
  let name: String

  /// The optional description of the token.
  let description: String?

  /// The value of the token.
  let color: Color

  /// The path to the token.
  ///
  /// If the token is not contained in a group, this array contains only the `name` of the token.
  let path: Path

  init(name: String, description: String? = nil, color: Color, path: Path) {
    self.name = name
    self.description = description
    self.color = color
    self.path = path
  }
}
