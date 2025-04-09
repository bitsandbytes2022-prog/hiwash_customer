import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final int rating;
  final int starCount;

  StarRating({required this.rating, this.starCount = 5});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(starCount, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? Colors.amber : Colors.grey,
        );
      }),
    );
  }
}