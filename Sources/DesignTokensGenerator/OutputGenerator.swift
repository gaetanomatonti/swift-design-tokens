import DesignTokensCore
import Foundation
import Stencil

/// An object that generates the output for the specified configuration file.
package struct OutputGenerator {
  private let configurationLocator: ConfigurationLocator

  package init(configurationURL: URL) {
    self.configurationLocator = ConfigurationLocator(configurationURL: configurationURL)
  }

  package func generate() throws {
    let configurationLoader = ConfigurationLoader(using: configurationLocator)
    let configuration = try configurationLoader.load()

    guard
      let inputURL = URL(string: configuration.input, relativeTo: configurationLocator.directoryURL.appending(path: configuration.input)),
      let outputURL = URL(string: configuration.output.path, relativeTo: configurationLocator.directoryURL.appending(path: configuration.output.path))
    else {
      return
    }

    let designTokensDecoder = DesignTokensDecoder(inputURL: inputURL)
    let tokens = try designTokensDecoder.decode()

    try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: true)

    switch configuration.output.format {
    case let .sourceCode(frameworks):
      let sourceCodeGenerator = SourceCodeGenerator(
        tokens: [
          ColorToken(name: "black", description: nil, color: .black, path: ["black"]),
          ColorToken(name: "red", description: "Red color", color: .red, path: ["red"]),
        ],
        frameworks: frameworks
      )
      let files = try sourceCodeGenerator.generate()

      for file in files {
        let outputFileURL = outputURL
          .appending(path: file.name)

        try file.content.write(to: outputFileURL, atomically: false, encoding: .utf8)
      }
    }
  }
}
