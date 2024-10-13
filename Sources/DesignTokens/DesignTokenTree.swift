import Foundation

/// A type representing the design token tree.
package struct DesignTokenTree {

  // MARK: - Stored Properties

  /// The root node of the tree.
  ///
  /// This node is not an actual token or group, so it should be ignored when traversing the tree.
  let root: Node

  // MARK: - Functions

  package func colorTokens() -> [ColorToken] {
    var tokens: [ColorToken] = []
    root.depthFirstTraversal { node in
      guard case .color(let color) = node.value else {
        return
      }

      let token =  ColorToken(name: node.name, description: node.description, color: color, path: node.path)
      tokens.append(token)
    }
    return tokens
  }

  package func dimensionTokens() -> [DimensionToken] {
    var tokens: [DimensionToken] = []
    root.depthFirstTraversal { node in
      guard case .dimension(let dimension) = node.value else {
        return
      }

      let token =  DimensionToken(name: node.name, description: node.description, dimension: dimension, path: node.path)
      tokens.append(token)
    }
    return tokens
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
