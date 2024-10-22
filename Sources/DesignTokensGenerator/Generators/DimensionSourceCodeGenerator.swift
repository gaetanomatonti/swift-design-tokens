import DesignTokensCore
import Foundation
import Stencil

/// The object that generates source code for dimension tokens.
struct DimensionSourceCodeGenerator: SourceCodeGenerator {
  
  // MARK: - Stored Properties
  
  /// The dimension tokens.
  let tokens: [DimensionToken]
  
  /// The aliases for the tokens.
  let aliases: [AliasToken]

  // MARK: - Functions
  
  /// Generates the dimensions source code with the passed `Stencil` environment.
  /// - Parameter environment: The `Stencil` environment used to generate the source code.
  /// - Returns: The list of source code files generated.
  func generate(with environment: Stencil.Environment) throws -> [SourceCodeFile] {
    guard !tokens.isEmpty else {
      return []
    }

    let file = try generate(tokens, aliases: aliases, in: environment)
    return [file]
  }

  private func generate(
    _ tokens: [DesignTokensCore.DimensionToken],
    aliases: [DesignTokensCore.AliasToken],
    in environment: Stencil.Environment
  ) throws -> SourceCodeFile {
    let context: [String: Any] = [
      "tokens": tokens,
      "aliases": aliases,
    ]

    let content = try environment.renderTemplate(name: "dimension+token.stencil", context: context)
    return SourceCodeFile(name: "Dimension+DesignTokens.swift", content: content)
  }
}
