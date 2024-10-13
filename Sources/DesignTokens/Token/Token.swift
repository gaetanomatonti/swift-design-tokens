import Foundation

/// A protocol defining requirements for a token.
protocol Token {
  /// The name of the token.
  var name: String { get }

  /// The optional description of the token.
  var description: String? { get }

  /// The path to the token.
  ///
  /// If the token is not contained in a group, this array contains only the `name` of the token.
  var path: Path { get }
}
