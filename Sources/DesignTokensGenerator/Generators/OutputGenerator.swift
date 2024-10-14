import DesignTokensCore
import Foundation
import StencilSwiftKit

/// An object that generates the output for the specified configuration file.
package struct OutputGenerator {
  private let configurationLocator: ConfigurationLocator

  package init(configurationURL: URL) {
    self.configurationLocator = ConfigurationLocator(configurationURL: configurationURL)
  }

  package func generate() throws {
    let configurationLoader = ConfigurationLoader(using: configurationLocator)
    let configuration = try configurationLoader.load()

    guard
      let inputURL = URL(
        string: configuration.input,
        relativeTo: configurationLocator.directoryURL.appending(path: configuration.input)
      )
    else {
      return
    }
    
    let designTokensDecoder = DesignTokensDecoder(inputURL: inputURL)
    let designTokenTree = try designTokensDecoder.decode()
    
    if let colorConfiguration = configuration.output.colorConfiguration {
      try generate(with: colorConfiguration, from: designTokenTree)
    }
    
    if let dimensionConfiguration = configuration.output.dimensionConfiguration {
      try generate(with: dimensionConfiguration, from: designTokenTree)
    }
  }
  
  private func generate(with configuration: ColorConfiguration, from tree: DesignTokenTree) throws {
    let outputURL = outputURL(with: configurationLocator, for: configuration.path)
    
    try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: true)
    
    for format in configuration.formats {
      switch format {
      case .swiftUI, .uiKit:
        let sourceCodeGenerator = ColorSourceCodeGenerator(
          designTokens: tree,
          format: format
        )
        let files = try sourceCodeGenerator.generate()

        try write(files, at: outputURL)
      }
    }
  }
  
  private func generate(with configuration: DimensionConfiguration, from tree: DesignTokenTree) throws {
    let outputURL = outputURL(with: configurationLocator, for: configuration.path)

    try FileManager.default.createDirectory(at: outputURL, withIntermediateDirectories: true)

    let sourceCodeGenerator = DimensionSourceCodeGenerator(designTokens: tree)
    let files = try sourceCodeGenerator.generate()

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
