import 'package:flutter/material.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:prototyp/pages/browse.dart';
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

    return SingleChildScrollView(
      child: Center(
        child: SizedBox(
          width: 750,
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Text(
                "Färska varor direkt till din dörr. Välkommen till iMAT!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              const Text(
                "Vad vill du handla idag?",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              SearchBarWidget(
                onSearch: (query) {
                  var results = iMat.findProducts(query);

                  iMat.selectSelection(results);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ProductListPage(title: "Sökresultat"),
                    ),
                  );
                },
              ),

              const SizedBox(height: 30),

              Center(
                child: SizedBox(
                  width: 700,
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
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  iMat.selectSelection(iMat.products);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const ProductListPage(title: "Alla produkter"),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Alla Produkter",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 30),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
