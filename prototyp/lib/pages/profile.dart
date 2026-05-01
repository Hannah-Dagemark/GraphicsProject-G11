import 'package:flutter/material.dart';
import 'package:prototyp/widgets/profile/previous_purchases.dart';
import 'package:prototyp/widgets/profile/shopping_lists.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      crossAxisAlignment: .start,
      children: [
        PreviousPurchases(
          purchases: [
            PreviousPurchase(
              date: DateTime.now(),
              items: [StoreItem(name: "Kokande vatten 150ml", amount: 16)],
            ),
            PreviousPurchase(
              date: DateTime.now(),
              items: [
                StoreItem(name: "Isbit", amount: 67),
                StoreItem(name: "Vatten 150ml", amount: 1),
              ],
            ),
            PreviousPurchase(
              date: DateTime.now(),
              items: [
                StoreItem(name: "Sockerkaka", amount: 1, shoppingList: true),
                StoreItem(name: "Vattenmelon", amount: 2),
                StoreItem(name: "Gul lök", amount: 1),
              ],
            ),
          ],
        ),
        ShoppingLists(),
      ],
    );
  }
}
