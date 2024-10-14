import Foundation

struct DimensionConfiguration: Codable, Equatable {
  let path: String

  init(path: String) {
    self.path = path
  }
}
