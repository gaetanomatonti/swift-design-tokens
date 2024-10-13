import Foundation
import Testing
@testable import DesignTokensGenerator

@Suite
struct ConfigurationCoding {
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
}
