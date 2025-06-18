import 'package:equatable/equatable.dart';
import 'sale.dart';

/// Represents a resource related to a PayPal payment,
/// typically including the sale information.
///
/// This class is used to encapsulate details about related
/// payment resources such as sales transactions.
class RelatedResource extends Equatable {
  /// The sale transaction related to the payment.
  ///
  /// This may be null if no sale information is available.
  final Sale? sale;

  /// Creates a new [RelatedResource] instance.
  const RelatedResource({this.sale});

  /// Creates a [RelatedResource] instance from a JSON map.
  ///
  /// Used to parse related resource data from PayPal API responses.
  factory RelatedResource.fromJson(Map<String, dynamic> json) {
    return RelatedResource(
      sale: json['sale'] == null
          ? null
          : Sale.fromJson(json['sale'] as Map<String, dynamic>),
    );
  }

  /// Converts the [RelatedResource] instance to a JSON map.
  ///
  /// Useful for serializing the related resource data.
  Map<String, dynamic> toJson() => {'sale': sale?.toJson()};

  /// List of properties used for equality comparison.
  @override
  List<Object?> get props => [sale];
}
