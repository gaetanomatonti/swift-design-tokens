import Foundation

struct Node {
  let name: String
  let description: String?
  let type: TokenType?
  let value: TokenValue?
  let path: [String]

  var children: [Node] = []

  var isToken: Bool {
    value != nil
  }

  init(name: String, description: String? = nil, type: TokenType? = nil, value: TokenValue? = nil, path: [String] = [], children: [Node] = []) {
    self.name = name
    self.description = description
    self.type = type
    self.value = value
    self.path = path
    self.children = children
  }

  mutating func add(_ child: Node) {
    children.append(child)
  }

  func depthFirstTraversal(visit: (Node) -> Void) {
    visit(self)
    children.forEach {
      $0.depthFirstTraversal(visit: visit)
    }
  }

  func levelOrderTraversal(visit: (Node) -> Void) {
    visit(self)
    var queue = [Node]()
    children.forEach { queue.append($0) }

    while !queue.isEmpty {
      let node = queue.removeFirst()
      visit(node)
      node.children.forEach { queue.append($0) }
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
