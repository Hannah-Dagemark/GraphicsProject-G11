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
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          hoverColor: Colors.green.withOpacity(0.25),
          splashColor: Colors.green.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
            child: const Text(
              "Veckans erbjudanden",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        const SizedBox(height: 5),

        SizedBox(
          height: 100,

          child: GridView.builder(
            itemCount: offers.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              childAspectRatio: 1.75,
            ),
            itemBuilder: (context, index) {
              final product = offers[index];
              return ProductCard(product, iMat);
            },
          ),
        ),
      ],
    );
  }
}
