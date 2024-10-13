import Foundation
import Testing
@testable import DesignTokensGenerator

@Suite
struct ConfigurationCoding {
  @Test
  func jsonDecoding() throws {
    let decoder = JSONDecoder()

    let configuration = Configuration(
      .output(
        at: "../Output",
        with: .sourceCode([.swiftUI])
      ),
      from: "design-tokens.json"
    )

    let data = try #require(loadJSON(named: "configuration"))
    let result = try decoder.decode(Configuration.self, from: data)

    #expect(result == configuration)
  }

  @Test
  func jsonEncoding() throws {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

    let configuration = Configuration(
      .output(
        at: "",
        with: .sourceCode([.swiftUI])
      ),
      from: ""
    )

    let data = try encoder.encode(configuration)
    let json = try #require(String(data: data, encoding: .utf8))
    print(json)
  }

  fileprivate func loadJSON(named fileName: String) -> Data? {
    guard let url = Bundle.module.url(forResource: fileName, withExtension: "json") else {
      return nil
    }

    return try? Data(contentsOf: url)
  }
}
