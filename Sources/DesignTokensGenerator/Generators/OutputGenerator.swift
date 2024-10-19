import DesignTokensCore
import Foundation
import StencilSwiftKit

/// An object that generates the output for the specified configuration file.
package struct OutputGenerator {
  
  // MARK: - Stored Properties
  
  /// The locator for the configuration manifest.
  private let configurationLocator: ConfigurationLocator

  // MARK: - Stored Properties
  
  package init(using configurationLocator: ConfigurationLocator) {
    self.configurationLocator = configurationLocator
  }
  
  // MARK: - Functions

  /// Generates the output for the design tokens.
  package func generate() throws {
    let configurationLoader = ConfigurationLoader(using: configurationLocator)
    let configuration = try configurationLoader.load()
    
    let configurationValidator = ConfigurationValidator(configuration: configuration)
    try configurationValidator.validate()
    
    try generateTokens(with: configuration)
  }
  
  private func generateTokens(with configuration: Configuration) throws {
    guard let inputPaths = configuration.inputPaths else {
      try generateColors(with: configuration)
      try generateDimensions(with: configuration)
      return
    }
    
    let inputLocator = InputLocator(inputPaths: inputPaths)
    let inputURLs = inputLocator.locate(using: configurationLocator)
    
    let designTokensDecoder = DesignTokensDecoder(inputURLs: inputURLs)
    let trees = try designTokensDecoder.decode()

    try generateColors(with: configuration, from: trees)
    try generateDimensions(with: configuration, from: trees)
    try generateGradients(with: configuration, from: trees)
  }
  
  private func generateColors(with configuration: Configuration) throws {
    guard let colorConfiguration = configuration.colorConfiguration else {
      return
    }
    
    guard let inputPaths = colorConfiguration.inputPaths else {
      return
    }

    let inputLocator = InputLocator(inputPaths: inputPaths)
    let inputURLs = inputLocator.locate(using: configurationLocator)
    
    let designTokensDecoder = DesignTokensDecoder(inputURLs: inputURLs)
    let trees = try designTokensDecoder.decode()

    try generateColors(with: configuration, from: trees)
  }
  
  private func generateDimensions(with configuration: Configuration) throws {
    guard let dimensionConfiguration = configuration.dimensionConfiguration else {
      return
    }
    
    guard let inputPaths = dimensionConfiguration.inputPaths else {
      return
    }

    let inputLocator = InputLocator(inputPaths: inputPaths)
    let inputURLs = inputLocator.locate(using: configurationLocator)
    
    let designTokensDecoder = DesignTokensDecoder(inputURLs: inputURLs)
    let trees = try designTokensDecoder.decode()

    try generateDimensions(with: configuration, from: trees)
  }
  
  private func generateGradients(with configuration: Configuration) throws {
    guard let gradientConfiguration = configuration.gradientConfiguration else {
      return
    }
    
    guard let inputPaths = gradientConfiguration.inputPaths else {
      return
    }

    let inputLocator = InputLocator(inputPaths: inputPaths)
    let inputURLs = inputLocator.locate(using: configurationLocator)
    
    let designTokensDecoder = DesignTokensDecoder(inputURLs: inputURLs)
    let trees = try designTokensDecoder.decode()

    try generateGradients(with: configuration, from: trees)
  }
  
  private func generateColors(with configuration: Configuration, from trees: [DesignTokenTree]) throws {
    guard let colorConfiguration = configuration.colorConfiguration else {
      return
    }
    
    guard let outputPath = colorConfiguration.outputPath ?? configuration.outputPath else {
      return
    }
    
    let outputURL = outputURL(with: configurationLocator, for: outputPath)

    let reducer = TreeReducer(trees: trees)
    let (tokens, aliases) = reducer.colors()
    
    try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: true)

    for format in colorConfiguration.formats {
      switch format {
      case .swiftUI, .uiKit:
        let sourceCodeGenerator = ColorSourceCodeGenerator(
          tokens: tokens,
          aliases: aliases,
          format: format
        )
        let files = try sourceCodeGenerator.generate(with: StencilEnvironmentProvider.swift())

        try write(files, at: outputURL)
      }
    }
  }
  
  private func generateDimensions(with configuration: Configuration, from trees: [DesignTokenTree]) throws {
    guard let dimensionConfiguration = configuration.dimensionConfiguration else {
      return
    }
    
    guard let outputPath = dimensionConfiguration.outputPath ?? configuration.outputPath else {
      return
    }
    
    let outputURL = outputURL(with: configurationLocator, for: outputPath)

    let reducer = TreeReducer(trees: trees)
    let (tokens, aliases) = reducer.dimensions()

    let sourceCodeGenerator = DimensionSourceCodeGenerator(tokens: tokens, aliases: aliases)
    let files = try sourceCodeGenerator.generate(with: StencilEnvironmentProvider.swift())

    try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: true)
    try write(files, at: outputURL)
  }
  
  private func generateGradients(with configuration: Configuration, from trees: [DesignTokenTree]) throws {
    guard let gradientConfiguration = configuration.gradientConfiguration else {
      return
    }
    
    guard let outputPath = gradientConfiguration.outputPath ?? configuration.outputPath else {
      return
    }
    
    let outputURL = outputURL(with: configurationLocator, for: outputPath)

    let reducer = TreeReducer(trees: trees)
    let tokens = reducer.gradients()

    let sourceCodeGenerator = GradientSourceCodeGenerator(tokens: tokens)
    let files = try sourceCodeGenerator.generate(with: StencilEnvironmentProvider.swift())

    try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: true)
    try write(files, at: outputURL)
  }
  
  private func outputURL(with configurationLocator: ConfigurationLocator, for path: String) -> URL {
    configurationLocator.directoryURL
      .appending(path: path)
  }

  private func write(_ files: [SourceCodeFile], at outputURL: URL) throws {
    for file in files {
      try write(file, at: outputURL)
    }
  }

  private func write(_ file: SourceCodeFile, at outputURL: URL) throws {
    let outputFileURL = outputURL
      .appending(path: file.name)

    try file.content.write(to: outputFileURL, atomically: false, encoding: .utf8)
  }
}
