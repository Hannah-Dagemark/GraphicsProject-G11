import 'package:flutter/material.dart';
import 'package:prototyp/model/browsecategory_model.dart';
import 'package:provider/provider.dart';

class CategoryBar extends StatelessWidget {
  const CategoryBar({super.key});

  @override
  Widget build(BuildContext context) {
    var browsecategoryModel = Provider.of<BrowsecategoryModel>(context);

    return Wrap(
      spacing: 5,
      runSpacing: 10,
      children: [
        for (final category in browsecategoryModel.categories)
          Expanded(
            child: TextButton(
              onPressed: () => {
                browsecategoryModel.setCurrentCategory(category),
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(
                  (browsecategoryModel.currentCategory == category)
                      ? Colors.grey
                      : Colors.white,
                ),
              ),
              child: Text(category.name, textScaler: TextScaler.linear(0.75)),
            ),
          ),
      ],
    );
  }
}
