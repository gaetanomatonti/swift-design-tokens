import Foundation

/// An object that reduces multiple trees into the different types of tokens.
package struct TreeReducer {

  // MARK: - Stored Properties

  private let trees: [DesignTokenTree]

  // MARK: - Init

  package init(trees: [DesignTokenTree]) {
    self.trees = trees
  }

  // MARK: - Functions

  /// Reduces the trees into all color tokens, and matching aliases.
  /// - Returns: A tuple of `[ColorToken]`, and `[AliasToken]` that reference color tokens.
  package func colors() -> ([ColorToken], [AliasToken]) {
    let tokens = colorTokens().sorted()
    let aliases = aliasTokens(for: tokens).sorted()

    return (tokens, aliases)
  }

  /// Reduces the trees into all dimension tokens, and matching aliases.
  /// - Returns: A tuple of `[DimensionToken]`, and `[AliasToken]` that reference dimension tokens.
  package func dimensions() -> ([DimensionToken], [AliasToken]) {
    let tokens = dimensionTokens().sorted()
    let aliases = aliasTokens(for: tokens).sorted()

    return (tokens, aliases)
  }

  /// Reduces the trees into all number tokens, and matching aliases.
  /// - Returns: A tuple of `[NumberToken]`, and `[AliasToken]` that reference number tokens.
  package func numbers() -> ([NumberToken], [AliasToken]) {
    let tokens = numberTokens().sorted()
    let aliases = aliasTokens(for: tokens).sorted()

    return (tokens, aliases)
  }

  /// Reduces the trees into all gradient tokens.
  /// - Returns: An array of `NumberToken`.
  package func gradients() -> [GradientToken] {
    // TODO: Do gradients support aliases?
    return gradientTokens().sorted()
  }

  private func colorTokens() -> [ColorToken] {
    trees.reduce(into: []) { result, tree in
      tree.root.depthFirstTraversal { node in
        if case let .color(color) = node.value {
          let token = ColorToken(name: node.name, description: node.description, color: color, path: node.path)
          result.append(token)
        }
      }
    }
  }

  private func dimensionTokens() -> [DimensionToken] {
    trees.reduce(into: []) { result, tree in
      tree.root.depthFirstTraversal { node in
        if case let .dimension(dimension) = node.value {
          let token = DimensionToken(name: node.name, description: node.description, dimension: dimension, path: node.path)
          result.append(token)
        }
      }
    }
  }

  private func numberTokens() -> [NumberToken] {
    trees.reduce(into: []) { result, tree in
      tree.root.depthFirstTraversal { node in
        if case let .number(number) = node.value {
          let token = NumberToken(name: node.name, description: node.description, number: number, path: node.path)
          result.append(token)
        }
      }
    }
  }

  private func gradientTokens() -> [GradientToken] {
    trees.reduce(into: []) { result, tree in
      tree.root.depthFirstTraversal { node in
        if case let .gradient(gradient) = node.value {
          let token = GradientToken(name: node.name, description: node.description, gradient: gradient, path: node.path)
          result.append(token)
        }
      }
    }
  }

  private func aliasTokens<T>(for sequence: [T]) -> [AliasToken] where T: Token {
    aliasTokens { alias in
      sequence.contains { token in
        token.path == alias.reference
      }
    }
  }

  private func aliasTokens(where predicate: (AliasToken) -> Bool) -> [AliasToken] {
    trees.reduce(into: []) { result, tree in
      tree.root.depthFirstTraversal { node in
        if case let .alias(path) = node.value {
          let token = AliasToken(name: node.name, description: node.description, path: node.path, reference: path)

          if predicate(token) {
            result.append(token)
          }
        }
      }
    }
  }
}
