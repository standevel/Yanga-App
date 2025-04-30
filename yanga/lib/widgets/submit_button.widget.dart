import 'package:flutter/material.dart';
import 'package:yanga/constants.dart';

class SubmitButton extends StatelessWidget {
  final Color backgroundColor;
  final VoidCallback onTap; // Use VoidCallback instead of VoidCallbackAction
  final Color foregroundColor;

  final String title;

  const SubmitButton({
    this.backgroundColor = Colors.green,
    this.foregroundColor = Colors.white,
    required this.onTap,
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobilePage = isMobile(context);
    return ElevatedButton(
      onPressed: onTap, // Pass the onTap callback here
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(backgroundColor),
        foregroundColor: WidgetStateProperty.all(foregroundColor),
        minimumSize:
            WidgetStateProperty.all(Size(isMobilePage ? 100 : 120, 50)),
      ),
      child: Text(title),
    );
  }
}
