import 'package:flutter/material.dart';

class CheckoutController extends ChangeNotifier {
  bool hasCheckedOut = false;

  void checkout() {
    hasCheckedOut = true;
  }

  void returnPage() {
    hasCheckedOut = false;
  }
}