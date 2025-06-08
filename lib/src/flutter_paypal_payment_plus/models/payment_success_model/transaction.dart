import 'package:equatable/equatable.dart';

import 'amount.dart';
import 'item_list.dart';
import 'payee.dart';
import 'related_resource.dart';

/// Represents a financial transaction in the payment process.
///
/// This class encapsulates details such as the transaction amount,
/// payee information, description, items involved, and related resources.
///
/// Fields:
/// - [amount]: The total amount and currency of the transaction.
/// - [payee]: The recipient of the payment.
/// - [description]: A brief description of the transaction.
/// - [softDescriptor]: A soft descriptor to appear on the payer’s statement.
/// - [itemList]: The list of items involved in the transaction.
/// - [relatedResources]: Additional related resources linked to this transaction.
///
/// Supports JSON serialization/deserialization and value equality.
class Transaction extends Equatable {
  /// The total amount and currency of the transaction.
  final Amount? amount;

  /// The recipient or payee of the transaction.
  final Payee? payee;

  /// A description of the transaction.
  final String? description;

  /// Soft descriptor for payer statement display.
  final String? softDescriptor;

  /// The list of items included in the transaction.
  final ItemList? itemList;

  /// List of related resources such as sale information.
  final List<RelatedResource>? relatedResources;

  /// Constructs a [Transaction] instance.
  const Transaction({
    this.amount,
    this.payee,
    this.description,
    this.softDescriptor,
    this.itemList,
    this.relatedResources,
  });

  /// Creates a [Transaction] object from a JSON map.
  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        amount: json['amount'] == null
            ? null
            : Amount.fromJson(json['amount'] as Map<String, dynamic>),
        payee: json['payee'] == null
            ? null
            : Payee.fromJson(json['payee'] as Map<String, dynamic>),
        description: json['description'] as String?,
        softDescriptor: json['soft_descriptor'] as String?,
        itemList: json['item_list'] == null
            ? null
            : ItemList.fromJson(json['item_list'] as Map<String, dynamic>),
        relatedResources: (json['related_resources'] as List<dynamic>?)
            ?.map((e) => RelatedResource.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  /// Converts the [Transaction] instance to a JSON map.
  Map<String, dynamic> toJson() => {
        'amount': amount?.toJson(),
        'payee': payee?.toJson(),
        'description': description,
        'soft_descriptor': softDescriptor,
        'item_list': itemList?.toJson(),
        'related_resources': relatedResources?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      amount,
      payee,
      description,
      softDescriptor,
      itemList,
      relatedResources,
    ];
  }
}
