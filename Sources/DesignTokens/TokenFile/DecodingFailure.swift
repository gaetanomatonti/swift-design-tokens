import Foundation

enum DecodingFailure: Error {
  case invalidCodingPath
  case missingType
}
