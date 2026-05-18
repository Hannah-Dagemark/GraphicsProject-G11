import 'package:flutter/material.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:provider/provider.dart';
import 'package:prototyp/model/imat/shopping_item.dart';

class CheckoutList extends StatelessWidget {
  const CheckoutList({super.key});

  @override
  Widget build(BuildContext context) {
    var dataHandler = context.watch<ImatDataHandler>();
    var cart = dataHandler.getShoppingCart();
    var items = cart.items;
    
    double total = 0;

    for (var item in items) {
         total += item.product.price * item.amount;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Din Kundvagn",
          style: TextStyle(fontSize: 25)
        ),
        SizedBox(height: 780, child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            ShoppingItem item = items[index];

        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: ListTile(
          title: Text(item.product.name),

          subtitle: Text(
            "${item.product.price} ${item.product.unit} • "
            "${(item.product.price * item.amount).toStringAsFixed(2)} kr",
          ),

          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [

              // MINUS BUTTON
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  dataHandler.shoppingCartUpdate(
                    item,
                    delta: -1,
                  );
                },
              ),

              Text("${item.amount}"),

              // PLUS BUTTON
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  dataHandler.shoppingCartUpdate(
                    item,
                    delta: 1,
                  );
                },
              ),
            ],
          ),
          ));
        },
        ),
        ),
        

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Text(
            "Totalt: ${total.toStringAsFixed(2)} kr",
             style: const TextStyle(fontSize: 15),
          )
        ],)
      ]
    );
  }
}
