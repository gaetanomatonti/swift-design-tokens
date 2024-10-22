// Generated with swift-design-tokens – https://github.com/gaetanomatonti/swift-design-tokens

public struct NumberToken {
  let value: CGFloat
}

extension NumberToken {

  // MARK: - Tokens

  public static let gradientStart = NumberToken(value: 0.0)
}

#if canImport(Foundation)
import Foundation

public extension CGFloat {
  init(number: NumberToken) {
    self = number.value
  }
  
  static func number(_ token: NumberToken) -> CGFloat {
    token.value
  }
}
#endif
