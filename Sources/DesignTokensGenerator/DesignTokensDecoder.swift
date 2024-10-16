import DesignTokensCore
import Foundation

/// The object that decodes the design token tree.
struct DesignTokensDecoder {
  
  // MARK: - Stored Properties
  
  /// The `URL` to the design tokens JSON file.
  let inputURLs: [URL]

  // MARK: - Init
  
  init(inputURLs: [URL]) {
    self.inputURLs = inputURLs
  }

  // MARK: - Functions
  
  /// Decodes the design token three.
  /// - Returns: The decoded design token tree.
  func decode() throws -> [DesignTokenTree] {
    let decoder = JSONDecoder()
    
    return try inputURLs.reduce(into: []) { result, inputURL in
      let data = try Data(contentsOf: inputURL)
      let tree = try decoder.decode(DesignTokenTree.self, from: data)
      result.append(tree)
    }
  }
}
