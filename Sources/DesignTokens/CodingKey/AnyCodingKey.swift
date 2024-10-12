import Foundation

struct AnyCodingKey: CodingKey {
  let stringValue: String
  let intValue: Int?

  init?(stringValue: String) {
    self.stringValue = stringValue
    self.intValue = nil
  }
  init?(intValue: Int) {
    self.stringValue = intValue.description
    self.intValue = intValue
  }
}
