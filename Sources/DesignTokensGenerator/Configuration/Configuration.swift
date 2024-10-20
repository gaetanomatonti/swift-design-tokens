import Foundation

/// A type representing the configuration of the tool.
struct Configuration: ConfigurationProtocol, Equatable {
  enum CodingKeys: String, CodingKey {
    case inputPaths = "input"
    case outputPath = "output"
    case colorConfiguration = "colors"
    case dimensionConfiguration = "dimensions"
    case gradientConfiguration = "gradients"
    case numberConfiguration = "numbers"
  }
  
  // MARK: - Stored Properties
  
  private(set) var inputPaths: [String]?
    
  private(set) var outputPath: String?
    
  // MARK: - Stored Properties
  
  /// The configuration for the color tokens.
  private(set) var colorConfiguration: ColorConfiguration?
  
  /// The configuration for the dimension tokens.
  private(set) var dimensionConfiguration: DimensionConfiguration?

  /// The configuration for the gradient tokens.
  private(set) var gradientConfiguration: GradientConfiguration?

  /// The configuration for the number tokens.
  private(set) var numberConfiguration: NumberConfiguration?

  // MARK: - Init

  init() {
    self.inputPaths = nil
    self.outputPath = nil
    self.colorConfiguration = nil
    self.dimensionConfiguration = nil
    self.gradientConfiguration = nil
    self.numberConfiguration = nil
  }
  
  // MARK: - Functions
  
  /// Sets the path of the global input file.
  /// - Parameter path: The path of the input file.
  /// - Returns: The configuration with an input.
  func input(_ path: String) -> Configuration {
    var configuration = self
    
    if configuration.inputPaths == nil {
      configuration.inputPaths = []
    }

    configuration.inputPaths?.append(path)
    return configuration
  }
  
  /// Sets the paths of the global input files.
  /// - Parameter path: The paths of the input files.
  /// - Returns: The configuration with some inputs.
  func inputs(_ paths: [String]) -> Configuration {
    var configuration = self
    
    if configuration.inputPaths == nil {
      configuration.inputPaths = []
    }
    
    configuration.inputPaths?.append(contentsOf: paths)
    return configuration
  }
  
  /// Sets the paths of the global output directory.
  /// - Parameter path: The path of the output directory.
  /// - Returns: The configuration with an output.
  func output(_ path: String) -> Configuration {
    var configuration = self
    configuration.outputPath = path
    return configuration
  }
    
  /// Sets the configuration for the color tokens.
  /// - Parameters:
  ///   - inputPath: The path of the input file.
  ///   - outputPath: The path of the directory where the output will be generated.
  ///   - formats: The formats of the output.
  /// - Returns: The output configuration with a new color configuration.
  func color(inputPath: String , outputPath: String? = nil, formats: ColorFormat...) -> Configuration {
    color(ColorConfiguration(inputPaths: [inputPath], outputPath: outputPath, formats: formats))
  }

  /// Sets the configuration for the color tokens.
  /// - Parameters:
  ///   - inputPaths: The path of the input files.
  ///   - outputPath: The path of the directory where the output will be generated.
  ///   - formats: The formats of the output.
  /// - Returns: The output configuration with a new color configuration.
  func color(inputPaths: [String]? = nil , outputPath: String? = nil, formats: ColorFormat...) -> Configuration {
    color(ColorConfiguration(inputPaths: inputPaths, outputPath: outputPath, formats: formats))
  }

  /// Sets the configuration for the dimension tokens.
  /// - Parameters:
  ///   - path: The path of the directory where the output will be generated.
  /// - Returns: The output configuration with a new dimension configuration.
  func dimension(inputPath: String, outputPath: String? = nil) -> Configuration {
    dimension(DimensionConfiguration(inputPaths: [inputPath], outputPath: outputPath))
  }

  /// Sets the configuration for the dimension tokens.
  /// - Parameters:
  ///   - inputPaths: The path of the input files.
  ///   - outputPath: The path of the directory where the output will be generated.
  /// - Returns: The output configuration with a new dimension configuration.
  func dimension(inputPaths: [String]? = nil , outputPath: String? = nil) -> Configuration {
    dimension(DimensionConfiguration(inputPaths: inputPaths, outputPath: outputPath))
  }

  /// Sets the configuration for the gradient tokens.
  /// - Parameters:
  ///   - path: The path of the directory where the output will be generated.
  /// - Returns: The output configuration with a new dimension configuration.
  func gradient(inputPath: String, outputPath: String? = nil) -> Configuration {
    gradient(GradientConfiguration(inputPaths: [inputPath], outputPath: outputPath))
  }

  /// Sets the configuration for the gradient tokens.
  /// - Parameters:
  ///   - inputPaths: The path of the input files.
  ///   - outputPath: The path of the directory where the output will be generated.
  /// - Returns: The output configuration with a new dimension configuration.
  func gradient(inputPaths: [String]? = nil , outputPath: String? = nil) -> Configuration {
    gradient(GradientConfiguration(inputPaths: inputPaths, outputPath: outputPath))
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
  
  private func gradient(_ gradientConfiguration: GradientConfiguration) -> Configuration {
    var configuration = self
    configuration.gradientConfiguration = gradientConfiguration
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
    self.gradientConfiguration = try container.decodeIfPresent(GradientConfiguration.self, forKey: .gradientConfiguration)
    self.numberConfiguration = try container.decodeIfPresent(NumberConfiguration.self, forKey: .numberConfiguration)
  }
}

extension Configuration {
  /// Creates a default instance for the `Configuration`.
  static func scaffold(inputPaths: [String], outputPath: String) -> Configuration {
    Configuration()
      .inputs(inputPaths)
      .output(outputPath)
      .color(
        formats: .swiftUI, .uiKit
      )
      .dimension()
  }
}
