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
    let tokens = colorTokens()

    let aliases = aliasTokens { alias in
      tokens.contains { token in
        token.path == alias.reference
      }
    }

    return (tokens, aliases)
  }

  /// Reduces the trees into all dimension tokens, and matching aliases.
  /// - Returns: A tuple of `[DimensionToken]`, and `[AliasToken]` that reference color tokens.
  package func dimensions() -> ([DimensionToken], [AliasToken]) {
    let tokens = dimensionTokens()

    let aliases = aliasTokens { alias in
      tokens.contains { token in
        token.path == alias.reference
      }
    }

    return (tokens, aliases)
  }

  func colorTokens() -> [ColorToken] {
    trees.reduce(into: []) { result, tree in
      tree.root.depthFirstTraversal { node in
        if case let .color(color) = node.value {
          let token = ColorToken(name: node.name, description: node.description, color: color, path: node.path)
          result.append(token)
        }
      }
    }
  }

  func dimensionTokens() -> [DimensionToken] {
    trees.reduce(into: []) { result, tree in
      tree.root.depthFirstTraversal { node in
        if case let .dimension(dimension) = node.value {
          let token = DimensionToken(name: node.name, description: node.description, dimension: dimension, path: node.path)
          result.append(token)
        }
      }
    }
  }

  func aliasTokens(where predicate: (AliasToken) -> Bool) -> [AliasToken] {
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
