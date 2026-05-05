import 'package:flutter/material.dart';
import 'package:prototyp/widgets/browse/category_bar.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(child: ListBody(children: [CategoryBar()]));
  }
}
