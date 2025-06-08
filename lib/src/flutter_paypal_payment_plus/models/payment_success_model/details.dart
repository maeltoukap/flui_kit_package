import 'package:equatable/equatable.dart';

/// A model that provides a detailed breakdown of a PayPal transaction amount.
///
/// This class includes optional fields for:
/// - Subtotal (items cost)
/// - Shipping fee
/// - Insurance cost
/// - Handling fee
/// - Shipping discount
/// - General discount
///
/// It is typically used within the [Amount] model to represent detailed pricing information.
class Details extends Equatable {
  /// The total cost of items before any fees or discounts.
  final String? subtotal;

  /// The cost of shipping.
  final String? shipping;

  /// The cost of any insurance applied to the transaction.
  final String? insurance;

  /// Any handling fee applied by the merchant.
  final String? handlingFee;

  /// Discount applied specifically to the shipping cost.
  final String? shippingDiscount;

  /// A general discount applied to the transaction.
  final String? discount;

  /// Creates a new instance of [Details].
  ///
  /// All parameters are optional to allow flexible parsing from partial API responses.
  const Details({
    this.subtotal,
    this.shipping,
    this.insurance,
    this.handlingFee,
    this.shippingDiscount,
    this.discount,
  });

  /// Constructs a [Details] instance from a JSON map.
  ///
  /// Typically used when parsing the `details` field from a PayPal transaction.
  factory Details.fromJson(Map<String, dynamic> json) => Details(
        subtotal: json['subtotal'] as String?,
        shipping: json['shipping'] as String?,
        insurance: json['insurance'] as String?,
        handlingFee: json['handling_fee'] as String?,
        shippingDiscount: json['shipping_discount'] as String?,
        discount: json['discount'] as String?,
      );

  /// Converts the [Details] instance into a JSON map.
  ///
  /// Useful for serializing the model to send or store transaction breakdowns.
  Map<String, dynamic> toJson() => {
        'subtotal': subtotal,
        'shipping': shipping,
        'insurance': insurance,
        'handling_fee': handlingFee,
        'shipping_discount': shippingDiscount,
        'discount': discount,
      };

  /// Returns a list of fields used by `Equatable` to determine equality.
  @override
  List<Object?> get props {
    return [
      subtotal,
      shipping,
      insurance,
      handlingFee,
      shippingDiscount,
      discount,
    ];
  }
}
