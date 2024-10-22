import DesignTokensCore
import Foundation
import Stencil

/// The object that generates source code for gradient tokens.
struct GradientSourceCodeGenerator: SourceCodeGenerator {

  // MARK: - Stored Properties
  
  /// The gradient tokens.
  let tokens: [GradientToken]

  // MARK: - Functions
  
  /// Generates the dimensions source code with the passed `Stencil` environment.
  /// - Parameter environment: The `Stencil` environment used to generate the source code.
  /// - Returns: The list of source code files generated.
  func generate(with environment: Stencil.Environment) throws -> [SourceCodeFile] {
    guard !tokens.isEmpty else {
      return []
    }

    let file = try generate(tokens, in: environment)
    return [file]
  }

  private func generate(
    _ tokens: [DesignTokensCore.GradientToken],
    in environment: Stencil.Environment
  ) throws -> SourceCodeFile {
    let context: [String: Any] = [
      "tokens": tokens,
    ]

    let content = try environment.renderTemplate(name: "gradient+token.stencil", context: context)
    return SourceCodeFile(name: "Gradient+DesignTokens.swift", content: content)
  }
}
