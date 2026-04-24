import 'package:flutter/material.dart';
import 'package:prototyp/model/page_index.dart';

class AppModel extends ChangeNotifier {
  PageIndex _currentPage = PageIndex.home;
  double _zoomLevel = 1.0;

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
    // Clamp to prevent zoom being too small or too large
    _zoomLevel = zoomLevel.clamp(0.5, 3.0);
    notifyListeners();
  }
}
