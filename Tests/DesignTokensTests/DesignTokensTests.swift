import Foundation
import Testing
@testable import DesignTokens

@Test func decodeColorToken() throws {
  let data = try #require(loadJSON(named: "color_token"))
  let decoder = JSONDecoder()
  let file = try decoder.decode(TokenFile.self, from: data)

  let expected = TokenFile(
    tokens: [
      TokenFile.Token(name: "primary", value: "#FF00FF", type: .color, path: ["primary"]),
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
      TokenFile.Token(name: "small", value: "8 px", type: .dimension, path: ["small"]),
    ],
    groups: [
      TokenFile.Group(
        name: "colors",
        type: .color,
        groups: [
          TokenFile.Group(
            name: "background",
            description: "Background colors",
            type: .color,
            tokens: [
              TokenFile.Token(name: "base", value: "#FFFFFF", type: .color, path: ["colors", "background", "base"]),
            ]
          ),
          TokenFile.Group(
            name: "text",
            description: "Text colors",
            type: .color,
            tokens: [
              TokenFile.Token(name: "primary", value: "#000000", type: .color, path: ["colors", "text", "primary"]),
            ]
          )
        ],
        tokens: [
          TokenFile.Token(name: "red", value: "#FF0000", type: .color, path: ["colors", "red"])
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
