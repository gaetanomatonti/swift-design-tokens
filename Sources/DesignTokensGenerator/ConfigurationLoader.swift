import Foundation

struct ConfigurationLoader {
  private let configurationFileURL: URL

  init(using locator: ConfigurationLocator) {
    configurationFileURL = locator.fileURL
  }

  func load() throws -> Configuration {
    let data = try Data(contentsOf: configurationFileURL)
    let decoder = JSONDecoder()
    return try decoder.decode(Configuration.self, from: data)
  }
}
