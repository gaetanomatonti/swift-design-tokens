import Foundation

/// The configuration for the decoding of a `TokenValue`.
package struct TokenValueDecodingConfiguration {

  // MARK: - Stored properties

  /// The name of the token.
  let name: String

  /// The path to the token in the tree.
  let path: Path

  /// The type of the token.
  ///
  /// This value is passed down the decoding process from parent groups.
  /// This is needed, since the `$type` property is not required.
  /// If a token has no type, [it should be determined from a parent group](https://tr.designtokens.org/format/#type-0).
  let type: TokenType?

  // MARK: - Init

  init(name: String, path: Path, type: TokenType? = nil) {
    self.name = name
    self.path = path
    self.type = type
  }
}
