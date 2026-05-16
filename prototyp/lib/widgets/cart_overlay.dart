import 'package:flutter/material.dart';
import 'package:prototyp/app_theme.dart';
import 'package:prototyp/widgets/checkout/purchase_list.dart';

class CartOverlay extends StatelessWidget {
  const CartOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        Flexible(
          flex: 2,
          fit: .tight,
          child: IgnorePointer(
            ignoring: true,
            child: Container(
              decoration: BoxDecoration(color: AppTheme.colorOverlay),
            ),
          ),
        ),
        Flexible(
          flex: 1,
          fit: .tight,
          child: Container(
            decoration: BoxDecoration(color: AppTheme.colorScheme.onPrimary),
            padding: .all(AppTheme.paddingMedium),
            child: PurchaseList(),
          ),
        ),
      ],
    );
  }
}
