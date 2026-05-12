import 'package:flutter/material.dart';
import 'package:prototyp/app_theme.dart';
import 'package:prototyp/model/browsecategory_model.dart';
import 'package:prototyp/widgets/new_navbar.dart';
import 'package:prototyp/widgets/product_widgets/product_grid.dart';
import 'package:prototyp/widgets/product_widgets/product_search_bar.dart';
import 'package:provider/provider.dart';

class BrowsePage extends StatelessWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context) {
    var browsecategoryModel = Provider.of<BrowsecategoryModel>(context);

    return Card(
      child: Column(
        spacing: AppTheme.paddingMedium,
        crossAxisAlignment: .stretch,
        children: [
          NewNavbar(
            buttons: [
              for (final category in browsecategoryModel.categories)
                TextButton(
                  onPressed: () => {
                    browsecategoryModel.setCurrentCategory(category),
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      (browsecategoryModel.currentCategory == category)
                          ? Colors.grey
                          : Colors.white,
                    ),
                  ),
                  child: Text(
                    category.name,
                    style: TextTheme.of(context).titleSmall,
                  ),
                ),
            ],
          ),
          ProductSearchBar(
            hintText: 'Sök efter produkt...',
            onChanged: (value) {
              browsecategoryModel.setSearch(value);
            },
            onSearch: (value) {
              browsecategoryModel.setSearch(value);
            },
          ),
          ProductGrid(filterProducts: true),
        ],
      ),
    );
  }
}
