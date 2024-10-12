import Foundation
import Testing
@testable import DesignTokens

@Suite
struct ColorDecoding {
  @Test(
    arguments: [
      "",
      "abcdefg",
      "00AAB",
    ]
  )
  func invalidHexStringFailure(color: String) {
    #expect(throws: DecodingFailure.invalidValue(.invalidHexString)) {
      try Color(color)
    }
  }

  @Test(
    arguments: [
      SUT("#000000", expected: Color(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)),
      SUT("#FF00FF00", expected: Color(red: 1.0, green: 0.0, blue: 1.0, alpha: 0.0)),
    ]
  )
  func successfulColorDecoding(color: SUT<String, Color>) {
    #expect(throws: Never.self) {
      let result = try Color(color.argument)
      #expect(result == color.expected)
    }
  }
}
