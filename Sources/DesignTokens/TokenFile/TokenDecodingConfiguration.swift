import Foundation

struct TokenDecodingConfiguration {
  let type: ValueType?

  init(type: ValueType? = nil) {
    self.type = type
  }
}
