part of '../../paypal_checkout_view.dart';

/// A model representing the response from a successful PayPal payment execution.
///
/// This model encapsulates:
/// - Whether there was an error
/// - An optional message describing the result
/// - Optional data containing additional payment details
///
/// Used typically as a response from the `executePayment` method in PayPal integration.
class PaymentSuccessModel extends Equatable {
  /// Indicates whether an error occurred during the payment execution.
  final bool? error;

  /// A human-readable message describing the result of the payment execution.
  final String? message;

  /// Additional payment data returned by PayPal upon successful execution.
  final Data? data;

  /// Creates a new instance of [PaymentSuccessModel].
  ///
  /// All parameters are optional to accommodate partial responses or errors.
  const PaymentSuccessModel({this.error, this.message, this.data});

  /// Constructs a [PaymentSuccessModel] from a JSON map.
  ///
  /// This is typically used to deserialize a response received from the PayPal API.
  factory PaymentSuccessModel.fromJson(Map<String, dynamic> json) {
    return PaymentSuccessModel(
      error: json['error'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
    );
  }

  /// Converts this model instance to a JSON map.
  ///
  /// Useful for serializing the model for storage, debugging, or further processing.
  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        'data': data?.toJson(),
      };

  /// Used by `Equatable` to compare instances.
  ///
  /// Ensures that object equality works based on content rather than reference.
  @override
  List<Object?> get props => [error, message, data];
}
