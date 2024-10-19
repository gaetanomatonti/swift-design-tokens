import ArgumentParser
import DesignTokensGenerator
import Foundation

struct Init: ParsableCommand {
  static let configuration = CommandConfiguration(abstract: "Initializes the configuration for a set of Design Tokens.")

  @Option(
    name: .shortAndLong,
    help: "The name of the configuration file."
  )
  var name: String = defaultConfigurationFileName

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
  var configurationOutputURL: URL = URL(filePath: FileManager.default.currentDirectoryPath)

  @Option(
    name: [
      .customShort("i"),
      .customLong("input")
    ],
    help: "The path to the design tokens JSON file."
  )
  var inputPaths: [String] = ["design-tokens.json"]

  @Option(
    name: [
      .customShort("o"),
      .customLong("output")
    ],
    help: "The path to the directory where the output will be generated."
  )
  var outputPath: String = "Output/"

  func run() throws {
    let configurationGenerator = ConfigurationGenerator(
      fileName: name,
      configurationOutputURL: configurationOutputURL,
      inputPaths: inputPaths,
      outputPath: outputPath
    )
    try configurationGenerator.generate()
  }
}
