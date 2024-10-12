import Foundation
import Testing
@testable import DesignTokens

@Suite
struct ColorDecoding {
  @Test func invalidHexStringFailure() {
    #expect(throws: DecodingFailure.invalidValue(.invalidHexString)) {
      try Color("abcdefg")
    }
  }

  @Test func invalidHexCharactersCountFailure() {
    #expect(throws: DecodingFailure.invalidValue(.invalidHexString)) {
      try Color("00AAB")
    }
  }

  @Test func successfulColorDecoding() throws {
    let color = try Color("#000000")

    #expect(color.red == 0.0)
    #expect(color.green == 0.0)
    #expect(color.blue == 0.0)
    #expect(color.alpha == 1.0)
  }

  @Test func successfulColorWithAlpha() throws {
    let color = try Color("#FF00FF00")

    #expect(color.red == 1.0)
    #expect(color.green == 0.0)
    #expect(color.blue == 1.0)
    #expect(color.alpha == 0.0)
  }
}
