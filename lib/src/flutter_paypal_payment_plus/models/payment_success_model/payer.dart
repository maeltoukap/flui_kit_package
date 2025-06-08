import 'package:equatable/equatable.dart';
import 'payer_info.dart';

/// Represents the payer information in a PayPal payment.
///
/// This class encapsulates the payment method used by the payer,
/// their current status, and detailed information about the payer.
class Payer extends Equatable {
  /// The payment method used by the payer (e.g., "paypal").
  final String? paymentMethod;

  /// The status of the payer in the payment process.
  ///
  /// This can indicate whether the payer has approved, denied, or completed the payment.
  final String? status;

  /// Detailed information about the payer.
  final PayerInfo? payerInfo;

  /// Creates a new [Payer] instance.
  const Payer({this.paymentMethod, this.status, this.payerInfo});

  /// Creates a [Payer] instance from a JSON map.
  ///
  /// Useful for parsing API responses.
  factory Payer.fromJson(Map<String, dynamic> json) => Payer(
        paymentMethod: json['payment_method'] as String?,
        status: json['status'] as String?,
        payerInfo: json['payer_info'] == null
            ? null
            : PayerInfo.fromJson(json['payer_info'] as Map<String, dynamic>),
      );

  /// Converts the [Payer] instance to a JSON map.
  ///
  /// Useful for sending data to APIs or storing locally.
  Map<String, dynamic> toJson() => {
        'payment_method': paymentMethod,
        'status': status,
        'payer_info': payerInfo?.toJson(),
      };

  /// Properties used for equality comparison.
  @override
  List<Object?> get props => [paymentMethod, status, payerInfo];
}
