import Foundation

/// A type representing a gradient.
struct Gradient {
  /// A type representing the stops of a gradient.
  struct Stop {
    /// The color of the stop in the gradient.
    let color: Color

    /// The position of the stop in the gradient.
    let position: CGFloat
  }

  /// The stops of the gradient.
  let stops: [Stop]
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
