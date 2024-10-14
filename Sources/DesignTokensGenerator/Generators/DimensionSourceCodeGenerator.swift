import DesignTokensCore
import Foundation
import Stencil

struct DimensionSourceCodeGenerator: SourceCodeGenerator {
  let designTokens: DesignTokenTree

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
