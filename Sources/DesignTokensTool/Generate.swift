import ArgumentParser
import DesignTokensGenerator
import Foundation

struct Generate: ParsableCommand {
  static let configuration = CommandConfiguration(abstract: "Generates the output files for a set of design tokens.")

  @Option(
    name: [
      .customShort("c"),
      .customLong("configuration")
    ],
    help: """
      The path to the tool configuration file.
      If none is provided, the tool will look for the file in the current directory.
    """,
    transform: {
      URL(filePath: $0)
    }
  )
  var configurationManifestURL: URL = URL(filePath: FileManager.default.currentDirectoryPath)

  func run() throws {
    let configurationLocator = try ConfigurationLocator(configurationManifestURL: configurationManifestURL)

    let generator = OutputGenerator(using: configurationLocator)
    try generator.generate()
  }
}
