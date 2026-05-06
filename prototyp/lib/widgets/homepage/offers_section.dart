import 'package:flutter/material.dart';
import 'package:prototyp/model/imat/product.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:prototyp/widgets/homepage/product_card.dart';

class OffersSection extends StatelessWidget {
  final List<Product> offers;
  final ImatDataHandler iMat;
  final VoidCallback onTap;

  const OffersSection({
    super.key,
    required this.offers,
    required this.iMat,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: const Text(
            "Veckans erbjudanden",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: offers.map((product) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: SizedBox(height: 120, child: ProductCard(product, iMat)),
            );
          }).toList(),
        ),
      ],
    );
  }
}
