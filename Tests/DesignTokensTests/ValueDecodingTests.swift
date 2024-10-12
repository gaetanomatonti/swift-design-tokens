import Foundation
import Testing
@testable import DesignTokens

@Suite
struct ValueDecoding {
  @Test func successfulColorDecoding() throws {
    _ = try Color("#000000")
  }

  @Test func blackColorDecoding() throws {
    let color = try Color("#000000")

    #expect(color.red == .zero)
    #expect(color.green == .zero)
    #expect(color.blue == .zero)
    #expect(color.alpha == 1.0)
  }

  @Test func redColorDecoding() throws {
    let color = try Color("#FF0000")

    #expect(color.red == 1.0)
    #expect(color.green == .zero)
    #expect(color.blue == .zero)
    #expect(color.alpha == 1.0)
  }

  @Test func dimensionDecoding() throws {
    let dimension = try Dimension("8 px")

    #expect(dimension.value == 8)
  }
}
