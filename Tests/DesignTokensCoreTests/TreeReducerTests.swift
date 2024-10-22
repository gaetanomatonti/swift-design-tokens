import Foundation
import Testing
@testable import DesignTokensCore

@Suite
struct TreeReducerTests {
  @Test(
    "Reduce single tree",
    .bug("https://github.com/gaetanomatonti/swift-design-tokens/issues/22"),
    .tags(.critical, .toImprove)
  )
  func reduceSingleTree() {
    var tree = DesignTokenTree()
    var foundation = Node(name: "foundation", path: ["foundation"])
    foundation.add(Node(name: "white", type: .color, value: .color(.white), path: ["foundation", "white"]))
    foundation.add(Node(name: "red", type: .color, value: .color(.red), path: ["foundation", "red"]))
    foundation.add(Node(name: "small", type: .dimension, value: .dimension(Dimension(8)), path: ["foundation", "small"]))

    var background = Node(name: "background", path: ["background"])
    background.add(Node(name: "base", value: .alias(["foundation", "white"]), path: ["background", "base"]))

    tree.root.add(foundation)
    tree.root.add(background)
    tree.root.add(Node(name: "small", value: .alias(["foundation", "small"]), path: ["small"]))
    tree.root.add(Node(name: "gradient-start", value: .number(0), path: ["gradient-start"]))
    tree.root.add(
      Node(
        name: "blue-to-red",
        value: .gradient(
          Gradient(
            stops: [
              Gradient.Stop(color: .value(.blue), position: .alias(["gradient-start"])),
              Gradient.Stop(color: .alias(["foundation", "red"]), position: .value(1)),
            ]
          )
        ),
        path: ["blue-to-red"]
      )
    )

    let reducer = TreeReducer(trees: [tree])
    let (colorTokens, colorAliases) = reducer.colors()
    let (dimensionTokens, dimensionAliases) = reducer.dimensions()
    let (numberTokens, numberAliases) = reducer.numbers()
    let gradientTokens = reducer.gradients()

    #expect(
      colorTokens == [
        ColorToken(name: "red", color: .red, path: ["foundation", "red"]),
        ColorToken(name: "white", color: .white, path: ["foundation", "white"]),
      ]
    )

    #expect(
      colorAliases == [
        AliasToken(name: "base", path: ["background", "base"], reference: ["foundation", "white"]),
      ]
    )

    #expect(
      dimensionTokens == [
        DimensionToken(name: "small", dimension: Dimension(8), path: ["foundation", "small"]),
      ]
    )

    #expect(
      dimensionAliases == [
        AliasToken(name: "small", path: ["small"], reference: ["foundation", "small"]),
      ]
    )

    #expect(
      numberTokens == [
        NumberToken(name: "gradient-start", number: 0, path: ["gradient-start"]),
      ]
    )

    #expect(numberAliases.isEmpty)

    #expect(
      gradientTokens == [
        GradientToken(
          name: "blue-to-red",
          gradient: Gradient(
            stops: [
              Gradient.Stop(color: .value(.blue), position: .alias(["gradient-start"])),
              Gradient.Stop(color: .alias(["foundation", "red"]), position: .value(1)),
            ]
          ),
          path: ["blue-to-red"]
        ),
      ]
    )
  }

  @Test(
    "Reduce multiple trees with aliases and values in different trees",
    .tags(.critical, .toImprove)
  )
  func reduceMultipleTrees() {
    var foundationTree = DesignTokenTree()
    var foundation = Node(name: "foundation", path: ["foundation"])
    foundation.add(Node(name: "white", type: .color, value: .color(.white), path: ["foundation", "white"]))
    foundation.add(Node(name: "red", type: .color, value: .color(.red), path: ["foundation", "red"]))
    foundation.add(Node(name: "small", type: .dimension, value: .dimension(Dimension(8)), path: ["foundation", "small"]))

    var background = Node(name: "background", path: ["background"])
    background.add(Node(name: "base", value: .alias(["foundation", "white"]), path: ["background", "base"]))

    foundationTree.root.add(foundation)

    var tree = DesignTokenTree()
    tree.root.add(background)
    tree.root.add(Node(name: "small", value: .alias(["foundation", "small"]), path: ["small"]))
    tree.root.add(Node(name: "gradient-start", value: .number(0), path: ["gradient-start"]))
    tree.root.add(
      Node(
        name: "blue-to-red",
        value: .gradient(
          Gradient(
            stops: [
              Gradient.Stop(color: .value(.blue), position: .alias(["gradient-start"])),
              Gradient.Stop(color: .alias(["foundation", "red"]), position: .value(1)),
            ]
          )
        ),
        path: ["blue-to-red"]
      )
    )

    let reducer = TreeReducer(trees: [foundationTree, tree])
    let (colorTokens, colorAliases) = reducer.colors()
    let (dimensionTokens, dimensionAliases) = reducer.dimensions()
    let (numberTokens, numberAliases) = reducer.numbers()
    let gradientTokens = reducer.gradients()

    #expect(
      colorTokens == [
        ColorToken(name: "red", color: .red, path: ["foundation", "red"]),
        ColorToken(name: "white", color: .white, path: ["foundation", "white"]),
      ]
    )

    #expect(
      colorAliases == [
        AliasToken(name: "base", path: ["background", "base"], reference: ["foundation", "white"]),
      ]
    )

    #expect(
      dimensionTokens == [
        DimensionToken(name: "small", dimension: Dimension(8), path: ["foundation", "small"]),
      ]
    )

    #expect(
      dimensionAliases == [
        AliasToken(name: "small", path: ["small"], reference: ["foundation", "small"]),
      ]
    )

    #expect(
      numberTokens == [
        NumberToken(name: "gradient-start", number: 0, path: ["gradient-start"]),
      ]
    )

    #expect(numberAliases.isEmpty)

    #expect(
      gradientTokens == [
        GradientToken(
          name: "blue-to-red",
          gradient: Gradient(
            stops: [
              Gradient.Stop(color: .value(.blue), position: .alias(["gradient-start"])),
              Gradient.Stop(color: .alias(["foundation", "red"]), position: .value(1)),
            ]
          ),
          path: ["blue-to-red"]
        ),
      ]
    )
  }
}
