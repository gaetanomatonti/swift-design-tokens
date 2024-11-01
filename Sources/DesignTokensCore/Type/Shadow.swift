import Foundation

struct Shadow {
  let color: AliasOr<Color>
  let offsetX: AliasOr<Dimension>
  let offsetY: AliasOr<Dimension>
  let blur: AliasOr<Dimension>
  let spread: AliasOr<Dimension>
  var inset: Bool = false
}

extension Shadow: Decodable {}

extension Shadow: Equatable {}
