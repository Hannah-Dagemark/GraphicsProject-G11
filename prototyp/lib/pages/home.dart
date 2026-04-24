import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      children: [
        Text(
          'Välkommen tillbaka,\nkära kund!',
          textAlign: .center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ],
    );
  }
}
