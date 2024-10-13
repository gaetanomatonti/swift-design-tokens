import Foundation

/// An object that generates a configuration file at the specified path.
package struct ConfigurationGenerator {
  private let configurationLocator: ConfigurationLocator

  private let inputPath: String

  private let outputPath: String

  package init(fileName: String?, configurationURL: URL, inputPath: String, outputPath: String) {
    self.configurationLocator = ConfigurationLocator(fileName: fileName, configurationURL: configurationURL)
    self.inputPath = inputPath
    self.outputPath = outputPath
  }

  package func generate() throws {
    let configuration = Configuration(
      .output(at: outputPath, with: .sourceCode([.swiftUI])),
      from: inputPath
    )

    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]

    let data = try encoder.encode(configuration)
    try data.write(to: configurationLocator.fileURL)
  }
}
