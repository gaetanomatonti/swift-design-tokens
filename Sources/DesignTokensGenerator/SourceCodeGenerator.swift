import Foundation
import Stencil

/// A type representing a color.
struct Color {

  // MARK: - Stored Properties

  /// The red component of the color.
  let red: Double

  /// The green component of the color.
  let green: Double

  /// The blue component of the color.
  let blue: Double

  /// The alpha component of the color.
  let alpha: Double

  // MARK: - Init

  init(red: Double, green: Double, blue: Double, alpha: Double) {
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
  }
}

extension Color {
  static let black = Color(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
  static let red = Color(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
}

struct ColorToken {
  let name: String
  let description: String?
  let color: Color
  let path: [String]

  init(name: String, description: String?, color: Color, path: [String]) {
    self.name = name
    self.description = description
    self.color = color
    self.path = path
  }
}

struct SourceCodeGenerator {
  let tokens: [ColorToken]

  let frameworks: [Configuration.Output.Format.Framework]

  func generate() throws -> [SourceCodeFile] {
    let loader = FileSystemLoader(bundle: [Bundle.module])
    let environment = Stencil.Environment(loader: loader, trimBehaviour: .smart)

    return try frameworks.reduce(into: []) { result, framework in
      let file = try generate(tokens, for: framework, in: environment)
      result.append(file)
    }
  }

  private func generate(
    _ tokens: [ColorToken],
    for framework: Configuration.Output.Format.Framework,
    in environment: Environment
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
