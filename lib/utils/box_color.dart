import 'package:flutter/material.dart';

class BoxColor extends StatelessWidget {
  const BoxColor(this.icon, this.color);

  final IconData icon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: color,
      ),
      child: Icon(
        icon,
        size: 16.0,
        color: Colors.white,
      ),
    );
  }
}
