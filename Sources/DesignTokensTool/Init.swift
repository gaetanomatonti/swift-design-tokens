import ArgumentParser
import DesignTokensGenerator
import Foundation

struct Init: ParsableCommand {
  static let configuration = CommandConfiguration(abstract: "Initializes the configuration for a set of Design Tokens.")

  @Option(
    name: [
      .customShort("p"),
      .customLong("path")
    ],
    help: """
      The path to the folder where the configuration file will be generated.
      If none is provided, the file will be generated in the current directory.
    """,
    transform: {
      URL(filePath: $0)
    }
  )
  var configurationURL: URL = URL(filePath: FileManager.default.currentDirectoryPath)

  func run() throws {
    let configurationGenerator = ConfigurationGenerator(configurationURL: configurationURL)
    try configurationGenerator.generate()
  }
}
