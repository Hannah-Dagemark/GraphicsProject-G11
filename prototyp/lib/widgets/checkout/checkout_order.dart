import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:prototyp/model/imat/order.dart';

class CheckoutOrder extends StatelessWidget {
  const CheckoutOrder({super.key});

  @override
  Widget build(BuildContext context) {
    var dataHandler = context.watch<ImatDataHandler>();
    var orders = dataHandler.orders;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Dina Tidigare Köp",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(width: 1600, height: 780, child: ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              Order order = orders[index];

              double total = 0;
              for (var item in order.items) {
                total += item.product.price * item.amount;
              }

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                child: ListTile(
                  title: Text("Order #${order.orderNumber}"),
                  subtitle: Text("Date: ${order.date}"),
                  trailing: Text("Total: ${total.toStringAsFixed(2)} kr",
                  )
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}