import Foundation
import Testing
@testable import DesignTokensCore

@Suite
struct ShadowDecoding {
  private let decoder = JSONDecoder()

  @Test
  func successfulDecoding() throws {
    let data = try #require(loadJSON(named: "shadow"))
    #expect(throws: Never.self) {
      let tree = try decoder.decode(DesignTokenTree.self, from: data)

      let shadow = try #require(tree.root.children.first?.value?.shadow)

      let color = try Color("#00000010")

      #expect(shadow.color == .value(color))
      #expect(shadow.offsetX == .value(Dimension(2)))
      #expect(shadow.offsetY == .value(Dimension(2)))
      #expect(shadow.blur == .value(Dimension(4)))
      #expect(shadow.spread == .value(Dimension(0)))
      #expect(shadow.inset == true)
    }
  }
}
