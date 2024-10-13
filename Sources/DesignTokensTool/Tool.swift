import ArgumentParser
import Foundation

@main
struct Tool: ParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "design-tokens",
    abstract: "Generate, and manage an interface for your design tokens.",
    subcommands: [Init.self, Generate.self]
  )
}
