import Foundation

struct Configuration: Codable, Equatable {
  let input: String
  let output: Output

  init(_ output: Output, from input: String) {
    self.input = input
    self.output = output
  }
}

extension Configuration {
  struct Output: Codable, Equatable {
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
  enum Format: Codable, Equatable {
    enum CodingKeys: String, CodingKey {
      case sourceCode
    }

    case sourceCode([Framework])

    init(from decoder: any Decoder) throws {
      let container = try decoder.container(keyedBy: CodingKeys.self)

      assert(container.allKeys.count == 1, "Container should not contain more than one key.")

      let key = container.allKeys.first!

      switch key {
      case .sourceCode:
        let frameworks = try container.decode([Framework].self, forKey: .sourceCode)
        self = .sourceCode(frameworks)
      }
    }

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
  enum Framework: String, Codable, Equatable {
    case uiKit = "UIKit"
    case swiftUI = "SwiftUI"
  }
}
