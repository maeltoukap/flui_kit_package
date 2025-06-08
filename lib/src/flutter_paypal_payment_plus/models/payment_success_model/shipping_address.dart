import 'package:equatable/equatable.dart';

/// Represents the shipping address details for a PayPal transaction.
///
/// This model includes information about the recipient's name and the
/// shipping address components such as street, city, state, postal code,
/// and country code.
class ShippingAddress extends Equatable {
  /// Full name of the recipient.
  final String? recipientName;

  /// First line of the street address.
  final String? line1;

  /// City of the shipping address.
  final String? city;

  /// State or province of the shipping address.
  final String? state;

  /// Postal or ZIP code.
  final String? postalCode;

  /// Country code in ISO 3166-1 alpha-2 format.
  final String? countryCode;

  /// Creates a [ShippingAddress] instance.
  const ShippingAddress({
    this.recipientName,
    this.line1,
    this.city,
    this.state,
    this.postalCode,
    this.countryCode,
  });

  /// Creates an instance from a JSON map.
  ///
  /// Typically used when parsing API response data.
  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      recipientName: json['recipient_name'] as String?,
      line1: json['line1'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      postalCode: json['postal_code'] as String?,
      countryCode: json['country_code'] as String?,
    );
  }

  /// Converts this instance to JSON.
  ///
  /// Useful for sending data back to APIs or for serialization.
  Map<String, dynamic> toJson() => {
        'recipient_name': recipientName,
        'line1': line1,
        'city': city,
        'state': state,
        'postal_code': postalCode,
        'country_code': countryCode,
      };

  @override
  List<Object?> get props => [
        recipientName,
        line1,
        city,
        state,
        postalCode,
        countryCode,
      ];
}
