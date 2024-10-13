import Foundation

package typealias Path = [String]

/// The possible values of a design token.
package enum TokenValue: Equatable {
  case color(Color)
  case dimension(Dimension)
  case alias(Path)
}
