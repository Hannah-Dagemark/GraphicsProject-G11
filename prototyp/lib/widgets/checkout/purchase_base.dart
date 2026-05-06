import 'package:flutter/material.dart';

class PurchaseBase extends StatelessWidget {
  final Widget child;
  
  const PurchaseBase({
    super.key,
    required this.child,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      height: 500,
      child: child
    );
  }
}