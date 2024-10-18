import Foundation

/// A type representing a gradient token.
package struct GradientToken: Token {
  /// The name of the token.
  let name: String

  /// The optional description of the token.
  let description: String?

  /// The value of the token.
  let gradient: Gradient

  /// The path to the token.
  ///
  /// If the token is not contained in a group, this array contains only the `name` of the token.
  let path: Path

  init(name: String, description: String? = nil, gradient: Gradient, path: Path) {
    self.name = name
    self.description = description
    self.gradient = gradient
    self.path = path
  }
}
