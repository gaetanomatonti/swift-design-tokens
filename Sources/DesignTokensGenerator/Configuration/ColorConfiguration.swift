import Foundation

/// A type representing the output configuration for color tokens.
struct ColorConfiguration: ConfigurationProtocol, Equatable {
  enum CodingKeys: String, CodingKey {
    case inputPaths = "input"
    case outputPath = "output"
    case formats
  }
  
  // MARK: - Stored Properties
  
  /// The path to the input file.
  private(set) var inputPaths: [String]?

  /// The path of the directory where the output will be generated.
  private(set) var outputPath: String?
  
  /// The formats of the output.
  private(set) var formats: [ColorFormat]
  
  // MARK: - Init

  init(inputPath: String, outputPath: String?, formats: [ColorFormat]) {
    self.inputPaths = [inputPath]
    self.outputPath = outputPath
    self.formats = formats
  }

  init(inputPaths: [String]?, outputPath: String?, formats: [ColorFormat]) {
    self.inputPaths = inputPaths
    self.outputPath = outputPath
    self.formats = formats
  }
}

extension ColorConfiguration {
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
    self.formats = try container.decode([ColorFormat].self, forKey: .formats)
  }
}
