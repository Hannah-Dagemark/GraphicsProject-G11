import 'package:flutter/material.dart';

class StoreItem {
  final String name;
  final int amount;
  final bool shoppingList;

  const StoreItem({
    required this.name,
    required this.amount,
    this.shoppingList = false,
  });

  TableRow asTableRow() {
    return TableRow(
      decoration: BoxDecoration(border: .all(color: Colors.grey)),
      children: [
        Padding(
          padding: .all(5),
          child: Text(amount.toString(), textAlign: .center),
        ),
        Padding(padding: .all(5), child: Text(name)),
      ],
    );
  }
}
