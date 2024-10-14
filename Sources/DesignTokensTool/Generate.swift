import ArgumentParser
import DesignTokensGenerator
import Foundation

struct Generate: ParsableCommand {
  static let configuration = CommandConfiguration(abstract: "Generates the output files for a set of design tokens.")

  @Option(
    name: [
      .customShort("p"),
      .customLong("path")
    ],
    help: """
      The path to the tool configuration file.
      If none is provided, the tool will look for the file in the current directory.
    """,
    transform: {
      URL(filePath: $0)
    }
  )
  var configurationURL: URL = URL(filePath: FileManager.default.currentDirectoryPath)

  func run() throws {
    let generator = OutputGenerator(configurationURL: configurationURL)
    try generator.generate()
  }
}