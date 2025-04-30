import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final int numberOfRatings;

  const RatingWidget({
    super.key,
    required this.rating,
    required this.numberOfRatings,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ...List.generate(
          5,
          (index) {
            if (index < rating.floor()) {
              return const Icon(Icons.star, color: Colors.amber, size: 16);
            } else if (index < rating && rating - index >= 0.5) {
              return const Icon(Icons.star_half, color: Colors.amber, size: 16);
            } else {
              return const Icon(Icons.star_border,
                  color: Colors.amber, size: 16);
            }
          },
        ),
        const SizedBox(width: 4),
        Text(
          "${rating.toStringAsFixed(1)}/5",
          style: const TextStyle(fontSize: 14),
        ),
        const SizedBox(width: 4),
        // Text("$rating/5 ", style: const TextStyle(fontSize: 14)),
        Text(
          "($numberOfRatings ratings)",
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
