import ArgumentParser
import DesignTokensGenerator
import Foundation

@main
struct Generate: ParsableCommand {
  @Option(
    name: [
      .customShort("p"),
      .customLong("path")
    ],
    help: "The path to the configuration JSON file.",
    transform: {
      URL(filePath: $0)
    }
  )
  var configurationURL: URL = URL(filePath: FileManager.default.currentDirectoryPath)

  func run() throws {
    let generator = Generator(configurationURL: configurationURL)
    try generator.generate()
  }
}
