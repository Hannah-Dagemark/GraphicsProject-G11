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
    var controller = Provider.of<CheckoutController>(context, listen: true);
    Widget content1; 
    Widget content2; 

    if (controller.hasCheckedOut == false) {
      content1 = PurchaseList();
      content2 = PurchaseAccount();
    }
    else {
      content1 = PurchaseOrder();
      content2 = PurchaseDetail();
    }

    return Scaffold(
    backgroundColor: Colors.white,
    body: Row(children: [content1, content2]),
    );
  }
}
