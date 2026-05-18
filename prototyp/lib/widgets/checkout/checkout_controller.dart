import 'package:flutter/material.dart';

class CheckoutController extends ChangeNotifier {
  int stage = 1;

  void nextPage() {
    stage += 1;
    notifyListeners();
  }

  void returnPage() {
    stage -= 1;
    notifyListeners();
  }
}