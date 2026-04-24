import 'package:flutter/material.dart';
import 'package:prototyp/model/page_index.dart';

class AppModel extends ChangeNotifier {
  PageIndex _currentPage = PageIndex.home;

  AppModel() {
    setCurrentPage(PageIndex.home);
  }

  PageIndex get currentPage => _currentPage;

  void setCurrentPage(PageIndex page) {
    _currentPage = page;
    notifyListeners();
  }
}
