import 'package:flutter/material.dart';
import 'package:prototyp/model/browsecategory_model.dart';
import 'package:provider/provider.dart';

class CategorySearch extends StatelessWidget {
  const CategorySearch({super.key});

  @override
  Widget build(BuildContext context) {
    var browsecategoryModel = Provider.of<BrowsecategoryModel>(context);

    return SearchBar(
      hintText: 'Sök efter produkt...',
      leading: const Icon(Icons.search),
      onChanged: (value) {
        browsecategoryModel.setSearch(value);
      },
    );
  }
}
