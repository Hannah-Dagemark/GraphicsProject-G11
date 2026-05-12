import 'package:flutter/material.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:prototyp/pages/product_list_page.dart';
import 'package:provider/provider.dart';

import 'package:prototyp/widgets/homepage/search_bar_widget.dart';
import 'package:prototyp/widgets/homepage/offers_section.dart';
import 'package:prototyp/widgets/homepage/categories_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var iMat = context.watch<ImatDataHandler>();
    var offers = iMat.products.take(4).toList();

    return Column(
      children: [
        const Text(
          "Färska varor direkt till din dörr. Välkommen till iMAT!",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 8),
        const Text("Vad vill du handla idag?"),
        const SizedBox(height: 16),

        SearchBarWidget(
          onSearch: (query) {
            var results = iMat.findProducts(query);

            iMat.selectSelection(results);

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ProductListPage(title: "Sökresultat"),
              ),
            );
          },
        ),

        const SizedBox(height: 24),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: OffersSection(
                offers: offers,
                iMat: iMat,
                onTap: () {
                  iMat.selectSelection(offers);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ProductListPage(title: "Veckans erbjudanden"),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: CategoriesSection(
                onNavigate: (selection, title) {
                  iMat.selectSelection(selection);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductListPage(title: title),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
