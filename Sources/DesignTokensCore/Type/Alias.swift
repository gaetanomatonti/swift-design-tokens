import Foundation
import RegexBuilder

/// A type representing a token alias.
struct Alias {

  // MARK: - Stored Properties

  /// The path to the referenced token.
  let reference: Path

  // MARK: - Init

  init(reference: Path) {
    self.reference = reference
  }

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
    self.reference = value.components(separatedBy: ".")
  }
}

extension Alias: Decodable {
  init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self)
    
    try self.init(stringValue)
  }
}

extension Alias: Equatable {}
