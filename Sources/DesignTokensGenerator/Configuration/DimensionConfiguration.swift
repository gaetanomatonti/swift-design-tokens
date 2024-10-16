import Foundation

/// A type representing the output configuration for dimension tokens.
struct DimensionConfiguration: ConfigurationProtocol, Equatable {
  enum CodingKeys: String, CodingKey {
    case inputPaths = "input"
    case outputPath = "output"
  }
  
  // MARK: - Stored Properties
  
  /// The path to the input file.
  private(set) var inputPaths: [String]?

  /// The path of the directory where the output will be generated.
  private(set) var outputPath: String?

  // MARK: - Init
  
  init(inputPath: String, outputPath: String?) {
    self.inputPaths = [inputPath]
    self.outputPath = outputPath
  }
  
  init(inputPaths: [String]?, outputPath: String?) {
    self.inputPaths = inputPaths
    self.outputPath = outputPath
  }
}

extension DimensionConfiguration {
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    do {
      if let inputPath = try container.decodeIfPresent(String.self, forKey: .inputPaths) {
        self.inputPaths = [inputPath]
      }
    } catch DecodingError.typeMismatch {
      if let inputPaths = try container.decodeIfPresent([String].self, forKey: .inputPaths) {
        self.inputPaths = inputPaths
      }
    }

    self.outputPath = try container.decodeIfPresent(String.self, forKey: .outputPath)
  }
}
