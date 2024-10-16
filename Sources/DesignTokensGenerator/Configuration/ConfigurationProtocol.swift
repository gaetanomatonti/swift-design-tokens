import Foundation

/// A protocol defining requirements for a global, or token-specific configuration.
protocol ConfigurationProtocol: Codable {
  /// The paths to the input files.
  var inputPaths: [String]? { get }
  
  /// The path to the directory where output files will be generated.
  var outputPath: String? { get }
}

extension ConfigurationProtocol {
  /// Whether the configuration has inputs.
  var hasInput: Bool {
    guard let inputPaths else {
      return false
    }
    
    return !inputPaths.isEmpty
  }
  
  /// Whether the configuration has outputs.
  var hasOutput: Bool {
    outputPath != nil
  }
}
