import DesignTokensCore
import Foundation
import Stencil

/// The object that generates source code for the dimension tokens.
struct DimensionSourceCodeGenerator: SourceCodeGenerator {
  
  // MARK: - Stored Properties
  
  // TODO: Traverse the tree outside the generator to improve performance.
  /// The design tokens tree.
  let designTokens: DesignTokenTree

  // MARK: - Functions
  
  /// Generates the dimensions source code with the passed `Stencil` environment.
  /// - Parameter environment: The `Stencil` environment used to generate the source code.
  /// - Returns: The list of source code files generated.
  func generate(with environment: Stencil.Environment) throws -> [SourceCodeFile] {
    let (tokens, aliases) = designTokens.dimensionTokens()

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

    let content = try environment.renderTemplate(name: "dimension+foundation.stencil", context: context)
    return SourceCodeFile(name: "CGFloat+DesignToken.swift", content: content)
  }
}
