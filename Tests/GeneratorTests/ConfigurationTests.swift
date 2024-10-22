import Foundation
import Testing
@testable import DesignTokensGenerator

@Suite
struct ConfigurationTests {
  @Test
  func configuration() throws {
    let configuration = Configuration()
      .input("design-tokens.json")
      .output("Output/")
      .color(
        inputPath: "design-tokens-colors.json",
        outputPath: "Output/Colors/"
      )
      .dimension(
        inputPath: "design-tokens-dimensions.json",
        outputPath: "Output/Dimensions/"
      )
      .gradient(
        inputPath: "design-tokens-gradients.json",
        outputPath: "Output/Gradients/"
      )

    #expect(configuration.inputPaths == ["design-tokens.json"])
    #expect(configuration.outputPath == "Output/")
    #expect(configuration.colorConfiguration == ColorConfiguration(inputPath: "design-tokens-colors.json", outputPath: "Output/Colors/"))
    #expect(configuration.dimensionConfiguration == DimensionConfiguration(inputPath: "design-tokens-dimensions.json", outputPath: "Output/Dimensions/"))
    #expect(configuration.gradientConfiguration == GradientConfiguration(inputPath: "design-tokens-gradients.json", outputPath: "Output/Gradients/"))
  }
  
  @Test
  func jsonDecoding() throws {
    let decoder = JSONDecoder()

    let configuration = Configuration()
      .input("design-tokens.json")
      .output("Output/")
      .color(
        inputPath: "design-tokens-colors.json",
        outputPath: "Output/Colors/"
      )
      .dimension(
        inputPath: "design-tokens-dimensions.json",
        outputPath: "Output/Dimensions/"
      )
      .gradient(
        inputPath: "design-tokens-gradients.json",
        outputPath: "Output/Gradients/"
      )

    let data = try #require(loadJSON(named: "configuration"))
    
    #expect(throws: Never.self) {
      let result = try decoder.decode(Configuration.self, from: data)
      #expect(result == configuration)
    }
  }

  @Test
  func jsonEncoding() throws {
    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

    let configuration = Configuration()
      .input("design-tokens.json")
      .output("Output/")
      .color(
        inputPath: "design-tokens-colors.json",
        outputPath: "Output/Colors/"
      )
      .dimension(
        inputPath: "design-tokens-dimensions.json",
        outputPath: "Output/Dimensions/"
      )
      .gradient(
        inputPath: "design-tokens-gradients.json",
        outputPath: "Output/Gradients/"
      )

    #expect(throws: Never.self) {
    let data = try encoder.encode(configuration)

    let decoder = JSONDecoder()

      let result = try decoder.decode(Configuration.self, from: data)
      #expect(result == configuration)
    }
  }

  fileprivate func loadJSON(named fileName: String) -> Data? {
    guard let url = Bundle.module.url(forResource: fileName, withExtension: "json") else {
      return nil
    }

    return try? Data(contentsOf: url)
  }
}
