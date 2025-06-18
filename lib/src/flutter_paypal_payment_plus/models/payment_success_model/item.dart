import 'package:equatable/equatable.dart';

/// Represents an individual item in a PayPal transaction.
///
/// Each item includes details such as name, price, currency, tax, and quantity.
/// This model is typically used within an [ItemList] to describe all the items
/// purchased in a payment.
class Item extends Equatable {
  /// The name or title of the item.
  final String? name;

  /// The price of a single unit of the item (excluding tax).
  final String? price;

  /// The currency used for the item price (e.g., "USD", "EUR").
  final String? currency;

  /// The tax amount applied to a single unit of the item.
  final String? tax;

  /// The number of units of this item being purchased.
  final int? quantity;

  /// Creates a new [Item] instance with optional parameters.
  const Item({
    this.name,
    this.price,
    this.currency,
    this.tax,
    this.quantity,
  });

  /// Creates an [Item] instance from a JSON map.
  ///
  /// Commonly used when parsing item details from PayPal's API.
  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json['name'] as String?,
        price: json['price'] as String?,
        currency: json['currency'] as String?,
        tax: json['tax'] as String?,
        quantity: json['quantity'] as int?,
      );

  /// Converts the [Item] instance to a JSON map.
  ///
  /// Useful when sending the item data in an API request.
  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'currency': currency,
        'tax': tax,
        'quantity': quantity,
      };

  /// Provides the list of properties used for equality comparison.
  @override
  List<Object?> get props => [name, price, currency, tax, quantity];
}
