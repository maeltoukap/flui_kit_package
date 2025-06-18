import 'package:equatable/equatable.dart';

import 'item.dart';
import 'shipping_address.dart';

/// A model representing a list of items and an optional shipping address
/// in a PayPal transaction.
///
/// Typically used as part of the [Transaction] model to provide detailed
/// information about the purchased items and where they should be shipped.
class ItemList extends Equatable {
  /// The list of items involved in the transaction.
  ///
  /// Each [Item] represents a product or service with its own details.
  final List<Item>? items;

  /// The shipping address where the items should be delivered.
  final ShippingAddress? shippingAddress;

  /// Creates a new [ItemList] instance.
  ///
  /// Both [items] and [shippingAddress] are optional to support various use cases.
  const ItemList({this.items, this.shippingAddress});

  /// Creates an [ItemList] instance from a JSON map.
  ///
  /// Useful for parsing data returned by PayPal's API.
  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        items: (json['items'] as List<dynamic>?)
            ?.map((e) => Item.fromJson(e as Map<String, dynamic>))
            .toList(),
        shippingAddress: json['shipping_address'] == null
            ? null
            : ShippingAddress.fromJson(
                json['shipping_address'] as Map<String, dynamic>,
              ),
      );

  /// Converts this [ItemList] instance to a JSON map.
  ///
  /// This is useful when sending the object in API requests or saving it locally.
  Map<String, dynamic> toJson() => {
        'items': items?.map((e) => e.toJson()).toList(),
        'shipping_address': shippingAddress?.toJson(),
      };

  /// Provides a list of properties used by `Equatable` for value comparison.
  @override
  List<Object?> get props => [items, shippingAddress];
}
