import Foundation

protocol ConfigurationProtocol: Codable {
  var inputPath: String? { get }
  
  var outputPath: String? { get }
}

extension ConfigurationProtocol {
  var hasInput: Bool {
    inputPath != nil
  }
  
  var hasOutput: Bool {
    outputPath != nil
  }
}
