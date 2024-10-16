import Foundation

/// A type representing the output configuration for dimension tokens.
struct DimensionConfiguration: ConfigurationProtocol, Equatable {
  enum CodingKeys: String, CodingKey {
    case inputPath = "input"
    case outputPath = "output"
  }
  
  // MARK: - Stored Properties
  
  /// The path to the input file.
  let inputPath: String?

  /// The path of the directory where the output will be generated.
  let outputPath: String?

  // MARK: - Init
  
  init(inputPath: String?, outputPath: String?) {
    self.inputPath = inputPath
    self.outputPath = outputPath
  }
}
