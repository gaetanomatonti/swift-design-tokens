import Foundation

/// An object that locates the configuration file.
package struct ConfigurationLocator {

  // MARK: - Stored Properties

  /// The `URL` to the configuration manifest.
  let manifestURL: URL

  // MARK: - Computed Properties

  /// The `URL` to the directory containing the configuration file.
  var directoryURL: URL {
    manifestURL
      .deletingLastPathComponent()
  }

  // MARK: - Init

  package init(configurationManifestURL: URL) throws {
    guard configurationManifestURL.pathExtension == "json" else {
      throw Failure.invalidManifestURL
    }
    
    self.manifestURL = configurationManifestURL
  }
}

extension ConfigurationLocator {
  enum Failure: Error {
    /// The `URL` is not a valid configuration manifest URL.
    case invalidManifestURL
  }
}

extension ConfigurationLocator.Failure: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .invalidManifestURL:
      return "The URL is not a valid configuration manifest URL."
    }
  }
}
