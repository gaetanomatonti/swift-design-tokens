// Generated with swift-design-tokens – https://github.com/gaetanomatonti/swift-design-tokens

public struct ColorToken {
  let red: CGFloat
  let green: CGFloat
  let blue: CGFloat
  let alpha: CGFloat
}

extension ColorToken {

  // MARK: - Tokens

  public static let black800 = ColorToken(red: 0.10980392156862745, green: 0.10980392156862745, blue: 0.10980392156862745, alpha: 1.0)
  public static let black900 = ColorToken(red: 0.0784313725490196, green: 0.0784313725490196, blue: 0.0784313725490196, alpha: 1.0)
  public static let white = ColorToken(red: 0.9686274509803922, green: 0.9607843137254902, blue: 0.984313725490196, alpha: 1.0)
  public static let purple200 = ColorToken(red: 0.7450980392156863, green: 0.6705882352941176, blue: 0.9725490196078431, alpha: 1.0)

  // MARK: - Aliases

  public static var backgroundContainer: ColorToken { black800 }
  public static var backgroundBase: ColorToken { black900 }
  public static var textPrimary: ColorToken { white }
  public static var textLink: ColorToken { purple200 }
}

#if canImport(SwiftUI)
import SwiftUI

public extension Color {
  init(token: ColorToken) {
    self.init(red: token.red, green: token.green, blue: token.blue, opacity: token.alpha)
  }
  
  static func token(_ token: ColorToken) -> Color {
    Color(token: token)
  }
}

public extension ShapeStyle where Self == Color {
  static func token(_ token: ColorToken) -> Color {
    Color(token: token)
  }
}
#endif

#if canImport(UIKit)
import UIKit

public extension UIColor {
  convenience init(token: ColorToken) {
    self.init(red: token.red, green: token.green, blue: token.blue, alpha: token.alpha)
  }
  
  static func token(_ token: ColorToken) -> UIColor {
    UIColor(token: token)
  }
}
#endif
