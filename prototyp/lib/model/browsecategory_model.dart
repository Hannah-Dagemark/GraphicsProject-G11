import 'package:flutter/material.dart';
import 'package:prototyp/model/imat/product.dart';

class BrowsecategoryModel extends ChangeNotifier {
  ProductCategory _currentCategory = ProductCategory.BREAD;
  String _subcategorySearch = '';

  void setSearch(String search) {
    _subcategorySearch = search;
    notifyListeners();
  }

  void setCurrentCategory(ProductCategory category) {
    _currentCategory = category;
    notifyListeners();
  }

  String get currentSearch => _subcategorySearch;

  ProductCategory get currentCategory => _currentCategory;

  List<ProductCategory> get categories => ProductCategory.values;
}
