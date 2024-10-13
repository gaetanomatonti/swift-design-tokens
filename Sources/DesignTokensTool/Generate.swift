import ArgumentParser
import Foundation

@main
struct Generate: ParsableCommand {
  @Option(name: .shortAndLong, help: "The path to the configuration JSON file.")
  var path: String

  func run() throws {
    print(path)
  }
}
