import 'package:equatable/equatable.dart';

/// Represents a hypermedia link object returned in PayPal API responses.
///
/// These links guide the client on how to proceed with various actions such as
/// executing a payment or redirecting the user for approval.
class Link extends Equatable {
  /// The fully qualified URL to execute or continue an action.
  final String? href;

  /// The relationship of the link to the resource (e.g., "approval_url", "execute").
  final String? rel;

  /// The HTTP method to be used when accessing the link (e.g., "GET", "POST").
  final String? method;

  /// Creates a new [Link] instance with optional parameters.
  const Link({this.href, this.rel, this.method});

  /// Creates a [Link] instance from a JSON map.
  ///
  /// Useful when decoding link data returned by PayPal’s REST API.
  factory Link.fromJson(Map<String, dynamic> json) => Link(
        href: json['href'] as String?,
        rel: json['rel'] as String?,
        method: json['method'] as String?,
      );

  /// Converts the [Link] instance to a JSON map.
  ///
  /// Commonly used when sending structured data back to an API.
  Map<String, dynamic> toJson() => {
        'href': href,
        'rel': rel,
        'method': method,
      };

  /// Provides the properties used for value comparison.
  @override
  List<Object?> get props => [href, rel, method];
}
