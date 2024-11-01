import DesignTokensCore
import Foundation
import Stencil

/// The object that generates source code for shadow tokens.
struct ShadowSourceCodeGenerator: SourceCodeGenerator {

  // MARK: - Stored Properties
  
  /// The shadow tokens.
  let tokens: [ShadowToken]

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
    _ tokens: [DesignTokensCore.ShadowToken],
    in environment: Stencil.Environment
  ) throws -> SourceCodeFile {
    let context: [String: Any] = [
      "tokens": tokens,
    ]

    let content = try environment.renderTemplate(name: "shadow+token.stencil", context: context)
    return SourceCodeFile(name: "Shadow+DesignTokens.swift", content: content)
  }
}
