import 'package:flutter/material.dart';
import 'package:prototyp/model/browsecategory_model.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:prototyp/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductGrid extends StatelessWidget {
  final bool filterProducts;

  const ProductGrid({super.key, this.filterProducts = false});

  @override
  Widget build(BuildContext context) {
    var browsecategoryModel = Provider.of<BrowsecategoryModel>(context);
    var imatDataHandler = Provider.of<ImatDataHandler>(context);

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: [
        if (browsecategoryModel.currentSearch.isEmpty || !filterProducts) ...[
          for (final product in imatDataHandler.findProductsByCategory(
            browsecategoryModel.currentCategory,
          ))
            SizedBox(
              width: 200,
              height: 300,
              child: ProductCard(product, imatDataHandler),
            ),
        ] else ...[
          for (final product in imatDataHandler.findProducts(
            browsecategoryModel.currentSearch,
          ))
            SizedBox(
              width: 200,
              height: 300,
              child: ProductCard(product, imatDataHandler),
            ),
        ],
      ],
    );
  }
}
