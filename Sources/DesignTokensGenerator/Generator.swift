import Foundation

package struct Generator {
  private let configurationURL: URL

  package init(configurationURL: URL) {
    self.configurationURL = configurationURL
  }

  package func generate() throws {}
}
