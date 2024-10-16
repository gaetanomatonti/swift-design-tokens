import Foundation

/// A type representing the output configuration for color tokens.
struct ColorConfiguration: ConfigurationProtocol, Equatable {
  enum CodingKeys: String, CodingKey {
    case inputPath = "input"
    case outputPath = "output"
    case formats
  }
  
  // MARK: - Stored Properties
  
  /// The path to the input file.
  let inputPath: String?

  /// The path of the directory where the output will be generated.
  let outputPath: String?
  
  /// The formats of the output.
  let formats: [ColorFormat]
  
  // MARK: - Init

  init(inputPath: String?, outputPath: String?, formats: [ColorFormat]) {
    self.inputPath = inputPath
    self.outputPath = outputPath
    self.formats = formats
  }
}
