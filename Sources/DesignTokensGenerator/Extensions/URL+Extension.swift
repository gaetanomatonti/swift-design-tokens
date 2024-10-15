import Foundation

extension URL {
  /// A `Bool` indicating whether the `URL` represents a directory.
  var isDirectory: Bool {
    let values = try? resourceValues(forKeys: [.isDirectoryKey])
    return values?.isDirectory ?? false
  }
}
