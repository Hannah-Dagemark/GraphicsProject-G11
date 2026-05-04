import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ExpandableTableCard extends StatelessWidget {
  final String title;
  final List<TableRow> rows;

  const ExpandableTableCard({
    super.key,
    required this.title,
    required this.rows,
  });

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
          child: Text(title, style: Theme.of(context).textTheme.titleLarge),
        ),
        theme: ExpandableThemeData(headerAlignment: .center),
        collapsed: Table(children: []),
        expanded: Table(
          columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
          border: TableBorder(
            horizontalInside: BorderSide(color: Colors.grey),
            verticalInside: BorderSide(color: Colors.grey),
          ),
          children: rows,
        ),
      ),
    );
  }
}
