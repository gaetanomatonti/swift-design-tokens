import Foundation
import Testing
@testable import DesignTokens

@Test func decodeAliasToken() throws {
  let data = try #require(loadJSON(named: "alias"))
  let decoder = JSONDecoder()
  let file = try decoder.decode(TokenFile.self, from: data)

  let expected = TokenFile(
    tokens: [
      Token(name: "primary", value: .alias(["colors", "text"]), path: ["primary"]),
    ],
    groups: [
      Group(
        name: "colors",
        tokens: [
          Token(name: "text", value: .color(Color(red: 0, green: 0, blue: 0, alpha: 1)), path: ["colors", "text"])
        ]
      )
    ]
  )

  #expect(file == expected)
}

@Test func decodeColorToken() throws {
  let data = try #require(loadJSON(named: "color"))
  let decoder = JSONDecoder()
  let file = try decoder.decode(TokenFile.self, from: data)

  let expected = TokenFile(
    tokens: [
      Token(name: "primary", value: .color(Color(red: 1, green: 0, blue: 1, alpha: 1)), path: ["primary"]),
    ],
    groups: []
  )

  #expect(file == expected)
}

@Test func decodeGroups() throws {
  let data = try #require(loadJSON(named: "groups"))
  let decoder = JSONDecoder()
  let file = try decoder.decode(TokenFile.self, from: data)

  let expected = TokenFile(
    tokens: [
      Token(name: "small", value: .dimension(Dimension(8)), path: ["small"]),
    ],
    groups: [
      Group(
        name: "colors",
        nestedGroups: [
          Group(
            name: "background",
            description: "Background colors",
            tokens: [
              Token(name: "base", value: .color(Color(red: 1, green: 1, blue: 1, alpha: 1)), path: ["colors", "background", "base"]),
            ]
          ),
          Group(
            name: "text",
            description: "Text colors",
            tokens: [
              Token(name: "primary", value: .color(Color(red: 0, green: 0, blue: 0, alpha: 1)), path: ["colors", "text", "primary"]),
            ]
          )
        ],
        tokens: [
          Token(name: "red", value: .color(Color(red: 1, green: 0, blue: 0, alpha: 1)), path: ["colors", "red"])
        ]
      )
    ]
  )

  #expect(file.tokens == expected.tokens)
  #expect(file.groups == expected.groups)
}

fileprivate func loadJSON(named fileName: String) -> Data? {
  guard let url = Bundle.module.url(forResource: fileName, withExtension: "json") else {
    return nil
  }

  return try? Data(contentsOf: url)
}
