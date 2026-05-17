import 'package:flutter/material.dart';

class CheckoutList extends StatelessWidget {
  const CheckoutList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Din Kundvagn",
          style: TextStyle(fontSize: 25)
        ),
        Card(child: Padding(padding: EdgeInsets.all(20), child: Column(
          children: [
            Card(child: Row(
              children: [
                SizedBox(width: 12),
                TextButton(onPressed: () {}, child: Text('-')),
                Text("1"),
                TextButton(onPressed: () {}, child: Text('+')),
                SizedBox(width: 12),
                Spacer(),
                Text("Sak"),
                SizedBox(width: 12)
              ],
            )),
            Card(child: Row(
              children: [
                SizedBox(width: 12),
                TextButton(onPressed: () {}, child: Text('-')),
                Text("1"),
                TextButton(onPressed: () {}, child: Text('+')),
                SizedBox(width: 12),
                Spacer(),
                Text("Sak"),
                SizedBox(width: 12)
              ],
            )),
            Card(child: Row(
              children: [
                SizedBox(width: 12),
                TextButton(onPressed: () {}, child: Text('-')),
                Text("1"),
                TextButton(onPressed: () {}, child: Text('+')),
                SizedBox(width: 16),
                Spacer(),
                Text("Sak"),
                SizedBox(width: 12),
              ],
            ))
          ],)
        )),
        Row(children: [
          Text("Totalt: X kr", style: TextStyle(fontSize: 15))
        ],)
      ]
    );
  }
}
