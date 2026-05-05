import 'package:flutter/material.dart';

class BrowsecategoryModel extends ChangeNotifier {
  BrowseCategory _currentCategory = BrowseCategory.fruit;

  void setCurrentCategory(BrowseCategory category) {
    _currentCategory = category;
    notifyListeners();
  }

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
