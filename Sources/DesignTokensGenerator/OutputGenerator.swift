import Foundation

/// An object that generates the output for the specified configuration file.
package struct OutputGenerator {
  private let configurationURL: URL

  package init(configurationURL: URL) {
    self.configurationURL = configurationURL
  }

  package func generate() throws {
    let configurationLocator = ConfigurationLocator(configurationURL: configurationURL)
    let configurationLoader = ConfigurationLoader(using: configurationLocator)
    let configuration = try configurationLoader.load()

    guard
      let input = URL(string: configuration.input, relativeTo: configurationLocator.directoryURL.appending(path: configuration.input)),
      let output = URL(string: configuration.output.path, relativeTo: configurationLocator.directoryURL.appending(path: configuration.output.path))
    else {
      return
    }

    try FileManager.default.createDirectory(at: output, withIntermediateDirectories: true)
    try "test".write(to: output.appending(path: "test").appendingPathExtension("txt"), atomically: false, encoding: .utf8)
  }
}
