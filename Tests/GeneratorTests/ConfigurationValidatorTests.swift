import Foundation
import Testing
@testable import DesignTokensGenerator

@Suite
struct ConfigurationValidatorTests {
  @Test(
    arguments: [
      Configuration.scaffold(),
      Configuration().input("design-tokens.json").output("Output/"),
      Configuration().color(inputPath: "design-tokens.json", outputPath: "Output", formats: .swiftUI),
      Configuration().dimension(inputPath: "design-tokens.json", outputPath: "Output"),
      Configuration()
        .color(inputPath: "design-tokens.json", outputPath: "Output", formats: .swiftUI)
        .dimension(inputPath: "design-tokens.json", outputPath: "Output"),
      Configuration()
        .input("design-tokens.json")
        .output("Output/")
        .color(formats: .swiftUI)
        .dimension(),
      Configuration()
        .input("design-tokens.json")
        .output("Output/")
        .color(inputPath: "design-tokens.json", outputPath: "Output", formats: .swiftUI)
        .dimension(inputPath: "design-tokens.json", outputPath: "Output"),
    ]
  )
  func configurationIsValid(_ configuration: Configuration) throws {
    #expect(throws: Never.self) {
      let validator = ConfigurationValidator(configuration: configuration)
      try validator.validate()
    }
  }
  
  @Test(
    arguments: [
      Configuration().output("Output/"),
      Configuration().inputs([]).output("Output/"),
      Configuration().color(outputPath: "Output", formats: .swiftUI),
      Configuration().color(inputPaths: [], outputPath: "Output", formats: .swiftUI),
      Configuration().dimension(outputPath: "Output"),
      Configuration().dimension(inputPaths: [], outputPath: "Output"),
    ]
  )
  func configurationHasNoInput(_ configuration: Configuration) throws {
    #expect(throws: ConfigurationValidationFailure.noInputProvided) {
      let validator = ConfigurationValidator(configuration: configuration)
      try validator.validate()
    }
  }
  
  @Test(
    arguments: [
      Configuration().input("design-tokens.json"),
      Configuration().color(inputPath: "design-tokens.json", formats: .swiftUI),
      Configuration().dimension(inputPath: "design-tokens.json"),
    ]
  )
  func configurationHasNoOutput(_ configuration: Configuration) throws {
    #expect(throws: ConfigurationValidationFailure.noOutputProvided) {
      let validator = ConfigurationValidator(configuration: configuration)
      try validator.validate()
    }
  }
}
