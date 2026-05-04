import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototyp/widgets/profile/expandable_table_card.dart';
import 'package:prototyp/widgets/profile/store_item.dart';
import 'package:prototyp/widgets/titled_box.dart';


class PreviousPurchase extends StatelessWidget {
  final DateTime date;
  final List<StoreItem> items;

  const PreviousPurchase({super.key, required this.date, required this.items});

  @override
  Widget build(BuildContext context) {
    return ExpandableTableCard(
      title: DateFormat(DateFormat.MONTH_DAY).format(date),
      rows: items.map((i) => i.asTableRow()).toList(),
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
      child: Column(children: purchases),
    );
  }
}
