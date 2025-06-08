import 'package:equatable/equatable.dart';

import 'details.dart';

/// A model representing the total amount of a PayPal transaction.
///
/// This class includes the total value, currency, and optional breakdown details
/// like subtotal, tax, and shipping (via [Details] model).
///
/// It is typically part of a [Transaction] object returned by PayPal's payment API.
class Amount extends Equatable {
  /// The total amount of the transaction.
  ///
  /// This includes all applicable charges such as subtotal, tax, and shipping.
  final String? total;

  /// The currency used for the transaction (e.g., "USD", "EUR").
  final String? currency;

  /// A breakdown of the amount including subtotal, tax, and shipping costs.
  final Details? details;

  /// Creates a new [Amount] instance.
  ///
  /// All fields are optional and nullable to support flexible parsing from API responses.
  const Amount({this.total, this.currency, this.details});

  /// Creates an [Amount] instance from a JSON map.
  ///
  /// This is typically used to parse the response received from the PayPal API.
  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        total: json['total'] as String?,
        currency: json['currency'] as String?,
        details: json['details'] == null
            ? null
            : Details.fromJson(json['details'] as Map<String, dynamic>),
      );

  /// Converts this [Amount] instance into a JSON map.
  ///
  /// Useful for logging, caching, or sending data to APIs.
  Map<String, dynamic> toJson() => {
        'total': total,
        'currency': currency,
        'details': details?.toJson(),
      };

  /// Provides a list of properties for value comparison via `Equatable`.
  @override
  List<Object?> get props => [total, currency, details];
}
