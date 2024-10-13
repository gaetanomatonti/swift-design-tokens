import Foundation

/// A type representing a token, or group node in a design token tree.
struct Node {
  /// The name of the node.
  let name: String

  /// The description of the node.
  let description: String?

  /// The type of the node.
  let type: TokenType?

  /// The value of the node.
  ///
  /// This property has a value when the node represents a token.
  let value: TokenValue?

  /// The path to the node.
  let path: [String]

  /// The children of the node.
  ///
  /// This array should contain nodes only if the node represents a group.
  var children: [Node] = []

  // MARK: - Init

  init(name: String, description: String? = nil, type: TokenType? = nil, value: TokenValue? = nil, path: [String] = [], children: [Node] = []) {
    self.name = name
    self.description = description
    self.type = type
    self.value = value
    self.path = path
    self.children = children
  }

  // MARK: - Functions

  mutating func add(_ child: Node) {
    children.append(child)
  }

  func depthFirstTraversal(_ visit: (Node) -> Void) {
    visit(self)
    children.forEach {
      $0.depthFirstTraversal(visit)
    }
  }

  func search(name: String) -> Node? {
    var result: Node?
    depthFirstTraversal { node in
      if node.name == name {
        result = node
      }
    }

    return result
  }
}

extension Node: DecodableWithConfiguration {
  init(from decoder: any Decoder, configuration: TokenDecodingConfiguration) throws {
    let container = try decoder.container(keyedBy: AnyCodingKey.self)

    guard let name = container.codingPath.last else {
      throw DecodingFailure.invalidCodingPath
    }

    self.name = name.stringValue
    self.description = try container.decodeIfPresent(String.self, forKey: .description)
    self.path = container.codingPath.map(\.stringValue)

    let type = try container.decodeIfPresent(TokenType.self, forKey: .type) ?? configuration.type
    self.type = type

    guard container.isTokenContainer else {
      self.value = nil

      for key in container.allKeys where key.isNameKey {
        let nestedNode = try container.decode(Node.self, forKey: key, configuration: TokenDecodingConfiguration(type: type))
        add(nestedNode)
      }
      return
    }

    let valueString = try container.decode(String.self, forKey: .value)

    switch type {
    case .some(.color):
      let color = try Color(valueString)
      self.value = .color(color)

    case .some(.dimension):
      let dimension = try Dimension(valueString)
      self.value = .dimension(dimension)

    case .none:
      do {
        let alias = try Alias(valueString)
        self.value = .alias(alias.path)
      } catch .invalidValue(.invalidReferenceSyntax) {
        throw DecodingFailure.missingType
      } catch {
        throw error
      }
    }
  }
}
