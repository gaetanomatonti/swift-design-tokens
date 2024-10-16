import Foundation
import Testing
@testable import DesignTokensCore

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
    #expect(throws: AliasValueFailure.invalidReferenceSyntax) {
      try Alias(reference)
    }
  }

  @Test(
    arguments: [
      SUT("{group}", expected: ["group"]),
      SUT("{group.token}", expected: ["group", "token"]),
      SUT("{group.token.name}", expected: ["group", "token", "name"]),
      SUT("{group.color-50}", expected: ["group", "color-50"]),
    ]
  )
  func successfulAliasDecoding(reference: SUT<String, [String]>) throws {
    let alias = try Alias(reference.argument)
    #expect(alias.path == reference.expected)
  }
}
