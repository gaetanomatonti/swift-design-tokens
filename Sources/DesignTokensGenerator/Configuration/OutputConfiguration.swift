import Foundation

/// A type representing the configuration for the output.
struct OutputConfiguration: Equatable {
  enum CodingKeys: String, CodingKey {
    case colorConfiguration = "colors"
    case dimensionConfiguration = "dimensions"
  }
  
  // MARK: - Stored Properties
  
  /// The configuration for the color tokens.
  private(set) var colorConfiguration: ColorConfiguration?
  
  /// The configuration for the dimension tokens.
  private(set) var dimensionConfiguration: DimensionConfiguration?
  
  // MARK: - Init
  
  init() {
    colorConfiguration = nil
    dimensionConfiguration = nil
  }
  
  // MARK: - Functions
  
  /// Creates an output configuration object.
  static func output() -> OutputConfiguration {
    OutputConfiguration()
  }
  
  /// Sets the configuration for the color tokens.
  /// - Parameters:
  ///   - path: The path of the directory where the output will be generated.
  ///   - formats: The formats of the output.
  /// - Returns: The output configuration with a new color configuration.
  func color(path: String, formats: ColorFormat...) -> OutputConfiguration {
    color(ColorConfiguration(path: path, formats: formats))
  }

  /// Sets the configuration for the dimension tokens.
  /// - Parameters:
  ///   - path: The path of the directory where the output will be generated.
  /// - Returns: The output configuration with a new dimension configuration.
  func dimension(path: String) -> OutputConfiguration {
    dimension(DimensionConfiguration(path: path))
  }
  
  private func color(_ configuration: ColorConfiguration) -> OutputConfiguration {
    var output = self
    output.colorConfiguration = configuration
    return output
  }
  
  private func dimension(_ configuration: DimensionConfiguration) -> OutputConfiguration {
    var output = self
    output.dimensionConfiguration = configuration
    return output
  }
}

extension OutputConfiguration: Codable {
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    guard !container.allKeys.isEmpty else {
      throw ConfigurationFailure.noOutputProvided
    }
    
    self.colorConfiguration = try container.decodeIfPresent(ColorConfiguration.self, forKey: .colorConfiguration)
    self.dimensionConfiguration = try container.decodeIfPresent(DimensionConfiguration.self, forKey: .dimensionConfiguration)
  }
  
  func encode(to encoder: any Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encodeIfPresent(self.colorConfiguration, forKey: .colorConfiguration)
    try container.encodeIfPresent(self.dimensionConfiguration, forKey: .dimensionConfiguration)
  }
}
