import Foundation
import RegexBuilder

struct Dimension {
  let value: Double

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

      Optionally {
        OneOrMore(.whitespace)
      }

      ChoiceOf {
        "px"
        "rem"
      }
    }

    guard let match = valueString.wholeMatch(of: regex) else {
      throw DecodingFailure.invalidValue(.invalidDimensionString)
    }

    guard let value = match.output.1 else {
      throw DecodingFailure.invalidValue(.invalidDimensionValue)
    }

    self.value = value
  }
}

extension Dimension: Equatable {}
