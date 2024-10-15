import DesignTokensCore
import Foundation

/// The object that decodes the design token tree.
struct DesignTokensDecoder {
  
  // MARK: - Stored Properties
  
  /// The `URL` to the design tokens JSON file.
  let inputURL: URL

  // MARK: - Init
  
  init(inputURL: URL) {
    self.inputURL = inputURL
  }

  // MARK: - Functions
  
  /// Decodes the design token three.
  /// - Returns: The decoded design token tree.
  func decode() throws -> DesignTokenTree {
    let decoder = JSONDecoder()
    let data = try Data(contentsOf: inputURL)
    return try decoder.decode(DesignTokenTree.self, from: data)
  }
}
