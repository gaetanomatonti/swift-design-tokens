import Foundation

/// A type representing a token that references another token.
package struct AliasToken: Token {
  /// The name of the token.
  let name: String

  /// The optional description of the token.
  let description: String?

  /// The path to the referenced token.
  let path: Path

  init(name: String, description: String? = nil, path: Path) {
    self.name = name
    self.description = description
    self.path = path
  }
}