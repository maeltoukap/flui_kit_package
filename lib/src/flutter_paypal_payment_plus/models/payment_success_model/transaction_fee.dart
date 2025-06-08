import 'package:equatable/equatable.dart';

/// Represents the transaction fee with its amount and currency.
///
/// This class holds the fee value and its currency code.
/// It supports JSON serialization and deserialization,
/// and uses Equatable for value comparison.
///
/// Fields:
/// - [value]: The fee amount charged (as a string).
/// - [currency]: The currency code for the fee (e.g., "USD").
///
/// Usage example:
/// ```dart
/// final fee = TransactionFee(value: "5.00", currency: "USD");
/// final json = fee.toJson();
/// final feeFromJson = TransactionFee.fromJson(json);
/// ```
class TransactionFee extends Equatable {
  /// The amount of the transaction fee.
  final String? value;

  /// The currency code of the transaction fee.
  final String? currency;

  /// Constructor for creating a [TransactionFee].
  const TransactionFee({this.value, this.currency});

  /// Creates an instance from JSON data.
  factory TransactionFee.fromJson(Map<String, dynamic> json) {
    return TransactionFee(
      value: json['value'] as String?,
      currency: json['currency'] as String?,
    );
  }

  /// Converts the instance to JSON.
  Map<String, dynamic> toJson() => {'value': value, 'currency': currency};

  @override
  List<Object?> get props => [value, currency];
}
