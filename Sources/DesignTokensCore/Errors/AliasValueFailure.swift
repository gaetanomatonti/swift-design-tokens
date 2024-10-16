import Foundation

/// The possible failures related to alias values.
enum AliasValueFailure: ValueFailure {
  /// The value of the alias is not a valid token reference.
  case invalidReferenceSyntax
}
