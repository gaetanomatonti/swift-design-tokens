import Foundation

/// A type representing a dimension token.
package struct DimensionToken: Token {
  /// The name of the token.
  let name: String

  /// The optional description of the token.
  let description: String?

  /// The value of the token.
  let dimension: Dimension

  /// The path to the token.
  ///
  /// If the token is not contained in a group, this array contains only the `name` of the token.
  let path: [String]

  init(name: String, description: String? = nil, dimension: Dimension, path: [String]) {
    self.name = name
    self.description = description
    self.dimension = dimension
    self.path = path
  }
}
