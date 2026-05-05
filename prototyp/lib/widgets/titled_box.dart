import 'package:flutter/material.dart';
import 'package:prototyp/app_theme.dart';

class TitledBox extends StatelessWidget {
  final String title;
  final Widget child;

  const TitledBox({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(title, style: TextTheme.of(context).displaySmall),
        Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: .circular(AppTheme.radiusLarge),
            side: const BorderSide(color: Colors.grey, width: 2),
          ),
          clipBehavior: .antiAlias,
          child: Container(padding: .all(AppTheme.paddingTiny), child: child),
        ),
      ],
    );
  }
}
