import Foundation

/// The possible formats that can be used to translate a color token.
enum ColorFormat: String, Codable, Equatable {
  /// Color tokens translated into `UIColor`.
  case uiKit = "UIKit"

  /// Color tokens translated into `Color`.
  case swiftUI = "SwiftUI"
}
