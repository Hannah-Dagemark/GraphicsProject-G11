import 'package:flutter/material.dart';
import 'package:prototyp/model/browsecategory_model.dart';
import 'package:provider/provider.dart';

class CategoryItems extends StatelessWidget {
  const CategoryItems({super.key});

  @override
  Widget build(BuildContext context) {
    var browsecategoryModel = Provider.of<BrowsecategoryModel>(context);

    return Wrap(
      spacing: 20,
      runSpacing: 20,
      children: List.generate(
        50,
        (i) => SizedBox(
          width: 100,
          height: 200,
          child: Placeholder(
            child: Text(
              browsecategoryModel.currentCategory.label,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
