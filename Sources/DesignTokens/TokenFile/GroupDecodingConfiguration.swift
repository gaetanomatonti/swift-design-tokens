import Foundation

struct GroupDecodingConfiguration {
  let type: ValueType?

  init(type: ValueType? = nil) {
    self.type = type
  }
}
