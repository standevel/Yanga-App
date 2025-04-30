import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {super.key, required this.price, this.currencySymbol = 'NGN'});

  final double price;
  final String currencySymbol;

  @override
  Widget build(BuildContext context) {
    return Text(
      "$currencySymbol$price",
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.green,
      ),
    );
  }
}
