import Foundation

/// The configuration for the decoding of a `Token`.
package struct TokenDecodingConfiguration {

  // MARK: - Stored properties

  /// The type of the token.
  ///
  /// This value is passed down the decoding process from parent groups.
  /// This is needed, since the `$type` property is not required.
  /// If a token has no type, [it should be determined from a parent group](https://tr.designtokens.org/format/#type-0).
  let type: TokenType?

  // MARK: - Init

  init(type: TokenType? = nil) {
    self.type = type
  }
}
