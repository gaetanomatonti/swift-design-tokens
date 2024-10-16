import Foundation

protocol ConfigurationProtocol: Codable {
  var inputPaths: [String]? { get }
  
  var outputPath: String? { get }
}

extension ConfigurationProtocol {
  var hasInput: Bool {
    inputPaths != nil
  }
  
  var hasOutput: Bool {
    outputPath != nil
  }
}
