import 'package:flutter/material.dart';
import 'package:prototyp/app_theme.dart';
import 'package:prototyp/helpers/item_overlay.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:prototyp/model/imat/product.dart';
import 'package:prototyp/model/imat/shopping_item.dart';
import 'package:prototyp/widgets/action_button.dart';
import 'package:prototyp/widgets/counter_button.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  /// Hello :3
  ///
  /// This is a widget that aims to display a product's information in a small box, where it can also be purchased.
  /// It also allows for changing the amount of a product currently in the cart, or removing a product from the cart.
  ///
  /// It's meant to be used as an overlay together with the ItemOverlay helper, but it could probably be used on it's own as well
  const ProductDetail({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var imatDataHandler = Provider.of<ImatDataHandler>(context);

    return SizedBox(
      width: size.width * 0.4,
      height: size.height * 0.5,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.paddingSmall),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(child: imatDataHandler.getImage(product)),
              const SizedBox(height: AppTheme.paddingSmall),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppTheme.paddingSmall),
              Text(
                '${product.price.toStringAsFixed(2)} ${product.unit}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: AppTheme.paddingSmall),
              SizedBox(
                height: size.height * 0.075,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (imatDataHandler.getShoppingCart().items.any(
                      (item) => item.product == product,
                    )) ...[
                      CounterButton(
                        amountGetter: () {
                          return imatDataHandler
                              .getShoppingCart()
                              .items
                              .firstWhere((item) => item.product == product)
                              .amount
                              .toString();
                        },
                        incrementer: () {
                          imatDataHandler.shoppingCartUpdate(
                            imatDataHandler.getShoppingCart().items.firstWhere(
                              (item) => item.product == product,
                            ),
                            delta: 1,
                          );
                        },
                        decrementer: () {
                          imatDataHandler.shoppingCartUpdate(
                            imatDataHandler.getShoppingCart().items.firstWhere(
                              (item) => item.product == product,
                            ),
                            delta: -1,
                          );
                        },
                      ),
                    ] else ...[
                      ActionButton(
                        title: "Lägg i kundvagn",
                        onPressed: () {
                          imatDataHandler.shoppingCartAdd(
                            ShoppingItem(product),
                          );
                        },
                      ),
                    ],
                    ActionButton(
                      title:
                          imatDataHandler.getShoppingCart().items.any(
                            (item) => item.product == product,
                          )
                          ? "Spara"
                          : "Stäng",
                      onPressed: () {
                        ItemOverlay.hide();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
