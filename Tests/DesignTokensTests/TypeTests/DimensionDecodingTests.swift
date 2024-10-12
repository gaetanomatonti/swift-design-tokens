import Foundation
import Testing
@testable import DesignTokens

@Suite
struct DimensionDecoding {
  @Test func successfulDimensionDecoding() throws {
    let dimension = try Dimension("8 px")

    #expect(dimension.value == 8)
  }

  @Test func invalidUnitFailure() throws {
    #expect(throws: DecodingFailure.invalidValue(.invalidDimensionString)) {
      try Dimension("8 pt")
    }
  }

  @Test func invalidValueFailure() throws {
    #expect(throws: DecodingFailure.invalidValue(.invalidDimensionString)) {
      try Dimension("A pt")
    }
  }
}
