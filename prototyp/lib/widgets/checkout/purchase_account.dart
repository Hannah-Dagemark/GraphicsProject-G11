import 'package:flutter/material.dart';
import 'package:prototyp/widgets/checkout/purchase_base.dart';

class PurchaseAccount extends StatelessWidget {
  const PurchaseAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        "Dina Uppgifter",
        style: TextStyle(fontSize: 25)
      ),
      PurchaseBase(child: Card(child: Padding(padding: EdgeInsets.all(20), child: Column(children: [
        Row(children: [
          Text("Namn:"),
          Spacer(),
          Card(child: Padding(padding: EdgeInsets.all(4), child: Text("...")))
        ],),
        Row(children: [
          Text("Address:"),
          Spacer(),
          Card(child: Padding(padding: EdgeInsets.all(4), child: Text("...")))
        ],),
        Spacer(),
        TextButton(child: Padding(padding: EdgeInsets.all(4), child: Text("Skapa Konto")), onPressed: (){print("you made an account");}),
      ],)))),
      Row(children: [
        TextButton(child: Text("Spara Uppgifter", style: TextStyle(fontSize: 15)), onPressed: (){print("but why?");},)
      ],)
    ],);
  }
}