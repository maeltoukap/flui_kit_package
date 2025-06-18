import 'package:equatable/equatable.dart';

import 'amount.dart';
import 'link.dart';
import 'transaction_fee.dart';

/// Represents a PayPal sale transaction.
///
/// This class encapsulates all relevant details regarding a completed sale,
/// including payment amount, transaction fees, payment mode, and related metadata.
class Sale extends Equatable {
  /// Unique identifier of the sale.
  final String? id;

  /// Current state of the sale (e.g., "completed", "pending").
  final String? state;

  /// The amount involved in the sale.
  final Amount? amount;

  /// The mode of payment used for this sale.
  final String? paymentMode;

  /// Eligibility status for PayPal's purchase protection.
  final String? protectionEligibility;

  /// Detailed type of the protection eligibility.
  final String? protectionEligibilityType;

  /// Transaction fee associated with this sale.
  final TransactionFee? transactionFee;

  /// ID of the parent payment related to this sale.
  final String? parentPayment;

  /// Timestamp when the sale was created.
  final String? createTime;

  /// Timestamp when the sale was last updated.
  final String? updateTime;

  /// List of related links (e.g., for self, refund).
  final List<Link>? links;

  /// Optional descriptor to be displayed on the payer's statement.
  final String? softDescriptor;

  /// Creates a [Sale] instance.
  const Sale({
    this.id,
    this.state,
    this.amount,
    this.paymentMode,
    this.protectionEligibility,
    this.protectionEligibilityType,
    this.transactionFee,
    this.parentPayment,
    this.createTime,
    this.updateTime,
    this.links,
    this.softDescriptor,
  });

  /// Constructs a [Sale] instance from a JSON map.
  ///
  /// Used primarily when decoding API responses.
  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
        id: json['id'] as String?,
        state: json['state'] as String?,
        amount: json['amount'] == null
            ? null
            : Amount.fromJson(json['amount'] as Map<String, dynamic>),
        paymentMode: json['payment_mode'] as String?,
        protectionEligibility: json['protection_eligibility'] as String?,
        protectionEligibilityType: json['protection_eligibility_type'] as String?,
        transactionFee: json['transaction_fee'] == null
            ? null
            : TransactionFee.fromJson(json['transaction_fee'] as Map<String, dynamic>),
        parentPayment: json['parent_payment'] as String?,
        createTime: json['create_time'] as String?,
        updateTime: json['update_time'] as String?,
        links: (json['links'] as List<dynamic>?)
            ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
            .toList(),
        softDescriptor: json['soft_descriptor'] as String?,
      );

  /// Converts the [Sale] instance to a JSON map.
  ///
  /// Useful for serialization when sending data back to an API or storing locally.
  Map<String, dynamic> toJson() => {
        'id': id,
        'state': state,
        'amount': amount?.toJson(),
        'payment_mode': paymentMode,
        'protection_eligibility': protectionEligibility,
        'protection_eligibility_type': protectionEligibilityType,
        'transaction_fee': transactionFee?.toJson(),
        'parent_payment': parentPayment,
        'create_time': createTime,
        'update_time': updateTime,
        'links': links?.map((e) => e.toJson()).toList(),
        'soft_descriptor': softDescriptor,
      };

  @override
  List<Object?> get props => [
        id,
        state,
        amount,
        paymentMode,
        protectionEligibility,
        protectionEligibilityType,
        transactionFee,
        parentPayment,
        createTime,
        updateTime,
        links,
        softDescriptor,
      ];
}
