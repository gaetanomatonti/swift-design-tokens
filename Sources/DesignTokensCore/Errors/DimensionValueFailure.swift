import Foundation

/// The possible failures related to dimension values.
enum DimensionValueFailure: ValueFailure {
  /// The value does not represent a valid dimension.
  case invalidStringValue

  /// The value of the dimension is not a valid number.
  case invalidValue
}
