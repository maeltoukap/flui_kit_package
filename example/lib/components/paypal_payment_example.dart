/// Entry point of the application.
import 'dart:developer';
import 'package:flui_kit/flui_kit.dart';
import 'package:flutter/material.dart';


class PaypalPaymentExample extends StatelessWidget {
  const PaypalPaymentExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PaypalPaymentDemo',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: TextButton(
            child: const Text('Pay with PayPal'),

            /// When pressed, navigates to the [PaypalCheckoutView] screen to initiate a PayPal payment.
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => PaypalCheckoutView(
                    /// Indicates whether the PayPal sandbox (test) environment should be used.
                    sandboxMode: true,

                    /// Your PayPal REST API Client ID.
                    clientId: "YOUR_CLIENT_ID",

                    /// Your PayPal REST API Secret Key.
                    secretKey: "YOUR_SECRET_KEY",

                    /// The URL to redirect to upon successful payment completion.
                    returnURL: "YOUR_RETURN_URL",

                    /// The URL to redirect to if the user cancels the payment.
                    cancelURL: "YOUR_CANCEL_URL",

                    /// Transaction details including the list of items and total payment amount.
                    transactions: const TransactionOption(
                      payPalAmount: PayPalAmount(
                        total: "100",
                        currency: "USD",
                        details: PaymentDetails(
                          subtotal: '100',
                          shipping: "0",
                          shippingDiscount: 0,
                        ),
                      ),
                      description: "The payment transaction description.",
                      itemList: ItemList(
                        items: [
                          Item(
                            name: "Apple",
                            quantity: 1,
                            price: "50",
                            currency: "USD",
                          ),
                          Item(
                            name: "Pineapple",
                            quantity: 5,
                            price: "10",
                            currency: "USD",
                          ),
                        ],
                      ),
                    ),

                    /// Optional note or message shown to the user about the payment.
                    note: "Contact us for any questions on your order.",

                    /// Callback triggered when the payment completes successfully.
                    /// Logs the result and navigates back to the previous screen.
                    onSuccess: (PaymentSuccessModel model) async {
                      log("onSuccess: ${model.toJson()}");
                      Navigator.pop(context);
                    },

                    /// Callback triggered when an error occurs during the payment process.
                    /// Logs the error and navigates back to the previous screen.
                    onError: (error) {
                      log("onError: $error");
                      Navigator.pop(context);
                    },

                    /// Callback triggered when the user cancels the PayPal payment.
                    /// Prints a log and returns to the previous screen.
                    onCancel: () {
                      print('Cancelled');
                      Navigator.pop(context);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
