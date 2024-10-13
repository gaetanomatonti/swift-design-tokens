import Foundation

/// An object that generates a configuration file at the specified path.
package struct ConfigurationGenerator {
  private let configurationURL: URL

  package init(configurationURL: URL) {
    self.configurationURL = configurationURL
  }

  package func generate() throws {}
}
