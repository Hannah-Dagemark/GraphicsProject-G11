import 'package:flutter/material.dart';

class CheckoutAccount extends StatelessWidget {
  const CheckoutAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Text(
        "Dina Uppgifter",
        style: TextStyle(fontSize: 25)
      ),
      Card(child: Padding(padding: EdgeInsets.all(20), child: Column(children: [
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
        TextButton(child: Padding(padding: EdgeInsets.all(4), child: Text("Skapa Konto")), onPressed: (){}),
      ],))),
      Row(children: [
        TextButton(child: Text("Spara Uppgifter", style: TextStyle(fontSize: 15)), onPressed: (){},)
      ],)
    ],);
  }
}