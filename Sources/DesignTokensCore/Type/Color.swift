import Foundation

/// A type representing a color.
struct Color {

  // MARK: - Stored Properties
  
  /// The red component of the color.
  let red: Double

  /// The green component of the color.
  let green: Double

  /// The blue component of the color.
  let blue: Double

  /// The alpha component of the color.
  let alpha: Double

  // MARK: - Init

  init(red: Double, green: Double, blue: Double, alpha: Double) {
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
  }

  init(_ hex: String) throws(ColorValueFailure) {
    let hex = hex
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .replacingOccurrences(of: "#", with: "")

    var rgb: UInt64 = 0

    var red: Double = 0.0
    var green: Double = 0.0
    var blue: Double = 0.0
    var alpha: Double = 1.0

    guard Scanner(string: hex).scanHexInt64(&rgb) else {
      throw .invalidHexString
    }

    switch hex.count {
    case 6:
      red = Double((rgb & 0xFF0000) >> 16) / 255.0
      green = Double((rgb & 0x00FF00) >> 8) / 255.0
      blue = Double(rgb & 0x0000FF) / 255.0

    case 8:
      red = Double((rgb & 0xFF000000) >> 24) / 255.0
      green = Double((rgb & 0x00FF0000) >> 16) / 255.0
      blue = Double((rgb & 0x0000FF00) >> 8) / 255.0
      alpha = Double(rgb & 0x000000FF) / 255.0

    default:
      throw .invalidHexString
    }

    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha
  }
}

extension Color {
  static let blue = Color(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
  static let red = Color(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0)
  static let white = Color(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
}

extension Color: Equatable {}

extension Color: Decodable {
  init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self)

    try self.init(stringValue)
  }
}
