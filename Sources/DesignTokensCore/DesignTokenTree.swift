import Foundation

/// A type representing the design token tree.
package struct DesignTokenTree {

  // MARK: - Stored Properties

  /// The root node of the tree.
  ///
  /// This node is not an actual token or group, so it should be ignored when traversing the tree.
  var root: Node

  init() {
    self.root = Node(name: "Design Tokens")
  }

  package func gradientTokens() -> [GradientToken] {
    var tokens: [GradientToken] = []

    root.depthFirstTraversal { node in
      switch node.value {
      case let .gradient(gradient):
        let token = GradientToken(name: node.name, description: node.description, gradient: gradient, path: node.path)
        tokens.append(token)

      default:
        break
      }
    }

    tokens.sort()

    return tokens
  }
}

extension DesignTokenTree: Decodable {
  package init(from decoder: any Decoder) throws {
    self.init()

    let container = try decoder.container(keyedBy: AnyCodingKey.self)

    for key in container.allKeys {
      let node = try container.decode(Node.self, forKey: key, configuration: TokenDecodingConfiguration())
      root.add(node)
    }
  }
}
