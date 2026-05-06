import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.label,
    required this.currentSearch,
  });
  final String label;
  final String currentSearch;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 200,
      child: Placeholder(
        child: Column(
          children: [
            Text(label, textAlign: TextAlign.center),
            Text(currentSearch, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
