import DesignTokensCore
import Foundation
import Stencil

struct DimensionSourceCodeGenerator {
  let designTokens: DesignTokenTree

  func generate() throws -> [SourceCodeFile] {
    let loader = Stencil.FileSystemLoader(bundle: [Bundle.module])
    let environment = Stencil.Environment(loader: loader, trimBehaviour: .smart)

    let tokens = designTokens.dimensionTokens()

    guard !tokens.isEmpty else {
      return []
    }

    let file = try generate(tokens, in: environment)

    // TODO: - Generate a separate file for color aliases

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
