import Foundation
import RegexBuilder

/// A type representing a token alias.
struct Alias {

  // MARK: - Stored Properties

  /// The path to the referenced token.
  let path: [String]

  // MARK: - Init

  init(_ stringValue: String) throws(DecodingFailure) {
    let regex = Regex {
      One("{")

      Capture {
        OneOrMore(.word)

        ZeroOrMore {
          "."
          OneOrMore(.word)
        }
      }

      One("}")
    }

    guard let match = stringValue.wholeMatch(of: regex) else {
      throw DecodingFailure.invalidValue(.invalidReferenceSyntax)
    }
    
    let (_, value) = match.output
    self.path = value.components(separatedBy: ".")
  }
}
