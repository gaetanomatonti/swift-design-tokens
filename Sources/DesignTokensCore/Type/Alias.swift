import Foundation
import RegexBuilder

/// A type representing a token alias.
struct Alias {

  // MARK: - Stored Properties

  /// The path to the referenced token.
  let path: [String]

  // MARK: - Init

  init(_ stringValue: String) throws(AliasValueFailure) {
    let allowedNameCharacters: CharacterClass = .word.union(.digit).union(.generalCategory(.dashPunctuation))
    
    let regex = Regex {
      One("{")

      Capture {
        OneOrMore(allowedNameCharacters)

        ZeroOrMore {
          "."
          OneOrMore(allowedNameCharacters)
        }
      }

      One("}")
    }

    guard let match = stringValue.wholeMatch(of: regex) else {
      throw .invalidReferenceSyntax
    }
    
    let (_, value) = match.output
    self.path = value.components(separatedBy: ".")
  }
}
