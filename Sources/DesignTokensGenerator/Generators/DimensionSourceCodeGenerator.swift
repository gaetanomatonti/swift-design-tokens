import DesignTokensCore
import Foundation
import Stencil

struct DimensionSourceCodeGenerator: SourceCodeGenerator {
  let designTokens: DesignTokenTree

  func generate(with environment: Stencil.Environment) throws -> [SourceCodeFile] {
    let tokens = designTokens.dimensionTokens()

    guard !tokens.isEmpty else {
      return []
    }

    let file = try generate(tokens, in: environment)
    return [file]
  }

  private func generate(
    _ tokens: [DesignTokensCore.DimensionToken],
    in environment: Stencil.Environment
  ) throws -> SourceCodeFile {
    let context = [
      "tokens": tokens
    ]

    let content = try environment.renderTemplate(name: "dimension+foundation.stencil", context: context)
    return SourceCodeFile(name: "CGFloat+DesignToken.swift", content: content)
  }
}
