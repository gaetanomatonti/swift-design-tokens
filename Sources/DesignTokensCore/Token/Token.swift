import Foundation

/// A protocol defining requirements for a token.
protocol Token: Equatable {
  /// The name of the token.
  var name: String { get }

  /// The optional description of the token.
  var description: String? { get }

  /// The path to the token.
  ///
  /// If the token is not contained in a group, this array contains only the `name` of the token.
  var path: Path { get }
}

extension Array where Element: Token {
  mutating func sort() {
    sort {
      guard $0.path.count != $1.path.count else {
        return $0.path.lexicographicallyPrecedes($1.path)
      }
      
      return $0.path.count < $1.path.count
    }
  }
}
