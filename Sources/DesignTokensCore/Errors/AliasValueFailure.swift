import Foundation

/// The possible failures related to alias values.
enum AliasValueFailure: ValueFailure {
  /// The syntax of the reference value is not valid.
  case invalidReferenceSyntax
}

extension AliasValueFailure: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .invalidReferenceSyntax:
      return "The syntax of the reference value is not valid."
    }
  }
}
