import Foundation
import Testing
@testable import DesignTokensGenerator

@Suite
struct ConfigurationValidatorTests {
  @Test(
    arguments: [
      Configuration.scaffold(inputPaths: ["design-tokens.json"], outputPath: "Output/"),
      Configuration().input("design-tokens.json").output("Output/"),
      Configuration().color(inputPath: "design-tokens.json", outputPath: "Output"),
      Configuration().dimension(inputPath: "design-tokens.json", outputPath: "Output"),
      Configuration()
        .color(inputPath: "design-tokens.json", outputPath: "Output")
        .dimension(inputPath: "design-tokens.json", outputPath: "Output"),
      Configuration()
        .input("design-tokens.json")
        .output("Output/")
        .color()
        .dimension()
        .gradient()
        .number(),
      Configuration()
        .input("design-tokens.json")
        .output("Output/")
        .color(inputPath: "design-tokens.json", outputPath: "Output")
        .dimension(inputPath: "design-tokens.json", outputPath: "Output")
        .gradient(inputPath: "design-tokens.json", outputPath: "Output")
        .number(inputPath: "design-tokens.json", outputPath: "Output"),
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
      Configuration().color(outputPath: "Output"),
      Configuration().color(inputPaths: [], outputPath: "Output"),
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
      Configuration().color(inputPath: "design-tokens.json"),
      Configuration().dimension(inputPath: "design-tokens.json"),
    ]
  )
  func configurationHasNoOutput(_ configuration: Configuration) throws {
    #expect(throws: ConfigurationValidationFailure.noOutputProvided) {
      let validator = ConfigurationValidator(configuration: configuration)
      try validator.validate()
    }
  }

  @Test(
    arguments: [
      Configuration
        .scaffold(inputPaths: ["design-tokens.json"], outputPath: "Output/")
        .gradient(),
    ]
  )
  func configurationHasNoNumberConfiguration(_ configuration: Configuration) throws {
    #expect(throws: ConfigurationValidationFailure.gradientConfigurationRequiresNumberConfiguration) {
      let validator = ConfigurationValidator(configuration: configuration)
      try validator.validate()
    }
  }

  @Test(
    arguments: [
      Configuration()
        .input("design-tokens.json")
        .output("Output/")
        .number()
        .gradient(),
    ]
  )
  func configurationHasNoColorConfiguration(_ configuration: Configuration) throws {
    #expect(throws: ConfigurationValidationFailure.gradientConfigurationRequiresColorConfiguration) {
      let validator = ConfigurationValidator(configuration: configuration)
      try validator.validate()
    }
  }
}
