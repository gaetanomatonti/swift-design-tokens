import Foundation
import RegexBuilder

/// A type representing a dimension.
struct Dimension {

  // MARK: - Stored Properties

  /// The value of the dimension.
  let value: Double

  // MARK: - Init

  init(_ value: Double) {
    self.value = value
  }

  init(_ valueString: String) throws {
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
      throw DecodingFailure.invalidValue(.invalidDimensionString)
    }

    let (_, value) = match.output
    guard let value else {
      throw DecodingFailure.invalidValue(.invalidDimensionValue)
    }

    self.value = value
  }
}

extension Dimension: Equatable {}
