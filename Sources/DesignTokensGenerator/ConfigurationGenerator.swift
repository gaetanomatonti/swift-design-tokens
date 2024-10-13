import Foundation

/// An object that generates a configuration file at the specified path.
package struct ConfigurationGenerator {
  private let fileName: String?

  private let configurationURL: URL

  private let inputPath: String

  private let outputPath: String

  package init(fileName: String?, configurationURL: URL, inputPath: String, outputPath: String) {
    self.fileName = fileName
    self.configurationURL = configurationURL
    self.inputPath = inputPath
    self.outputPath = outputPath
  }

  package func generate() throws {
    let configurationLocator = ConfigurationLocator(fileName: fileName, configurationURL: configurationURL)

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
