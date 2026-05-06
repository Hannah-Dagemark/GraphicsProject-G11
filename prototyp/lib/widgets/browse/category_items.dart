import 'package:flutter/material.dart';
import 'package:prototyp/model/browsecategory_model.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:prototyp/widgets/browse/category_item.dart';
import 'package:provider/provider.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({super.key});

  @override
  Widget build(BuildContext context) {
    var browsecategoryModel = Provider.of<BrowsecategoryModel>(context);
    var imatDataHandler = Provider.of<ImatDataHandler>(context);

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        for (final product in imatDataHandler.findProductsByCategory(
          browsecategoryModel.currentCategory,
        ))
          CategoryItem(product: product),
      ],
    );
  }
}
