import 'package:flutter/material.dart';
import 'package:prototyp/widgets/profile/previous_purchases.dart';
import 'package:prototyp/widgets/profile/shopping_lists.dart';
import 'package:prototyp/widgets/profile/store_item.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      crossAxisAlignment: .start,
      children: [
        Flexible(
          child: PreviousPurchases(
            purchases: [
              PreviousPurchase(
                date: DateTime.now(),
                items: [StoreItem(name: "Kokande vatten 150ml", amount: 16)],
              ),
              PreviousPurchase(
                date: DateTime.now().subtract(const Duration(days: 4)),
                items: [
                  StoreItem(name: "Isbit", amount: 67),
                  StoreItem(name: "Vatten 150ml", amount: 1),
                ],
              ),
              PreviousPurchase(
                date: DateTime.now().subtract(const Duration(days: 10)),
                items: [
                  StoreItem(name: "Sockerkaka", amount: 1, shoppingList: true),
                  StoreItem(name: "Vattenmelon", amount: 2),
                  StoreItem(name: "Gul lök", amount: 1),
                ],
              ),
            ],
          ),
        ),
        Flexible(
          child: ShoppingLists(
            shoppingLists: [
              ShoppingList(
                name: "Sockerkaka",
                items: [
                  StoreItem(name: "Strösocker", amount: 1),
                  StoreItem(name: "Vaniljsocker", amount: 1),
                  StoreItem(name: "Bakpulver", amount: 1),
                  StoreItem(name: "Smör", amount: 1),
                  StoreItem(name: "Vetemjöl", amount: 2),
                  StoreItem(name: "Mjölk", amount: 1),
                  StoreItem(name: "Ägg", amount: 3),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
