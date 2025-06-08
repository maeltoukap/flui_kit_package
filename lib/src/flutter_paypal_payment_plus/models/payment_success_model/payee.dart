import 'package:equatable/equatable.dart';

/// Represents the recipient (merchant) of a PayPal payment.
///
/// This object contains information about the merchant receiving the funds,
/// such as their unique PayPal merchant ID and email address.
class Payee extends Equatable {
  /// The unique identifier of the merchant in the PayPal system.
  final String? merchantId;

  /// The email address associated with the merchant's PayPal account.
  final String? email;

  /// Creates a new [Payee] instance.
  ///
  /// Both [merchantId] and [email] are optional.
  const Payee({this.merchantId, this.email});

  /// Creates a [Payee] instance from a JSON map.
  ///
  /// This is typically used when parsing data from PayPal API responses.
  factory Payee.fromJson(Map<String, dynamic> json) => Payee(
        merchantId: json['merchant_id'] as String?,
        email: json['email'] as String?,
      );

  /// Converts the [Payee] instance to a JSON map.
  ///
  /// Useful when sending structured data to APIs.
  Map<String, dynamic> toJson() => {
        'merchant_id': merchantId,
        'email': email,
      };

  /// Returns the list of properties used for equality comparison.
  @override
  List<Object?> get props => [merchantId, email];
}
