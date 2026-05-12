import 'package:flutter/material.dart';

class CheckoutController extends ChangeNotifier {
  bool hasCheckedOut = false;

  void checkout() {
    hasCheckedOut = true;
    notifyListeners();
  }

  void returnPage() {
    hasCheckedOut = false;
    notifyListeners();
  }
}