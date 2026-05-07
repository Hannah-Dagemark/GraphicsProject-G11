import 'package:flutter/material.dart';
import 'package:prototyp/model/imat/product.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 250,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey, width: 3),
        ),
        child: Column(
          children: [
            Text(product.name, textAlign: TextAlign.center),
            Text(product.price.toString(), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
