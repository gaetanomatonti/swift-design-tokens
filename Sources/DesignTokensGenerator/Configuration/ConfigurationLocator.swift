import Foundation

/// An object that locates the configuration file.
struct ConfigurationLocator {

  // MARK: - Stored Properties

  /// The name of the configuration manifest file.
  private let fileName: String?

  /// The `URL` to the configuration manifest.
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
