import 'package:flutter/material.dart';

class CheckoutDetail extends StatelessWidget {
  const CheckoutDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Din Leverans",
          style: TextStyle(fontSize: 25),
        ),
        Card(child: Padding(padding: EdgeInsets.all(20), child: Column(children: [
          Row(children: [Text("Leveras Imorgon"),]),
          Row(children: [Text("Förväntad ankomst 14:30")]),
          Row(children: [Text("Adress eller nått")],),
          Row(children: [
            TextButton(onPressed: () {}, child: Text("Redigera Leverans", style: TextStyle(fontSize: 15))),
            TextButton(onPressed:() {}, child: Text("Avbryt Leverans", style: TextStyle(fontSize: 15)))
          ]),
        ],))),
        Row(children: [
          TextButton(child: Text("Skicka kvitto till Epost", style: TextStyle(fontSize: 15)), onPressed: (){},)
        ],)
      ],
    );
  }
}