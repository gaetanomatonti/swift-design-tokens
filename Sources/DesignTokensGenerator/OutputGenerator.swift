import Foundation

/// An object that generates the output for the specified configuration file.
package struct OutputGenerator {
  private let configurationURL: URL

  package init(configurationURL: URL) {
    self.configurationURL = configurationURL
  }

  package func generate() throws {}
}
