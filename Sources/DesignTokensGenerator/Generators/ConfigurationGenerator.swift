import Foundation

/// An object that generates a configuration file at the specified path.
package struct ConfigurationGenerator {
  
  // MARK: - Stored Properties

  /// The name of the file to generate.
  private let fileName: String

  /// The directory where the configuration manifest will be generated.
  private let configurationOutputURL: URL

  /// The path to the input design tokens file.
  private let inputPaths: [String]

  /// The path to the directory where the tokens' output will be generated.
  private let outputPath: String

  // MARK: - Init
  
  package init(fileName: String, configurationOutputURL: URL, inputPaths: [String], outputPath: String) {
    self.fileName = fileName
    self.configurationOutputURL = configurationOutputURL
    self.inputPaths = inputPaths
    self.outputPath = outputPath
  }

  // MARK: - Functions
  
  /// Generates the configuration manifest.
  package func generate() throws {
    let configuration = Configuration.scaffold(
      inputPaths: inputPaths,
      outputPath: outputPath
    )

    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]

    let data = try encoder.encode(configuration)

    let outputURL = configurationOutputURL
      .appending(path: fileName)
      .appendingPathExtension("json")

    try data.write(to: outputURL)
  }
}
