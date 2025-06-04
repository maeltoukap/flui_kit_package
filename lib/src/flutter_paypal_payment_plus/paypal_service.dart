import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';

class PaypalServices {
  final String _clientId;
  final String _secretKey;
  final bool _sandboxMode;

  PaypalServices({
    required String clientId,
    required String secretKey,
    required bool sandboxMode,
  }) : _clientId = clientId,
       _secretKey = secretKey,
       _sandboxMode = sandboxMode;

  String get _baseUrl =>
      _sandboxMode
          ? "https://api-m.sandbox.paypal.com"
          : "https://api-m.paypal.com";

  Future<Map<String, dynamic>> getAccessToken() async {
    try {
      final authToken = base64Encode(utf8.encode("$_clientId:$_secretKey"));
      final response = await Dio().post(
        '$_baseUrl/v1/oauth2/token?grant_type=client_credentials',
        options: Options(
          headers: {
            'Authorization': 'Basic $authToken',
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
      );

      return {
        'error': false,
        'message': "Success",
        'token': response.data["access_token"],
      };
    } on DioException catch (e) {
      return {
        'error': true,
        'message': "Your PayPal credentials seem incorrect",
        'type': 'DioException Error On get Access Token',
        'error_explanation': e.response?.data?.toString() ?? e.message,
      };
    } catch (e) {
      return {
        'error': true,
        'message': "Unable to proceed, check your internet connection.",
        'type': 'Unknown Error On get Access Token',
        'error_explanation': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> createPaypalPayment(
    Map<String, dynamic> transactions,
    String accessToken,
  ) async {
    try {
      final response = await Dio().post(
        '$_baseUrl/v1/payments/payment',
        data: jsonEncode(transactions),
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      final body = response.data;
      if (body["links"] == null || (body["links"] as List).isEmpty) {
        return {'error': true, 'message': 'No payment links found'};
      }

      final links = body["links"] as List;
      String? executeUrl;
      String? approvalUrl;

      approvalUrl =
          links.firstWhere(
            (o) => o["rel"] == "approval_url",
            orElse: () => {},
          )["href"];

      executeUrl =
          links.firstWhere(
            (o) => o["rel"] == "execute",
            orElse: () => {},
          )["href"];
      if (approvalUrl == null) {
        return {'error': true, 'message': 'Approval URL not found'};
      }

      return {
        'error': false,
        'executeUrl': executeUrl,
        'approvalUrl': approvalUrl,
      };
    } on DioException catch (e) {
      return {
        'error': true,
        'message': "Payment creation failed",
        'data': e.response?.data,
      };
    } catch (e) {
      return {
        'error': true,
        'message': "Unexpected error occurred",
        'exception': e.toString(),
      };
    }
  }

  Future<Map<String, dynamic>> executePayment(
    String url,
    String payerId,
    String accessToken,
  ) async {
    try {
      final response = await Dio().post(
        url,
        data: jsonEncode({"payer_id": payerId}),
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          },
        ),
      );

      return {
        'error': false,
        'message': "Payment executed successfully",
        'data': response.data,
      };
    } on DioException catch (e) {
      return {
        'error': true,
        'message': "Payment execution failed",
        'data': e.response?.data,
      };
    } catch (e) {
      return {
        'error': true,
        'message': "Unexpected error occurred",
        'exception': e.toString(),
      };
    }
  }
}
