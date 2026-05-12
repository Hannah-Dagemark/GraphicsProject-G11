import 'package:flutter/material.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:prototyp/widgets/product_widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatelessWidget {
  final String title;

  const ProductListPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var iMat = context.watch<ImatDataHandler>();
    var products = iMat.selectProducts;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 4 / 3,
        ),
        itemBuilder: (context, index) {
          return ProductCard(products[index], iMat);
        },
      ),
    );
  }
}
