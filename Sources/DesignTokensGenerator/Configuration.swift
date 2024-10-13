import Foundation

struct Configuration: Codable {
  let input: String
  let output: Output

  init(_ output: Output, from input: String) {
    self.input = input
    self.output = output
  }
}

extension Configuration {
  struct Output: Codable {
    let path: String
    let format: Format

    private init(path: String, format: Format) {
      self.path = path
      self.format = format
    }

    static func output(at path: String, with format: Format) -> Output {
      Output(path: path, format: format)
    }
  }
}

extension Configuration.Output {
  enum Format: Codable {
    enum CodingKeys: String, CodingKey {
      case sourceCode
    }

    case sourceCode([Framework])

    func encode(to encoder: any Encoder) throws {
      var container = encoder.container(keyedBy: CodingKeys.self)

      switch self {
      case .sourceCode(let frameworks):
        try container.encode(frameworks, forKey: .sourceCode)
      }
    }
  }
}

extension Configuration.Output.Format {
  enum Framework: String, Codable {
    case uiKit = "UIKit"
    case swiftUI = "SwiftUI"
  }
}
