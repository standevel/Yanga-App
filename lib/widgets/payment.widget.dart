import 'package:flutter/material.dart';
import 'package:flutterwave_web_client/flutterwave_web_client.dart';

class PaymentWidget extends StatefulWidget {
  final String accessCode;
  final double amount; // Amount in kobo (e.g., 1000 = ₦10.00)
  final String email;

  const PaymentWidget({
    super.key,
    required this.accessCode,
    required this.amount,
    required this.email,
  });

  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  @override
  void initState() {
    super.initState();
    // _makePayment();
  }

  void _makePayment() async {
    final customer =
        FlutterwaveCustomer(widget.email, '08102894804', 'Lazarus');
    final charge = Charge()
      ..amount = 100
      ..reference = 'test'
      ..currency = 'NGN'
      ..country = 'NG'
      ..customer = customer;

    final response = await FlutterwaveWebClient.checkout(charge: charge);
    if (response.status) {
      print('Successful, Transaction ref ${response.tx_ref}');
    } else {
      print('Transaction failed');
    }
  }

  String _getReference() {
    return "ChargedFromFlutter_${DateTime.now().millisecondsSinceEpoch}";
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _makePayment,
        child: const Text("Pay Now"),
      ),
    );
  }
}
