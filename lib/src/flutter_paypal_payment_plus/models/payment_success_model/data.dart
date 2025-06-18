import 'package:equatable/equatable.dart';

import 'link.dart';
import 'payer.dart';
import 'transaction.dart';

/// A model class that represents detailed PayPal payment information.
///
/// This class is used to deserialize and work with payment data returned
/// from the PayPal API after a payment is executed successfully.
///
/// Includes general payment metadata, payer details, list of transactions,
/// and API links for further actions.
class Data extends Equatable {
  /// The unique ID of the payment.
  final String? id;

  /// The payment intent (e.g., 'sale', 'authorize').
  final String? intent;

  /// The current state/status of the payment (e.g., 'approved').
  final String? state;

  /// The cart ID associated with the payment session.
  final String? cart;

  /// Information about the payer.
  final Payer? payer;

  /// A list of transactions associated with the payment.
  final List<Transaction>? transactions;

  /// A list of failed transactions, if any (usually null on success).
  final List<dynamic>? failedTransactions;

  /// Timestamp of when the payment was created.
  final String? createTime;

  /// Timestamp of the last update to the payment.
  final String? updateTime;

  /// A list of actionable PayPal API links (e.g., self, execute, approval_url).
  final List<Link>? links;

  /// Creates a new instance of the [Data] model.
  ///
  /// All fields are optional to support partial or failed responses.
  const Data({
    this.id,
    this.intent,
    this.state,
    this.cart,
    this.payer,
    this.transactions,
    this.failedTransactions,
    this.createTime,
    this.updateTime,
    this.links,
  });

  /// Creates a new [Data] instance from a JSON map.
  ///
  /// Typically used to parse API responses from PayPal.
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as String?,
        intent: json['intent'] as String?,
        state: json['state'] as String?,
        cart: json['cart'] as String?,
        payer: json['payer'] == null
            ? null
            : Payer.fromJson(json['payer'] as Map<String, dynamic>),
        transactions: (json['transactions'] as List<dynamic>?)
            ?.map((e) => Transaction.fromJson(e as Map<String, dynamic>))
            .toList(),
        failedTransactions: json['failed_transactions'] as List<dynamic>?,
        createTime: json['create_time'] as String?,
        updateTime: json['update_time'] as String?,
        links: (json['links'] as List<dynamic>?)
            ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  /// Converts the [Data] instance to a JSON map.
  ///
  /// Useful for caching, logging, or sending data back to APIs.
  Map<String, dynamic> toJson() => {
        'id': id,
        'intent': intent,
        'state': state,
        'cart': cart,
        'payer': payer?.toJson(),
        'transactions': transactions?.map((e) => e.toJson()).toList(),
        'failed_transactions': failedTransactions,
        'create_time': createTime,
        'update_time': updateTime,
        'links': links?.map((e) => e.toJson()).toList(),
      };

  /// Returns a list of properties used by `Equatable` for value comparison.
  @override
  List<Object?> get props {
    return [
      id,
      intent,
      state,
      cart,
      payer,
      transactions,
      failedTransactions,
      createTime,
      updateTime,
      links,
    ];
  }
}
