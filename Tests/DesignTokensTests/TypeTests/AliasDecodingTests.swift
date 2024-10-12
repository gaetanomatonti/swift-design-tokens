import Foundation
import Testing
@testable import DesignTokens

@Suite
struct AliasDecoding {
  @Test(
    arguments: [
      "",
      "group.token",
      "group.token.",
    ]
  )
  func invalidReferenceSyntaxFailure(reference: String) {
    #expect(throws: DecodingFailure.invalidValue(.invalidReferenceSyntax)) {
      try Alias(reference)
    }
  }

  @Test(
    arguments: [
      SUT("{group}", expected: ["group"]),
      SUT("{group.token}", expected: ["group", "token"]),
      SUT("{group.token.name}", expected: ["group", "token", "name"]),
    ]
  )
  func successfulAliasDecoding(reference: SUT<String, [String]>) throws {
    let alias = try Alias(reference.argument)
    #expect(alias.path == reference.expected)
  }
}
