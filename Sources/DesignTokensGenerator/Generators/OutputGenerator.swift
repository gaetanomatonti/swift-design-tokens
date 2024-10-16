import DesignTokensCore
import Foundation
import StencilSwiftKit

/// An object that generates the output for the specified configuration file.
package struct OutputGenerator {
  
  // MARK: - Stored Properties
  
  /// The locator for the configuration manifest.
  private let configurationLocator: ConfigurationLocator

  // MARK: - Stored Properties
  
  package init(configurationURL: URL) {
    self.configurationLocator = ConfigurationLocator(configurationURL: configurationURL)
  }
  
  // MARK: - Functions

  /// Generates the output for the design tokens.
  package func generate() throws {
    let configurationLoader = ConfigurationLoader(using: configurationLocator)
    let configuration = try configurationLoader.load()
    
    let configurationValidator = ConfigurationValidator(configuration: configuration)
    try configurationValidator.validate()
    
    guard let inputPath = configuration.inputPath else {
      return
    }

    let inputURL = configurationLocator.directoryURL.appending(path: inputPath)
    
    let designTokensDecoder = DesignTokensDecoder(inputURL: inputURL)
    let designTokenTree = try designTokensDecoder.decode()
    
    try generateColors(with: configuration, from: designTokenTree)
    try generateDimensions(with: configuration, from: designTokenTree)
  }
  
  private func generateColors(with configuration: Configuration, from tree: DesignTokenTree) throws {
    guard let colorConfiguration = configuration.colorConfiguration else {
      return
    }
    
    guard let outputPath = colorConfiguration.outputPath ?? configuration.outputPath else {
      return
    }
    
    let outputURL = outputURL(with: configurationLocator, for: outputPath)
    
    let (tokens, aliases) = tree.colorTokens()
    
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
  
  private func generateDimensions(with configuration: Configuration, from tree: DesignTokenTree) throws {
    guard let dimensionConfiguration = configuration.dimensionConfiguration else {
      return
    }
    
    guard let outputPath = dimensionConfiguration.outputPath ?? configuration.outputPath else {
      return
    }
    
    let outputURL = outputURL(with: configurationLocator, for: outputPath)

    let (tokens, aliases) = tree.dimensionTokens()

    let sourceCodeGenerator = DimensionSourceCodeGenerator(tokens: tokens, aliases: aliases)
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
