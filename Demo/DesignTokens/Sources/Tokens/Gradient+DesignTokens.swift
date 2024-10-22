// Generated with swift-design-tokens – https://github.com/gaetanomatonti/swift-design-tokens

public struct GradientToken {
  public struct Stop {
    let color: ColorToken
    let position: NumberToken
  }
  
  let stops: [Stop]
}

extension GradientToken {

  // MARK: - Tokens

  public static let background = GradientToken(
    stops: [
      GradientToken.Stop(
        color: ColorToken(red: 0.10980392156862745, green: 0.10980392156862745, blue: 0.10980392156862745, alpha: 1.0),
        position: NumberToken.gradientStart
      ),
      GradientToken.Stop(
        color: ColorToken.black900,
        position: NumberToken(value: 1.0)
      ),
    ]
  )

}

#if canImport(SwiftUI)
import SwiftUI

public extension Gradient {
  init(token: GradientToken) {
    self.init(stops: token.stops.map { Gradient.Stop(token: $0) })
  }
  
  static func token(_ token: GradientToken) -> Gradient {
    Gradient(token: token)
  }
}

public extension Gradient.Stop {
  init(token: GradientToken.Stop) {
    self.init(color: .token(token.color), location: .token(number: token.position))
  }
}
#endif
