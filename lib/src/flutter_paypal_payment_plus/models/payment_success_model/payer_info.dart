import 'package:equatable/equatable.dart';
import 'shipping_address.dart';

/// Represents detailed information about the payer in a PayPal transaction.
///
/// This includes personal details such as the payer's name, email address,
/// unique payer ID, shipping address, and country code.
class PayerInfo extends Equatable {
  /// The email address of the payer.
  final String? email;

  /// The first name of the payer.
  final String? firstName;

  /// The last name of the payer.
  final String? lastName;

  /// The unique PayPal identifier of the payer.
  final String? payerId;

  /// The shipping address provided by the payer.
  final ShippingAddress? shippingAddress;

  /// The 2-letter ISO country code associated with the payer.
  final String? countryCode;

  /// Creates a new [PayerInfo] instance with optional fields.
  const PayerInfo({
    this.email,
    this.firstName,
    this.lastName,
    this.payerId,
    this.shippingAddress,
    this.countryCode,
  });

  /// Constructs a [PayerInfo] instance from a JSON map.
  ///
  /// Typically used when parsing response data from the PayPal API.
  factory PayerInfo.fromJson(Map<String, dynamic> json) => PayerInfo(
        email: json['email'] as String?,
        firstName: json['first_name'] as String?,
        lastName: json['last_name'] as String?,
        payerId: json['payer_id'] as String?,
        shippingAddress: json['shipping_address'] == null
            ? null
            : ShippingAddress.fromJson(
                json['shipping_address'] as Map<String, dynamic>,
              ),
        countryCode: json['country_code'] as String?,
      );

  /// Converts the [PayerInfo] instance to a JSON map.
  ///
  /// Useful for serializing the payer data for network or storage operations.
  Map<String, dynamic> toJson() => {
        'email': email,
        'first_name': firstName,
        'last_name': lastName,
        'payer_id': payerId,
        'shipping_address': shippingAddress?.toJson(),
        'country_code': countryCode,
      };

  /// The list of properties used for equality comparison.
  @override
  List<Object?> get props {
    return [email, firstName, lastName, payerId, shippingAddress, countryCode];
  }
}
