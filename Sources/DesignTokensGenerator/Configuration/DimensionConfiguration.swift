import Foundation

/// A type representing the output configuration for dimension tokens.
struct DimensionConfiguration: Codable, Equatable {
  
  // MARK: - Stored Properties
  
  /// The path of the directory where the output will be generated.
  let path: String

  // MARK: - Init
  
  init(path: String) {
    self.path = path
  }
}
