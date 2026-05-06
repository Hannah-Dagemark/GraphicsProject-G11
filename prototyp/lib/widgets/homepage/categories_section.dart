import 'package:flutter/material.dart';
import 'package:prototyp/model/imat/product.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:provider/provider.dart';

class CategoriesSection extends StatelessWidget {
  final Function(List<Product>, String) onNavigate;

  const CategoriesSection({super.key, required this.onNavigate});

  @override
  Widget build(BuildContext context) {
    var iMat = Provider.of<ImatDataHandler>(context, listen: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Vanliga kategorier",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 10),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _card(context, "Kött och fågel", ProductCategory.MEAT, iMat),
            _card(context, "Grönsaker", ProductCategory.VEGETABLE_FRUIT, iMat),
            _card(context, "Mejeri", ProductCategory.DAIRIES, iMat),
            _card(context, "Bröd", ProductCategory.BREAD, iMat),
          ],
        ),
      ],
    );
  }

  Widget _card(
    BuildContext context,
    String title,
    ProductCategory category,
    ImatDataHandler iMat,
  ) {
    return GestureDetector(
      onTap: () {
        var selection = iMat.findProductsByCategory(category);
        onNavigate(selection, title);
      },
      child: Card(child: Center(child: Text(title))),
    );
  }
}
