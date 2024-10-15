import Foundation

/// The possible errors that can occur with the configuration.
enum ConfigurationFailure: Error {
  /// No output has been provided in the configuration manifest.
  case noOutputProvided
}
