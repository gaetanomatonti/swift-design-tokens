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

  @Test func fetchColorTokens() throws {
    let data = try #require(loadJSON(named: "groups"))
    let tree = try decoder.decode(DesignTokenTree.self, from: data)

    let (tokens, aliases) = tree.colorTokens()

    #expect(
      tokens == [
        ColorToken(name: "red", color: Color(red: 1, green: 0, blue: 0, alpha: 1), path: ["colors", "red"]),
        ColorToken(name: "primary", color: Color(red: 0, green: 0, blue: 0, alpha: 1), path: ["colors", "text", "primary"]),
      ]
    )

    #expect(
      aliases == [
        AliasToken(name: "base", path: ["colors", "background", "base"], reference: ["colors", "red"]),
      ]
    )
  }

  @Test func fetchDimensionTokens() throws {
    let data = try #require(loadJSON(named: "groups"))
    let tree = try decoder.decode(DesignTokenTree.self, from: data)

    let (tokens, aliases) = tree.dimensionTokens()

    #expect(
      tokens == [
        DimensionToken(name: "small", dimension: Dimension(8), path: ["small"])
      ]
    )

    #expect(aliases.isEmpty)
  }

  fileprivate func loadJSON(named fileName: String) -> Data? {
    guard let url = Bundle.module.url(forResource: fileName, withExtension: "json") else {
      return nil
    }

    return try? Data(contentsOf: url)
  }
}
