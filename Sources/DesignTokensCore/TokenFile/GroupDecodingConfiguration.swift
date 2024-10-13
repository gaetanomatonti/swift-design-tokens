import Foundation

/// The configuration for the decoding of a `Group`.
struct GroupDecodingConfiguration {

  // MARK: - Stored properties

  /// The type of the group.
  let type: TokenType?

  // MARK: - Init

  init(type: TokenType? = nil) {
    self.type = type
  }
}
