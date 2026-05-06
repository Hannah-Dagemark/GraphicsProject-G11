import 'package:flutter/material.dart';
import 'package:prototyp/widgets/checkout/purchase_base.dart';

class PurchaseDetail extends StatelessWidget {
  const PurchaseDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Din Leverans",
          style: TextStyle(fontSize: 25),
        ),
        PurchaseBase(child: Card(child: Padding(padding: EdgeInsets.all(20), child: Column(children: [
          Row(children: [Text("Leveras Imorgon"),]),
          Row(children: [Text("Förväntad ankomst 14:30")]),
          Row(children: [Text("Adress eller nått")],),
          Spacer(),
          Row(children: [
            TextButton(onPressed: () {print("edit");}, child: Text("Redigera Leverans", style: TextStyle(fontSize: 15))),
            TextButton(onPressed:() {print("ta bort");}, child: Text("Avbryt Leverans", style: TextStyle(fontSize: 15)))
          ]),
        ],)))),
        Row(children: [
          TextButton(child: Text("Skicka kvitto till Epost", style: TextStyle(fontSize: 15)), onPressed: (){print("posta mig :3");},)
        ],)
      ],
    );
  }
}