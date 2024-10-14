import DesignTokensCore
import Foundation
import Stencil

struct SourceCodeGenerator {
  let designTokens: DesignTokenTree

  let frameworks: [Configuration.Output.Format.Framework]

  func generate() throws -> [SourceCodeFile] {
    let loader = Stencil.FileSystemLoader(bundle: [Bundle.module])
    let environment = Stencil.Environment(loader: loader, trimBehaviour: .smart)

    let sourceCodeFiles: [SourceCodeFile] = try TokenType.allCases.reduce(into: []) { result, type in
      let files = try generate(for: type, in: environment)
      result.append(contentsOf: files)
    }

    // TODO: - Generate a separate file for color aliases

    return sourceCodeFiles
  }

  private func generate(
    for type: TokenType,
    in environment: Stencil.Environment
  ) throws -> [SourceCodeFile] {
    switch type {
    case .color:
      // TODO: - Save the path of processed color tokens in a storage
      return try frameworks.reduce(into: []) { result, framework in
        let file = try generate(colors: designTokens.colorTokens(), for: framework, in: environment)
        result.append(file)
      }

    case .dimension:
      return []
    }
  }

  private func generate(
    colors tokens: [DesignTokensCore.ColorToken],
    for framework: Configuration.Output.Format.Framework,
    in environment: Stencil.Environment
  ) throws -> SourceCodeFile {
    let context = [
      "tokens": tokens
    ]

    switch framework {
    case .swiftUI:
      let content = try environment.renderTemplate(name: "color+swiftui.stencil", context: context)
      return SourceCodeFile(name: "Color+DesignTokens.swift", content: content)

    case .uiKit:
      let content = try environment.renderTemplate(name: "color+uikit.stencil", context: context)
      return SourceCodeFile(name: "UIColor+DesignTokens.swift", content: content)
    }
  }
}
