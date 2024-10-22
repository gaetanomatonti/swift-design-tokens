import DesignTokensCore
import Foundation
import Stencil

/// The object that generates source code for color tokens.
struct ColorSourceCodeGenerator: SourceCodeGenerator {
  
  // MARK: - Stored Properties
  
  /// The color tokens.
  let tokens: [ColorToken]
  
  /// The aliases for the color tokens.
  let aliases: [AliasToken]

  /// The format of the colors source code.
  let format: ColorFormat
  
  // MARK: - Functions

  /// Generates the colors source code with the passed `Stencil` environment.
  /// - Parameter environment: The `Stencil` environment used to generate the source code.
  /// - Returns: The list of source code files generated.
  func generate(with environment: Stencil.Environment) throws -> [SourceCodeFile] {
    guard !tokens.isEmpty else {
      return []
    }
    
    let file = try generate(tokens, aliases: aliases, for: format, in: environment)
    return [file]
  }

  private func generate(
    _ tokens: [DesignTokensCore.ColorToken],
    aliases: [DesignTokensCore.AliasToken],
    for format: ColorFormat,
    in environment: Stencil.Environment
  ) throws -> SourceCodeFile {
    let context: [String: Any] = [
      "tokens": tokens,
      "aliases": aliases
    ]

    let content = try environment.renderTemplate(name: "color+token.stencil", context: context)
    return SourceCodeFile(name: "Color+DesignTokens.swift", content: content)
  }
}
