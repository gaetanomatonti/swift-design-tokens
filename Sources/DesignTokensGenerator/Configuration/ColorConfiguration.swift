import Foundation

/// A type representing the output configuration for color tokens.
struct ColorConfiguration: Codable, Equatable {
  
  // MARK: - Stored Properties
  
  /// The path of the directory where the output will be generated.
  let path: String
  
  /// The formats of the output.
  let formats: [ColorFormat]
  
  // MARK: - Init

  init(path: String, formats: [ColorFormat]) {
    self.path = path
    self.formats = formats
  }
}
