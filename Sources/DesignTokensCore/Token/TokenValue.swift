import Foundation

/// The possible values of a design token.
enum TokenValue: Equatable {
  case color(Color)
  case dimension(Dimension)
  case alias(Path)
  case gradient(Gradient)
}

extension TokenValue: DecodableWithConfiguration {
  init(from decoder: any Decoder, configuration: TokenValueDecodingConfiguration) throws {
    do {
      self = try Self.decodeAlias(from: decoder, with: configuration)
    } catch {
      self = try Self.decodeValue(from: decoder, with: configuration)
    }
  }
}

extension TokenValue {
  private static func decodeValue(from decoder: any Decoder, with configuration: DecodingConfiguration) throws -> TokenValue {
    guard let type = configuration.type else {
      do {
        return try Self.decodeAlias(from: decoder, with: configuration)
      } catch {
        throw DecodingFailure.missingType(tokenName: configuration.name, tokenPath: configuration.path)
      }
    }

    switch type {
    case .color:
      return try Self.decodeColor(from: decoder, with: configuration)

    case .dimension:
      return try Self.decodeDimension(from: decoder, with: configuration)

    case .gradient:
      return try Self.decodeGradient(from: decoder, with: configuration)
    }
  }

  private static func decodeAlias(from decoder: any Decoder, with configuration: DecodingConfiguration) throws -> TokenValue {
    let stringValueContainer = try decoder.singleValueContainer()
    let stringValue = try stringValueContainer.decode(String.self)

    let alias = try Alias(stringValue)
    return .alias(alias.path)
  }

  private static func decodeColor(from decoder: any Decoder, with configuration: DecodingConfiguration) throws -> TokenValue {
    let stringValueContainer = try decoder.singleValueContainer()
    let stringValue = try stringValueContainer.decode(String.self)

    do {
      let color = try Color(stringValue)
      return .color(color)
    } catch {
      throw DecodingFailure.invalidColorValue(tokenName: configuration.name, tokenPath: configuration.path, valueFailure: error)
    }
  }

  private static func decodeDimension(from decoder: any Decoder, with configuration: DecodingConfiguration) throws -> TokenValue {
    let stringValueContainer = try decoder.singleValueContainer()
    let stringValue = try stringValueContainer.decode(String.self)

    do {
      let dimension = try Dimension(stringValue)
      return .dimension(dimension)
    } catch {
      throw DecodingFailure.invalidDimensionValue(tokenName: configuration.name, tokenPath: configuration.path, valueFailure: error)
    }
  }

  private static func decodeGradient(from decoder: any Decoder, with configuration: DecodingConfiguration) throws -> TokenValue {
    let container = try decoder.singleValueContainer()

    do {
      let gradient = try container.decode(Gradient.self)
      return .gradient(gradient)
    } catch {
      throw DecodingFailure.invalidGradientValue(tokenName: configuration.name, tokenPath: configuration.path)
    }
  }
}
