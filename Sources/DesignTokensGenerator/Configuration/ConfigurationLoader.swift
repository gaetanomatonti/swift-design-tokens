import Foundation

/// An object that loads, and decodes the configuration manifest.
struct ConfigurationLoader {
  
  // MARK: - Stored Properties
  
  /// The locator of the configuration manifest.
  private let configurationLocator: ConfigurationLocator

  // MARK: - Init
  
  package init(using locator: ConfigurationLocator) {
    self.configurationLocator = locator
  }
  
  // MARK: - Functions

  /// Loads, and decodes the configuration manifest.
  /// - Returns: The decoded configuration manifest.
  func load() throws -> Configuration {
    let data = try Data(contentsOf: configurationLocator.fileURL)
    let decoder = JSONDecoder()
    return try decoder.decode(Configuration.self, from: data)
  }
}
