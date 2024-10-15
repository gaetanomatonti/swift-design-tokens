import Foundation

/// A type representing the configuration of the tool.
struct Configuration: Codable, Equatable {
  
  // MARK: - Stored Properties
  
  /// The path to the input file.
  let input: String
  
  /// The output configuration.
  let output: OutputConfiguration

  // MARK: - Init
  
  init(_ output: OutputConfiguration, from input: String) {
    self.input = input
    self.output = output
  }
}

extension Configuration {
  /// Creates a default instance for the `Configuration`.
  static func scaffold() -> Configuration {
    Configuration(
      .output()
        .color(
          path: "Output/Colors/",
          formats: .swiftUI
        )
        .dimension(
          path: "Output/Dimensions/"
        )
      ,
      from: "design-tokens.json"
    )
  }
}
