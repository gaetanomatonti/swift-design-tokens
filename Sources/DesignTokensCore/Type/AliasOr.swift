import Foundation

// TODO: Check if we can handle an enum with Stencil

/// A type that can contain either a token value, or an alias, but not both.
struct AliasOr<Value> {

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
