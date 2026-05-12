import 'package:flutter/material.dart';

class NewNavbar extends StatelessWidget {
  final dynamic buttons;

  const NewNavbar({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(
          horizontal: BorderSide(width: 0.5, color: Colors.black),
        ),
      ),
      child: Wrap(
        spacing: 10,
        children: [for (final button in buttons) button],
      ),
    );
  }
}
