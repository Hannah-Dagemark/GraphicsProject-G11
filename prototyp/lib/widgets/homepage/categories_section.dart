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
            _card(
              context,
              "Kött och fågel",
              ProductCategory.MEAT,
              iMat,
              "assets/images/meat.webp",
            ),
            _card(
              context,
              "Grönsaker",
              ProductCategory.VEGETABLE_FRUIT,
              iMat,
              "assets/images/grönsaker.webp",
            ),
            _card(
              context,
              "Mejeri",
              ProductCategory.DAIRIES,
              iMat,
              "assets/images/mejeri.webp",
            ),
            _card(
              context,
              "Bröd",
              ProductCategory.BREAD,
              iMat,
              "assets/images/bröd.webp",
            ),
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
    String imagePath,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        var selection = iMat.findProductsByCategory(category);
        onNavigate(selection, title);
      },
      hoverColor: Colors.green.withOpacity(0.25),
      splashColor: Colors.green.withOpacity(0.25),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),

                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
