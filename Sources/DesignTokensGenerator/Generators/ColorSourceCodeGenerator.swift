import DesignTokensCore
import Foundation
import Stencil

struct ColorSourceCodeGenerator: SourceCodeGenerator {
  let designTokens: DesignTokenTree

  let format: ColorFormat

  func generate(with environment: Stencil.Environment) throws -> [SourceCodeFile] {
    let (tokens, aliases) = designTokens.colorTokens()

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
