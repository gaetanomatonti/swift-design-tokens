import Foundation
import Testing
@testable import DesignTokensGenerator

@Suite
struct ConfigurationGeneratorTests {
  @Test
  func configurationManifestGeneration() throws {
    let directoryURL = FileManager.default.temporaryDirectory
    
    let configurationGenerator = ConfigurationGenerator(
      fileName: "configuration",
      configurationURL: directoryURL,
      inputPaths: ["design-tokens.json"],
      outputPath: "Output/"
    )
    try configurationGenerator.generate()
    
    let outputURL = directoryURL
      .appending(path: "configuration")
      .appendingPathExtension("json")
    
    let fileExists = FileManager.default.fileExists(atPath: outputURL.path())
    
    #expect(fileExists)
    
    let configurationLocator = ConfigurationLocator(configurationURL: outputURL)
    let configurationLoader = ConfigurationLoader(using: configurationLocator)
    
    #expect(throws: Never.self) {
      try configurationLoader.load()
    }
  }
}
