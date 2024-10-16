import Testing
@testable import DesignTokensCore

@Suite
struct DimensionDecoding {
  @Test(
    arguments: [
      "8 pt",
      "A pt",
    ]
  )
  func invalidDimensionStringFailure(dimension: String) throws {
    #expect(throws: DimensionValueFailure.invalidStringValue) {
      try Dimension(dimension)
    }
  }

  @Test(
    arguments: [
      SUT("8 px", expected: Dimension(8.0)),
      SUT("1 rem", expected: Dimension(1.0)),
    ]
  )
  func successfulDimensionDecoding(dimension: SUT<String, Dimension>) throws {
    let result = try Dimension(dimension.argument)
    #expect(result == dimension.expected)
  }
}
