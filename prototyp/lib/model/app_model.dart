import 'package:flutter/material.dart';
import 'package:prototyp/model/page_index.dart';

class AppModel extends ChangeNotifier {
  PageIndex _currentPage = PageIndex.home;
  double _zoomLevel = 1.5;

  AppModel() {
    setCurrentPage(PageIndex.home);
  }

  PageIndex get currentPage => _currentPage;
  double get zoomLevel => _zoomLevel;

  void setCurrentPage(PageIndex page) {
    _currentPage = page;
    notifyListeners();
  }

  void setZoom(double zoomLevel) {
    _zoomLevel = zoomLevel.clamp(1.0, 3.0);
    notifyListeners();
  }
}
