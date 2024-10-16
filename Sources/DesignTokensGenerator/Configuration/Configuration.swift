import Foundation

/// A type representing the configuration of the tool.
struct Configuration: ConfigurationProtocol, Codable, Equatable {
  enum CodingKeys: String, CodingKey {
    case inputPath = "input"
    case outputPath = "output"
    case colorConfiguration = "colors"
    case dimensionConfiguration = "dimensions"
  }
  
  // MARK: - Stored Properties
  
  /// The path to the input file.
  private(set) var inputPath: String?
    
  /// The path to the output directory.
  private(set) var outputPath: String?
    
  // MARK: - Stored Properties
  
  /// The configuration for the color tokens.
  private(set) var colorConfiguration: ColorConfiguration?
  
  /// The configuration for the dimension tokens.
  private(set) var dimensionConfiguration: DimensionConfiguration?

  // MARK: - Init

  init() {
    self.inputPath = nil
    self.outputPath = nil
    self.colorConfiguration = nil
    self.dimensionConfiguration = nil
  }
  
  // MARK: - Functions
  
  func input(_ path: String) -> Configuration {
    var configuration = self
    configuration.inputPath = path
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
  func color(inputPath: String? = nil , outputPath: String? = nil, formats: ColorFormat...) -> Configuration {
    color(ColorConfiguration(inputPath: inputPath, outputPath: outputPath, formats: formats))
  }

  /// Sets the configuration for the dimension tokens.
  /// - Parameters:
  ///   - path: The path of the directory where the output will be generated.
  /// - Returns: The output configuration with a new dimension configuration.
  func dimension(inputPath: String? = nil , outputPath: String? = nil) -> Configuration {
    dimension(DimensionConfiguration(inputPath: inputPath, outputPath: outputPath))
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
