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

class PreviousPurchase extends StatelessWidget {
  final DateTime date;
  final List<StoreItem> items;

  const PreviousPurchase({super.key, required this.date, required this.items});

  @override
  Widget build(BuildContext context) {
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
          columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
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
  final List<Widget> children;

  const PreviousPurchases({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return TitledBox(
      title: "Dina tidigare köp",
      child: Column(children: children),
    );
  }
}
