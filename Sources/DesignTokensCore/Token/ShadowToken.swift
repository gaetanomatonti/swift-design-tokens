import Foundation

/// A type representing a shadow token.
package struct ShadowToken: Token {
  /// The name of the token.
  let name: String

  /// The optional description of the token.
  let description: String?

  /// The value of the token.
  let shadow: Shadow

  /// The path to the token.
  ///
  /// If the token is not contained in a group, this array contains only the `name` of the token.
  let path: Path

  init(name: String, description: String? = nil, shadow: Shadow, path: Path) {
    self.name = name
    self.description = description
    self.shadow = shadow
    self.path = path
  }
}
