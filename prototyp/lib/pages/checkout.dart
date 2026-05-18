import 'package:flutter/material.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:prototyp/model/page_index.dart';
import 'package:provider/provider.dart';
import 'package:prototyp/widgets/checkout/checkout_controller.dart';
import 'package:prototyp/widgets/checkout/checkout_account.dart';
import 'package:prototyp/widgets/checkout/checkout_list.dart';
import 'package:prototyp/widgets/checkout/checkout_order.dart';
import 'package:prototyp/model/app_model.dart';
import 'package:prototyp/widgets/checkout/navigation_button.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    var controller = context.watch<CheckoutController>();
    var appModel = Provider.of<AppModel>(context, listen: false);
    var dataHandler = context.watch<ImatDataHandler>();
    var cart = dataHandler.getShoppingCart();

    void placeOrder() {
      controller.nextPage();
      if (cart.items.isEmpty){ return; }
      dataHandler.placeOrder();
    }

    if (controller.stage == 1) {
      return Column(children: [
        CheckoutList(),
        Row(
          children: [
            Spacer(), 
            Padding(padding: EdgeInsets.only(right: 20), child:NavigationButton(
              func: controller.nextPage,
              text: "Nästa"
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
            Padding(padding: EdgeInsets.only(left: 20), child:NavigationButton(
              func: controller.returnPage,
              text: "Tillbaka"
            )),
            Spacer(), 
            Padding(padding: EdgeInsets.only(right: 20), child:NavigationButton(
              func: placeOrder,
              text: "Slutför beställning"
            )),
          ],
        )
      ]);
    }
    else {
      return Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CheckoutOrder()]
        ),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 20), child:NavigationButton(
              func: controller.returnPage,
              text: "Tillbaka"
            )),
            Spacer(), 
            Padding(padding: EdgeInsets.only(right: 20), child:NavigationButton(
              func: () => appModel.setCurrentPage(PageIndex.home),
              text: "Tillbaka till Hem"
            )),
          ],
        )
      ]);
    }
  }
}
