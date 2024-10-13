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
      name: "DesignTokensTool",
      targets: [
        "DesignTokensTool"
      ]
    )
  ],
  targets: [
    .executableTarget(
      name: "DesignTokensTool",
      dependencies: ["DesignTokensCore"]
    ),
    .target(
      name: "DesignTokensCore"
    ),
    .testTarget(
      name: "DesignTokensCoreTests",
      dependencies: ["DesignTokensCore"],
      resources: [
        .copy("Resources/alias.json"),
        .copy("Resources/color.json"),
        .copy("Resources/groups.json"),
        .copy("Resources/missingTypeFailure.json"),
        .copy("Resources/missingTypeWithAlias.json"),
      ]
    ),
  ]
)
