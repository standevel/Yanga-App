import 'package:flutter/material.dart';
import 'package:yanga/widgets/payment.widget.dart';
import 'package:yanga/widgets/price.widget.dart';
import 'package:yanga/widgets/submit_button.widget.dart';

class EnrollCard extends StatelessWidget {
  const EnrollCard({
    super.key,
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          PriceWidget(price: price),
          SubmitButton(
            title: 'Enroll Now',
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: PaymentWidget(
                      accessCode: 'dsdksdkskl',
                      amount: price,
                      email: 'standevcode@gmail.com',
                    ),
                  );
                },
              );
            },
          ),
        ]),
      ),
    );
  }
}
