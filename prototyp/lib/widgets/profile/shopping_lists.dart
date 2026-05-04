import 'package:flutter/material.dart';
import 'package:prototyp/widgets/profile/expandable_table_card.dart';
import 'package:prototyp/widgets/profile/store_item.dart';
import 'package:prototyp/widgets/titled_box.dart';

class ShoppingList extends StatelessWidget {
  final String name;
  final List<StoreItem> items;

  const ShoppingList({super.key, required this.name, required this.items});

  @override
  Widget build(BuildContext context) {
    return ExpandableTableCard(
      title: name,
      rows: items.map((i) => i.asTableRow()).toList(),
    );
  }
}

class ShoppingLists extends StatelessWidget {
  final List<ShoppingList> shoppingLists;

  const ShoppingLists({super.key, required this.shoppingLists});

  @override
  Widget build(BuildContext context) {
    return TitledBox(
      title: "Dina inköpslistor",
      child: Column(children: shoppingLists),
    );
  }
}
