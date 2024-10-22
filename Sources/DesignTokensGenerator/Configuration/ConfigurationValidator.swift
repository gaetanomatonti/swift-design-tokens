import Foundation

/// The possible reasons for a configuration validation failure.
enum ConfigurationValidationFailure: Error {
  /// No input has been provided in the configuration.
  case noInputProvided
  
  /// No output has been provided in the configuration.
  case noOutputProvided

  /// The gradient configuration requires a color configuration to be set.
  case gradientConfigurationRequiresColorConfiguration

  /// The gradient configuration requires a number configuration to be set.
  case gradientConfigurationRequiresNumberConfiguration
}

/// An object that validates the given `Configuration`.
struct ConfigurationValidator {
  
  // MARK: - Stored Properties
  
  /// The configuration to validate.
  let configuration: Configuration
  
  // MARK: - Init
  
  init(configuration: Configuration) {
    self.configuration = configuration
  }
  
  // MARK: - Functions
  
  /// Validates the configuration.
  /// - Throws: A `ConfigurationValidationFailure` indicating the reason for the validation failure.
  func validate() throws(ConfigurationValidationFailure) {
    try validateInputs()
    try validateOutputs()
    try validateConfigurations()
  }
  
  private func validateInputs() throws(ConfigurationValidationFailure) {
    let multipleInputs: [Bool] = [
      configuration.colorConfiguration?.hasInput,
      configuration.dimensionConfiguration?.hasInput
    ]
    .compactMap { $0 }
    
    let hasMultipleInputs = multipleInputs.isEmpty ? false : multipleInputs.allSatisfy { $0 }
    
    let hasInput = configuration.hasInput || hasMultipleInputs
    
    if !hasInput {
      throw .noInputProvided
    }
  }
  
  private func validateOutputs() throws(ConfigurationValidationFailure) {
    let multipleOutputs: [Bool] = [
      configuration.colorConfiguration?.hasOutput,
      configuration.dimensionConfiguration?.hasOutput
    ]
    .compactMap { $0 }
    
    let hasMultipleOutputs = multipleOutputs.isEmpty ? false : multipleOutputs.allSatisfy { $0 }
    
    let hasOutput = configuration.hasOutput || hasMultipleOutputs
    
    if !hasOutput {
      throw .noOutputProvided
    }
  }

  private func validateConfigurations() throws(ConfigurationValidationFailure) {
    if configuration.gradientConfiguration != nil {
      if configuration.colorConfiguration == nil {
        throw .gradientConfigurationRequiresColorConfiguration
      }

      if configuration.numberConfiguration == nil {
        throw .gradientConfigurationRequiresNumberConfiguration
      }
    }
  }
}
