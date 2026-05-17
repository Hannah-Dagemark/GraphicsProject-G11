import 'package:flutter/material.dart';
import 'package:prototyp/model/page_index.dart';
import 'package:provider/provider.dart';
import 'package:prototyp/widgets/checkout/checkout_controller.dart';
import 'package:prototyp/widgets/checkout/checkout_account.dart';
import 'package:prototyp/widgets/checkout/checkout_detail.dart';
import 'package:prototyp/widgets/checkout/checkout_list.dart';
import 'package:prototyp/widgets/checkout/checkout_order.dart';
import 'package:prototyp/model/app_model.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<CheckoutController>();
    var appModel = Provider.of<AppModel>(context, listen: false);

    if (controller.stage == 1) {
      return Column(children: [
        CheckoutList(),
        Row(
          children: [
            Spacer(), 
            Padding(padding: EdgeInsets.only(right: 20), child:TextButton(
              onPressed: controller.nextPage,
              child: Text("Nästa", style: TextStyle(fontSize: 20))
            )),
          ],
        )
      ]);
    }
    else if (controller.stage == 2) {
      return Column(children: [
      CheckoutAccount(),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20), child: TextButton(
              onPressed: controller.returnPage,
              child: Text("Tillbaka", style: TextStyle(fontSize: 20))
            )),
            Spacer(), 
            Padding(padding: EdgeInsets.only(right: 20), child:TextButton(
              onPressed: controller.nextPage,
              child: Text("Nästa", style: TextStyle(fontSize: 20))
            )),
          ],
        )
      ]);
    }
    else {
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CheckoutOrder(), SizedBox(width: 120), CheckoutDetail()]
        ),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20), child:TextButton(
              onPressed: controller.returnPage,
              child: Text("Tillbaka", style: TextStyle(fontSize: 20))
            )),
            Spacer(), 
            Padding(padding: EdgeInsets.only(right: 20), child:TextButton(
              onPressed: () => appModel.setCurrentPage(PageIndex.home),
              child: Text("Tillbaka till Hem", style: TextStyle(fontSize: 20))
            )),
          ],
        )
      ]);
    }
  }
}
