import Foundation

extension KeyedDecodingContainer<AnyCodingKey> {
  /// Checks whether the nested container keyed by the passed key is a container of token properties.
  ///
  /// When decoding a design token JSON, you may encounter groups or token containers.
  /// These can be distinguished [by looking at their contents](https://tr.designtokens.org/format/#additional-group-properties).
  /// A token container contains a `$value` property; a group container does not.
  ///
  /// ```json
  /// {
  ///   "primary": {
  ///     "$value": "#FF00FF",
  ///     "$type": "color"
  ///   },
  ///   "colors": {
  ///     "$description": "This is a group of colors",
  ///     "$type": "color",
  ///     "secondary": {
  ///       "$value": "#000000"
  ///     }
  ///   }
  /// }
  /// ```
  ///
  /// In the previous example, calling this method for the `"primary"` coding key, will return `true`.
  /// Calling it for the `"colors"` coding key will return `false` instead.
  ///
  /// - Parameter key: The key of the nested container.
  /// - Returns: A `Bool` indicating whether the nested container contains token properties.
  var isTokenContainer: Bool {
    allKeys.contains { $0 == .value }
  }
}
