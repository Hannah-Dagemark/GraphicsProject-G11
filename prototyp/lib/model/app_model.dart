import 'package:flutter/material.dart';
import 'package:prototyp/model/page_index.dart';

class AppModel extends ChangeNotifier {
  static const zoomLevelDefault = 1.0;
  static const zoomLevelMin = 0.5;
  static const zoomLevelMax = 2.5;

  static const _zoomFactor = 2.0;
  static const _zoomLevelDelta = 0.25;

  PageIndex _currentPage = PageIndex.home;
  double _zoomLevel = zoomLevelDefault;
  final transformationController = TransformationController();

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
    _zoomLevel = zoomLevel.clamp(zoomLevelMin, zoomLevelMax);
    notifyListeners();
  }

  void zoomIn() {
    setZoom(_zoomLevel + _zoomLevelDelta);
    notifyListeners();
  }

  void zoomOut() {
    setZoom(_zoomLevel - _zoomLevelDelta);
    notifyListeners();
  }

  void resetZoom() {
    _zoomLevel = zoomLevelDefault;
    transformationController.value = Matrix4.identity();
    notifyListeners();
  }

  MediaQuery zoomWrapper(BuildContext context, Widget child) {
    return MediaQuery(
      data: MediaQuery.of(
        context,
      ).copyWith(textScaler: TextScaler.linear(_zoomLevel * _zoomFactor)),
      child: child,
    );
  }

  MediaQuery zoomCancelWrapper(BuildContext context, Widget child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
      child: child,
    );
  }
}
