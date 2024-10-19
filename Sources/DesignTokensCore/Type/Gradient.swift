import Foundation

/// A type representing a gradient.
struct Gradient: Sendable {
  /// A type representing the stops of a gradient.
  struct Stop: Sendable {
    /// The color of the stop in the gradient.
    let color: AliasOr<Color>

    /// The position of the stop in the gradient.
    let position: AliasOr<CGFloat>
  }

  /// The stops of the gradient.
  let stops: [Stop]
}

extension Gradient {
  static let blueToRed = Gradient(
    stops: [
      Gradient.Stop(color: .color(.blue), position: .float(0)),
      Gradient.Stop(color: .color(.red), position: .float(1)),
    ]
  )
}

extension Gradient: Decodable {
  init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stops = try container.decode([Stop].self)

    self.stops = stops
  }
}

extension Gradient: Equatable {}

extension Gradient.Stop: Decodable {}

extension Gradient.Stop: Equatable {}
