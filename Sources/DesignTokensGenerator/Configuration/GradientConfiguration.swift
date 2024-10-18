import Foundation

/// A type representing the output configuration for gradient tokens.
struct GradientConfiguration: ConfigurationProtocol, Equatable {
  enum CodingKeys: String, CodingKey {
    case inputPaths = "input"
    case outputPath = "output"
  }
  
  // MARK: - Stored Properties
  
  private(set) var inputPaths: [String]?

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

extension GradientConfiguration {
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
