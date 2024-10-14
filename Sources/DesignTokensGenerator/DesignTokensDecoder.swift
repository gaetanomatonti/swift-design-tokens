import DesignTokensCore
import Foundation

struct DesignTokensDecoder {
  let inputURL: URL

  init(inputURL: URL) {
    self.inputURL = inputURL
  }

  func decode() throws -> DesignTokenTree {
    let decoder = JSONDecoder()
    let data = try Data(contentsOf: inputURL)
    return try decoder.decode(DesignTokenTree.self, from: data)
  }
}
