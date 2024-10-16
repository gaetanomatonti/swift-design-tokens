import Foundation
import RegexBuilder

/// A type representing a dimension.
package struct Dimension {

  // MARK: - Stored Properties

  /// The value of the dimension.
  let value: Double

  // MARK: - Init

  init(_ value: Double) {
    self.value = value
  }

  init(_ valueString: String) throws(DimensionValueFailure) {
    let regex = Regex {
      Capture {
        OneOrMore(.digit)
      } transform: {
        Double($0)
      }

      ZeroOrMore(.whitespace)

      ChoiceOf {
        "px"
        "rem"
      }
    }

    guard let match = valueString.wholeMatch(of: regex) else {
      throw .invalidStringValue
    }

    let (_, value) = match.output
    guard let value else {
      throw .invalidValue
    }

    self.value = value
  }
}

extension Dimension: Equatable {}
