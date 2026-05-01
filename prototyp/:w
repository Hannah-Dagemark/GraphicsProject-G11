import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototyp/widgets/titled_box.dart';

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

class PreviousPurchase {
  final DateTime date;
  final List<StoreItem> items;

  const PreviousPurchase({required this.date, required this.items});

  Widget asWidget(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.grey, width: 1),
      ),
      clipBehavior: .antiAlias,
      child: ExpandablePanel(
        header: Padding(
          padding: .only(left: 10),
          child: Text(
            DateFormat(DateFormat.MONTH_DAY).format(date),
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        theme: ExpandableThemeData(headerAlignment: .center),
        collapsed: Table(children: []),
        expanded: Table(
          border: TableBorder(
            horizontalInside: BorderSide(color: Colors.grey),
            verticalInside: BorderSide(color: Colors.grey),
          ),
          children: items.map((e) => e.asTableRow()).toList(),
        ),
      ),
    );
  }
}

class PreviousPurchases extends StatelessWidget {
  final List<PreviousPurchase> purchases;

  const PreviousPurchases({super.key, required this.purchases});

  @override
  Widget build(BuildContext context) {
    return TitledBox(
      title: "Dina tidigare köp",
      child: Column(
        children: purchases.map((p) => p.asWidget(context)).toList(),
      ),
    );
  }
}
