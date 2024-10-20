import Foundation

/// A type representing a number token.
package struct NumberToken: Token {
  /// The name of the token.
  let name: String

  /// The optional description of the token.
  let description: String?

  /// The value of the token.
  let number: CGFloat

  /// The path to the token.
  ///
  /// If the token is not contained in a group, this array contains only the `name` of the token.
  let path: [String]

  init(name: String, description: String? = nil, number: CGFloat, path: [String]) {
    self.name = name
    self.description = description
    self.number = number
    self.path = path
  }
}
