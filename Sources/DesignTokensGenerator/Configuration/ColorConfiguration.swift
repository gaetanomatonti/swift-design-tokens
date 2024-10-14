import Foundation

struct ColorConfiguration: Codable, Equatable {
  let path: String

  let formats: [ColorFormat]

  init(path: String, formats: [ColorFormat]) {
    self.path = path
    self.formats = formats
  }
}
