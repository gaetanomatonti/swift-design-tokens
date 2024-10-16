import Foundation

/// A type representing the configuration of the tool.
struct Configuration: ConfigurationProtocol, Equatable {
  enum CodingKeys: String, CodingKey {
    case inputPaths = "input"
    case outputPath = "output"
    case colorConfiguration = "colors"
    case dimensionConfiguration = "dimensions"
  }
  
  // MARK: - Stored Properties
  
  /// The path to the input file.
  private(set) var inputPaths: [String]?
    
  /// The path to the output directory.
  private(set) var outputPath: String?
    
  // MARK: - Stored Properties
  
  /// The configuration for the color tokens.
  private(set) var colorConfiguration: ColorConfiguration?
  
  /// The configuration for the dimension tokens.
  private(set) var dimensionConfiguration: DimensionConfiguration?

  // MARK: - Init

  init() {
    self.inputPaths = nil
    self.outputPath = nil
    self.colorConfiguration = nil
    self.dimensionConfiguration = nil
  }
  
  // MARK: - Functions
  
  func input(_ path: String) -> Configuration {
    var configuration = self
    
    if configuration.inputPaths == nil {
      configuration.inputPaths = []
    }

    configuration.inputPaths?.append(path)
    return configuration
  }
  
  func inputs(_ paths: [String]) -> Configuration {
    var configuration = self
    
    if configuration.inputPaths == nil {
      configuration.inputPaths = []
    }
    
    configuration.inputPaths?.append(contentsOf: paths)
    return configuration
  }
  
  func output(_ path: String) -> Configuration {
    var configuration = self
    configuration.outputPath = path
    return configuration
  }
    
  /// Sets the configuration for the color tokens.
  /// - Parameters:
  ///   - path: The path of the directory where the output will be generated.
  ///   - formats: The formats of the output.
  /// - Returns: The output configuration with a new color configuration.
  func color(inputPath: String , outputPath: String? = nil, formats: ColorFormat...) -> Configuration {
    color(ColorConfiguration(inputPaths: [inputPath], outputPath: outputPath, formats: formats))
  }

  /// Sets the configuration for the dimension tokens.
  /// - Parameters:
  ///   - path: The path of the directory where the output will be generated.
  /// - Returns: The output configuration with a new dimension configuration.
  func dimension(inputPath: String, outputPath: String? = nil) -> Configuration {
    dimension(DimensionConfiguration(inputPaths: [inputPath], outputPath: outputPath))
  }
  
  /// Sets the configuration for the color tokens.
  /// - Parameters:
  ///   - path: The path of the directory where the output will be generated.
  ///   - formats: The formats of the output.
  /// - Returns: The output configuration with a new color configuration.
  func color(inputPaths: [String]? = nil , outputPath: String? = nil, formats: ColorFormat...) -> Configuration {
    color(ColorConfiguration(inputPaths: inputPaths, outputPath: outputPath, formats: formats))
  }

  /// Sets the configuration for the dimension tokens.
  /// - Parameters:
  ///   - path: The path of the directory where the output will be generated.
  /// - Returns: The output configuration with a new dimension configuration.
  func dimension(inputPaths: [String]? = nil , outputPath: String? = nil) -> Configuration {
    dimension(DimensionConfiguration(inputPaths: inputPaths, outputPath: outputPath))
  }
  
  private func color(_ colorConfiguration: ColorConfiguration) -> Configuration {
    var configuration = self
    configuration.colorConfiguration = colorConfiguration
    return configuration
  }
  
  private func dimension(_ dimensionConfiguration: DimensionConfiguration) -> Configuration {
    var configuration = self
    configuration.dimensionConfiguration = dimensionConfiguration
    return configuration
  }
}

extension Configuration {
  init(from decoder: any Decoder) throws {
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
    self.colorConfiguration = try container.decodeIfPresent(ColorConfiguration.self, forKey: .colorConfiguration)
    self.dimensionConfiguration = try container.decodeIfPresent(DimensionConfiguration.self, forKey: .dimensionConfiguration)
  }
}

extension Configuration {
  /// Creates a default instance for the `Configuration`.
  static func scaffold() -> Configuration {
    Configuration()
      .input("design-tokens.json")
      .output("Output/")
      .color(
        formats: .swiftUI, .uiKit
      )
      .dimension()
  }
}
