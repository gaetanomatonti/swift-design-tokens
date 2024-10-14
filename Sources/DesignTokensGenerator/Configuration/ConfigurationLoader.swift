import Foundation

struct ConfigurationLoader {
  private let configurationLocator: ConfigurationLocator

  package init(using locator: ConfigurationLocator) {
    self.configurationLocator = locator
  }

  func load() throws -> Configuration {
    let data = try Data(contentsOf: configurationLocator.fileURL)
    let decoder = JSONDecoder()
    return try decoder.decode(Configuration.self, from: data)
  }
}
