import ProjectDescription

let project = Project(
  name: "DesignTokensDemo",
  options: .options(disableBundleAccessors: true),
  targets: [
    .target(
      name: "Demo",
      destinations: .iOS,
      product: .app,
      bundleId: "com.gaetanomatonti.design-tokens-demo",
      deploymentTargets: .iOS("16.0"),
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [:]
        ]
      ),
      sources: [
        .glob("App/Sources/**/*.swift")
      ],
      resources: [
        .glob(pattern: "App/Sources/**/*.xcassets")
      ]
    )
  ],
  resourceSynthesizers: []
)
