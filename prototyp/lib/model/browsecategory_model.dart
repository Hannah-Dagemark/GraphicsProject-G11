import 'package:flutter/material.dart';

class BrowsecategoryModel extends ChangeNotifier {
  BrowseCategory _currentCategory = BrowseCategory.fruit;
  String _subcategorySearch = '';

  void setSearch(String category) {
    _subcategorySearch = category;
    notifyListeners();
  }

  void setCurrentCategory(BrowseCategory category) {
    _currentCategory = category;
    notifyListeners();
  }

  String get currentSearch => _subcategorySearch;

  BrowseCategory get currentCategory => _currentCategory;

  List<BrowseCategory> get categories => BrowseCategory.values;
}

enum BrowseCategory {
  fruit('Frukt'),
  dairy('Mejeri'),
  deli('Chark'),
  vegetables('Grönsaker'),
  bakery('Bageri'),
  snacks('Snacks');

  final String label;
  const BrowseCategory(this.label);
}
