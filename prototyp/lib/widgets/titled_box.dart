import 'package:flutter/material.dart';

class TitledBox extends StatelessWidget {
  final String title;
  final Widget child;

  const TitledBox({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(title, style: Theme.of(context).textTheme.displaySmall),
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Colors.grey, width: 2),
          ),
          clipBehavior: .antiAlias,
          child: Container(padding: .all(5), child: child),
        ),
      ],
    );
  }
}
