import 'package:flutter/material.dart';

class CheckoutOrder extends StatelessWidget {
  const CheckoutOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Ditt Köp",
          style: TextStyle(fontSize: 25),
        ),
      Row(children: [
        TextButton(onPressed:() {}, child: Text("Spara som inköpslista", style: TextStyle(fontSize: 15)))
      ],)
      ],
    );
  }
}