import Foundation

enum ConfigurationFailure: Error {
  case noOutputProvided
}

/// A type representing the configuration of the tool.
struct Configuration: Codable, Equatable {
  /// The path to the input file.
  let input: String
  
  /// The output configuration.
  let output: Output

  init(_ output: Output, from input: String) {
    self.input = input
    self.output = output
  }
}

extension Configuration {
  struct Output: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
      case colorConfiguration = "colors"
      case dimensionConfiguration = "dimensions"
    }
    
    private(set) var colorConfiguration: ColorConfiguration?
    private(set) var dimensionConfiguration: DimensionConfiguration?
    
    init() {
      colorConfiguration = nil
      dimensionConfiguration = nil
    }
    
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
    
    static func output() -> Output {
      Output()
    }
    
    func color(path: String, formats: ColorFormat...) -> Output {
      color(ColorConfiguration(path: path, formats: formats))
    }
    
    func dimension(path: String) -> Output {
      dimension(DimensionConfiguration(path: path))
    }
    
    private func color(_ configuration: ColorConfiguration) -> Output {
      var output = self
      output.colorConfiguration = configuration
      return output
    }
    
    private func dimension(_ configuration: DimensionConfiguration) -> Output {
      var output = self
      output.dimensionConfiguration = configuration
      return output
    }
  }
}
