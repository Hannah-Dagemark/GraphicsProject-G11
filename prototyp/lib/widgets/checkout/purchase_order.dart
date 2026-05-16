import 'package:flutter/material.dart';
import 'package:prototyp/widgets/checkout/purchase_base.dart';

class PurchaseOrder extends StatelessWidget {
  const PurchaseOrder({super.key});

  @override
  Widget build(BuildContext context) {
        return Column(
          children: [
            Text(
              "Ditt Köp",
              style: TextStyle(fontSize: 25),
            ),
              PurchaseBase(child: Card(child: Padding(padding: EdgeInsets.all(20), child: Column(children: [
                Card(child: Row(
                children: [
                  SizedBox(width: 12),
                  Text("1"),
                  SizedBox(width: 16),
                  Text("Sak"),
                  Spacer(),
                  Text("X kr"),
                  SizedBox(width: 12),
                ],
              )),
              Card(child: Row(
                children: [
                  SizedBox(width: 12),
                  Text("1"),
                  SizedBox(width: 16),
                  Text("Sak"),
                  Spacer(),
                  Text("X kr"),
                  SizedBox(width: 12),
                ],
              )),
              Card(child: Row(
                children: [
                  SizedBox(width: 12),
                  Text("1"),
                  SizedBox(width: 16),
                  Text("Sak"),
                  Spacer(),
                  Text("X kr"),
                  SizedBox(width: 12),
                ],
              ))
        ],)))),
        Row(children: [
          TextButton(onPressed:() {print("lägg till i lista");}, child: Text("Spara som inköpslista", style: TextStyle(fontSize: 15)))
        ],)
      ],
    );
  }
}
