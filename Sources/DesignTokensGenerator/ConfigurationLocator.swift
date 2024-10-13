import Foundation

/// An object to locate the configuration file.
struct ConfigurationLocator {

  // MARK: - Stored Properties

  private let fileName: String?

  private let configurationURL: URL

  // MARK: - Computed Properties

  /// The `URL` to the configuration file.
  var fileURL: URL {
    if configurationURL.isDirectory {
      configurationURL
        .appending(path: fileName ?? defaultConfigurationFileName)
        .appendingPathExtension("json")
    } else {
      configurationURL
    }
  }

  /// The `URL` to the directory containing the configuration file.
  var directoryURL: URL {
    if configurationURL.isDirectory {
      configurationURL
    } else {
      configurationURL
        .deletingLastPathComponent()
    }
  }

  // MARK: - Init

  init(fileName: String? = nil, configurationURL: URL) {
    self.fileName = fileName
    self.configurationURL = configurationURL
  }
}
