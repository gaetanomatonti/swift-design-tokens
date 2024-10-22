// Generated with swift-design-tokens – https://github.com/gaetanomatonti/swift-design-tokens

public struct DimensionToken {
  let value: CGFloat
}

extension DimensionToken {

  // MARK: - Tokens

  public static let medium = DimensionToken(value: 16.0)
  public static let small = DimensionToken(value: 8.0)
}

#if canImport(Foundation)
import Foundation

public extension CGFloat {
  static func token(dimension: DimensionToken) -> CGFloat {
    dimension.value
  }
}
#endif
