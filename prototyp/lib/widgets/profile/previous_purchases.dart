import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prototyp/widgets/titled_box.dart';

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
      child: Table(
        columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
        border: TableBorder(
          horizontalInside: BorderSide(color: Colors.grey),
          verticalInside: BorderSide(color: Colors.grey),
        ),
        children: items.map((e) => e.asTableRow()).toList(),
      ),
    );
  }

  Widget header(BuildContext context) {
    return Padding(
      padding: .only(left: 10),
      child: Text(
        DateFormat(DateFormat.MONTH_DAY).format(date),
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}

class PreviousPurchases extends StatefulWidget {
  final List<PreviousPurchase> children;

  const PreviousPurchases({super.key, required this.children});

  @override
  State<PreviousPurchases> createState() => _PreviousPurchasesState();
}

class _PreviousPurchasesState extends State<PreviousPurchases> {
  List<bool> _isOpen = [];

  @override
  void initState() {
    super.initState();
    _isOpen = List.filled(widget.children.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return TitledBox(
      title: "Dina tidigare köp",
      child: ExpansionPanelList(
        expandedHeaderPadding: .zero,
        materialGapSize: 16,
        children: widget.children.asMap().entries.map((entry) {
          var i = entry.key;
          var child = entry.value;
          return ExpansionPanel(
            headerBuilder: (context, isOpen) => child.header(context),
            body: child,
            isExpanded: _isOpen[i],
            canTapOnHeader: true,
          );
        }).toList(),
        expansionCallback: (i, isOpen) => setState(() => _isOpen[i] = isOpen),
      ),
    );
  }
}

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
