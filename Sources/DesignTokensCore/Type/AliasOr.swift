import Foundation

// TODO: Check if we can handle an enum with Stencil

/// A type that can contain either a token value, or an alias, but not both.
struct AliasOr<Value>: Sendable where Value: Sendable {

  // MARK: - Stored Properties

  let value: Value?

  let alias: Alias?

  // MARK: - Init

  init(value: Value) {
    self.value = value
    self.alias = nil
  }

  init(alias: Alias) {
    self.value = nil
    self.alias = alias
  }

  static func alias(_ reference: Path) -> AliasOr<Value> {
    AliasOr(alias: Alias(reference: reference))
  }

  static func color(_ value: Color) -> AliasOr<Color> {
    AliasOr<Color>(value: value)
  }

  static func float(_ value: CGFloat) -> AliasOr<CGFloat> {
    AliasOr<CGFloat>(value: value)
  }
}

extension AliasOr: Decodable where Value: Decodable {
  init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()

    do {
      value = try container.decode(Value.self)
      alias = nil
    } catch {
      value = nil
      alias = try container.decode(Alias.self)
    }
  }
}

extension AliasOr: Equatable where Value: Equatable {}
