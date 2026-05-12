import 'package:flutter/material.dart';
import 'package:prototyp/app_theme.dart';
import 'package:prototyp/widgets/browse/category_bar.dart';
import 'package:prototyp/widgets/browse/category_items.dart';
import 'package:prototyp/widgets/browse/category_search.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        spacing: AppTheme.paddingMedium,
        crossAxisAlignment: .stretch,
        children: [CategoryBar(), CategorySearch(), CategoryItems()],
      ),
    );
  }
}
