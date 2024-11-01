import Foundation
import Testing
@testable import DesignTokensCore

@Suite
struct DesignTokenDecoding {
  private let decoder = JSONDecoder()

  @Test
  func missingTypeFailure() throws {
    let data = try #require(loadJSON(named: "missingTypeFailure"))
    #expect(throws: DecodingFailure.missingType(tokenName: "red", tokenPath: ["colors", "red"])) {
      try decoder.decode(DesignTokenTree.self, from: data)
    }
  }
  
  @Test
  func successfulAliasDecodingWithMissingType() throws {
    let data = try #require(loadJSON(named: "missingTypeWithAlias"))
    let tree = try decoder.decode(DesignTokenTree.self, from: data)

    #expect(tree.root.children.count == 2)
    #expect(tree.root.search(name: "red") != nil)

    let colors = try #require(tree.root.search(name: "colors"))
    #expect(colors.children.count == 1)
  }

  @Test
  func successfulGroupsDecode() throws {
    let data = try #require(loadJSON(named: "groups"))
    let tree = try decoder.decode(DesignTokenTree.self, from: data)

    #expect(tree.root.children.count == 2)
    #expect(tree.root.search(name: "small") != nil)

    let colors = try #require(tree.root.search(name: "colors"))
    #expect(colors.children.count == 3)
  }
}
