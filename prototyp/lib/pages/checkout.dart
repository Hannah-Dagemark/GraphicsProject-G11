import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prototyp/widgets/checkout/checkout_controller.dart';
import 'package:prototyp/widgets/checkout/purchase_account.dart';
import 'package:prototyp/widgets/checkout/purchase_detail.dart';
import 'package:prototyp/widgets/checkout/purchase_list.dart';
import 'package:prototyp/widgets/checkout/purchase_order.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<CheckoutController>();
    Widget content1; 
    Widget content2; 
    VoidCallback checkoutFunction;
    String buttonText;

    if (!controller.hasCheckedOut) {
      content1 = const PurchaseList();
      content2 = const PurchaseAccount();
      checkoutFunction = controller.checkout;
      buttonText = "Slutför Betalning";
    }
    else {
      content1 = const PurchaseOrder();
      content2 = const PurchaseDetail();
      checkoutFunction = controller.returnPage;
      buttonText = "Tillbaka";
    }

    return Expanded(
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [content1, SizedBox(width: 120), content2]
        ),
        Row(
          children: [
            Spacer(), 
            TextButton(
              onPressed: checkoutFunction,
              child: Text(buttonText, style: TextStyle(fontSize: 20))
            ),
            SizedBox(width: 30),
          ],
        )
      ])
    );
  }
}
