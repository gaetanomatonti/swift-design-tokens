import DesignTokensCore
import Foundation
import Stencil

struct ColorSourceCodeGenerator: SourceCodeGenerator {
  let designTokens: DesignTokenTree

  let format: ColorFormat

  func generate(with environment: Stencil.Environment) throws -> [SourceCodeFile] {
    let tokens = designTokens.colorTokens()
    
    guard !tokens.isEmpty else {
      return []
    }
    
    let file = try generate(tokens, for: format, in: environment)

    // TODO: - Generate a separate file for color aliases

    return [file]
  }

  private func generate(
    _ tokens: [DesignTokensCore.ColorToken],
    for format: ColorFormat,
    in environment: Stencil.Environment
  ) throws -> SourceCodeFile {
    let context = [
      "tokens": tokens
    ]

    switch format {
    case .swiftUI:
      let content = try environment.renderTemplate(name: "color+swiftui.stencil", context: context)
      return SourceCodeFile(name: "Color+DesignTokens.swift", content: content)

    case .uiKit:
      let content = try environment.renderTemplate(name: "color+uikit.stencil", context: context)
      return SourceCodeFile(name: "UIColor+DesignTokens.swift", content: content)
    }
  }
}
