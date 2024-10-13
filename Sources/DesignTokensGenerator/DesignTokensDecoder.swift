import DesignTokensCore
import Foundation

struct DesignTokensDecoder {
  let inputURL: URL

  init(inputURL: URL) {
    self.inputURL = inputURL
  }

  func decode() throws -> TokenFile {
    let decoder = JSONDecoder()
    let data = try Data(contentsOf: inputURL)
    return try decoder.decode(TokenFile.self, from: data)
  }
}
