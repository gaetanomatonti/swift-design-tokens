import Foundation

/// An object that generates a configuration file at the specified path.
package struct ConfigurationGenerator {
  
  // MARK: - Stored Properties
  
  /// The locator for the configuration manifest.
  private let configurationLocator: ConfigurationLocator

  /// The path to the input design tokens file.
  private let inputPath: String

  // MARK: - Init
  
  package init(fileName: String?, configurationURL: URL, inputPath: String) {
    self.configurationLocator = ConfigurationLocator(fileName: fileName, configurationURL: configurationURL)
    self.inputPath = inputPath
  }

  // MARK: - Functions
  
  /// Generates the configuration manifest.
  package func generate() throws {
    let configuration = Configuration.scaffold()

    let encoder = JSONEncoder()
    encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]

    let data = try encoder.encode(configuration)
    try data.write(to: configurationLocator.fileURL)
  }
}
