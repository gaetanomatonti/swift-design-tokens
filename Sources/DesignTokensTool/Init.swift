import ArgumentParser
import DesignTokensGenerator
import Foundation

struct Init: ParsableCommand {
  static let configuration = CommandConfiguration(abstract: "Initializes the configuration for a set of Design Tokens.")

  @Option(
    name: .shortAndLong,
    help: "The name of the configuration file. (default: \(defaultConfigurationFileName)"
  )
  var name: String?

  @Option(
    name: [
      .customShort("p"),
      .customLong("path")
    ],
    help: "The path to the folder where the configuration file will be generated. (default: current directory)",
    transform: {
      URL(filePath: $0)
    }
  )
  var configurationURL: URL = URL(filePath: FileManager.default.currentDirectoryPath)

  @Option(
    name: [
      .customShort("i"),
      .customLong("input")
    ],
    help: "The path to the design tokens JSON file."
  )
  var inputPath: String

  @Option(
    name: [
      .customShort("o"),
      .customLong("output")
    ],
    help: "The path to the folder where the output files will be generated (default: current directory)"
  )
  var outputPath: String = URL(filePath: FileManager.default.currentDirectoryPath).relativePath

  func run() throws {
    let configurationGenerator = ConfigurationGenerator(
      fileName: name,
      configurationURL: configurationURL,
      inputPath: inputPath,
      outputPath: outputPath
    )
    try configurationGenerator.generate()
  }
}
