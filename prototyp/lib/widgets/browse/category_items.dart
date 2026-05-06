import 'package:flutter/material.dart';
import 'package:prototyp/model/browsecategory_model.dart';
import 'package:prototyp/widgets/browse/category_item.dart';
import 'package:provider/provider.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({super.key});

  @override
  Widget build(BuildContext context) {
    var browsecategoryModel = Provider.of<BrowsecategoryModel>(context);

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: List.generate(
        50,
        (i) => CategoryItem(
          label: browsecategoryModel.currentCategory.label,
          currentSearch: browsecategoryModel.currentSearch,
        ),
      ),
    );
  }
}
