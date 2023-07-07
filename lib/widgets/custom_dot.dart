import 'package:flutter/material.dart';

class CustomDot extends StatelessWidget {
  const CustomDot({
    super.key,
    required this.color,
    required this.dotHeight,
  });
  final Color color;
  final int dotHeight;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: color),
          margin: const EdgeInsets.only(left: 8),
          height: dotHeight.toDouble(),
          width: 12,
        ),
      ],
    );
  }
}
