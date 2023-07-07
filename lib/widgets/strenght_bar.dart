import 'package:flutter/material.dart';

class StrenghtBar extends StatelessWidget {
  const StrenghtBar({
    super.key,
    this.color = const Color(0xff24232b),
  });
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      height: 16,
      width: 15,
      color: color,
    );
  }
}
