import Foundation

/// A model to facilitate the test of a given system.
struct SUT<Argument, Expected>: Sendable where Argument: Sendable, Expected: Sendable {

  // MARK: - Stored Properties
  
  /// The argument of the test.
  ///
  /// Use this value as the argument of the test.
  let argument: Argument

  /// The value of the result expected in the test.
  let expected: Expected

  // MARK: - Init

  init(_ argument: Argument, expected: Expected) {
    self.argument = argument
    self.expected = expected
  }
}
