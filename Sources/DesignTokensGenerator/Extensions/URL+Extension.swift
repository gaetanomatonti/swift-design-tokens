import Foundation

extension URL {
  var isDirectory: Bool {
    let values = try? resourceValues(forKeys: [.isDirectoryKey])
    return values?.isDirectory ?? false
  }
}
