import 'package:flutter/material.dart';

enum ReorderButtonDirection { up, down }

class ReorderButton extends StatelessWidget {
  final ReorderButtonDirection direction;

  const ReorderButton({required this.direction, super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => {},
      icon: Icon(
        direction == ReorderButtonDirection.up
            ? Icons.arrow_upward
            : Icons.arrow_downward,
      ),
    );
  }
}
