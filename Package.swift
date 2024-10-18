// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "DesignTokens",
  platforms: [
    .macOS(.v13)
  ],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .executable(
      name: "design-tokens",
      targets: [
        "DesignTokensTool",
      ]
    )
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser", from: "1.5.0"),
    .package(url: "https://github.com/SwiftGen/StencilSwiftKit", from: "2.10.1"),
  ],
  targets: [
    .executableTarget(
      name: "DesignTokensTool",
      dependencies: [
        "DesignTokensCore",
        "DesignTokensGenerator",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]
    ),
    .target(
      name: "DesignTokensCore"
    ),
    .target(
      name: "DesignTokensGenerator",
      dependencies: [
        "DesignTokensCore",
        .product(name: "StencilSwiftKit", package: "StencilSwiftKit"),
      ],
      resources: [
        .copy("Resources/common.stencil"),
        .copy("Resources/color+swiftui.stencil"),
        .copy("Resources/color+uikit.stencil"),
        .copy("Resources/dimension+foundation.stencil"),
      ]
    ),
    .testTarget(
      name: "DesignTokensCoreTests",
      dependencies: ["DesignTokensCore"],
      resources: [
        .copy("Resources/alias.json"),
        .copy("Resources/color.json"),
        .copy("Resources/gradient.json"),
        .copy("Resources/groups.json"),
        .copy("Resources/missingTypeFailure.json"),
        .copy("Resources/missingTypeWithAlias.json"),
      ]
    ),
    .testTarget(
      name: "GeneratorTests",
      dependencies: [
        "DesignTokensGenerator"
      ],
      resources: [
        .copy("Resources/configuration.json"),
      ]
    )
  ]
)
