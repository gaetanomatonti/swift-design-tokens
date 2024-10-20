import Foundation

/// A type contains either a token value, or an alias.
enum AliasOr<Value>: Sendable where Value: Sendable {
  case value(Value)
  case alias(Alias)

  static func alias(_ reference: Path) -> AliasOr<Value> {
    AliasOr.alias(Alias(reference: reference))
  }
}

extension AliasOr: Decodable where Value: Decodable {
  init(from decoder: any Decoder) throws {
    let container = try decoder.singleValueContainer()

    do {
      let value = try container.decode(Value.self)
      self = .value(value)
    } catch {
      let alias = try container.decode(Alias.self)
      self = .alias(alias)
    }
  }
}

extension AliasOr: Equatable where Value: Equatable {}
