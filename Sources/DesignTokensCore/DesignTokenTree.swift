import Foundation

/// A type representing the design token tree.
package struct DesignTokenTree {

  // MARK: - Stored Properties

  /// The root node of the tree.
  ///
  /// This node is not an actual token or group, so it should be ignored when traversing the tree.
  let root: Node

  // MARK: - Functions

  /// Retrieves all color tokens, and aliases in the tree.
  /// - Returns: A tuple of `[ColorToken]`, and `[AliasToken]` that reference color tokens.
  package func colorTokens() -> (tokens: [ColorToken], aliases: [AliasToken]) {
    var tokens: [ColorToken] = []
    var aliases: [AliasToken] = []

    root.depthFirstTraversal { node in
      switch node.value {
      case let .color(color):
        let token =  ColorToken(name: node.name, description: node.description, color: color, path: node.path)
        tokens.append(token)

      case let .alias(path):
        let alias = AliasToken(name: node.name, description: node.description, path: node.path, reference: path)
        aliases.append(alias)

      default:
        break
      }
    }

    tokens.sort()

    aliases.removeAll { alias in
      !tokens.contains { $0.path == alias.reference }
    }
    aliases.sort()

    return (tokens, aliases)
  }

  /// Retrieves all dimension tokens in the tree.
  /// - Returns: A tuple of `[DimensionToken]`, and `[AliasToken]` that reference dimension tokens.
  package func dimensionTokens() -> (tokens: [DimensionToken], aliases: [AliasToken]) {
    var tokens: [DimensionToken] = []
    var aliases: [AliasToken] = []

    root.depthFirstTraversal { node in
      switch node.value {
      case let .dimension(dimension):
        let token = DimensionToken(name: node.name, description: node.description, dimension: dimension, path: node.path)
        tokens.append(token)

      case let .alias(path):
        let alias = AliasToken(name: node.name, description: node.description, path: node.path, reference: path)
        aliases.append(alias)

      default:
        break
      }
    }

    tokens.sort()
    aliases.removeAll { alias in
      !tokens.contains { $0.path == alias.reference }
    }

    return (tokens, aliases)
  }
}

extension DesignTokenTree: Decodable {
  package init(from decoder: any Decoder) throws {
    var root = Node(name: "Design Tokens")

    let container = try decoder.container(keyedBy: AnyCodingKey.self)

    for key in container.allKeys {
      let node = try container.decode(Node.self, forKey: key, configuration: TokenDecodingConfiguration())
      root.add(node)
    }

    self.root = root
  }
}
