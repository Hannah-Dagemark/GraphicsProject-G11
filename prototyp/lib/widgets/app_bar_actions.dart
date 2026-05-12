import 'package:flutter/material.dart';
import 'package:prototyp/app_theme.dart';
import 'package:prototyp/model/app_model.dart';
import 'package:prototyp/model/page_index.dart';
import 'package:prototyp/widgets/action_button.dart';
import 'package:prototyp/widgets/zoom_control.dart';
import 'package:provider/provider.dart';

class AppBarActions extends StatelessWidget {
  const AppBarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        _PageButton(title: "Hem", page: PageIndex.home),
        _PageButton(title: "Din profil", page: PageIndex.profile),
        _PageButton(title: "Handla", page: PageIndex.browse),
        _PageButton(title: "Kassa", page: PageIndex.checkout),
        _CartButton(),
        ZoomControl(),
      ],
    );
  }
}

class _PageButton extends StatelessWidget {
  final String title;

  final PageIndex page;
  const _PageButton({required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    var appModel = Provider.of<AppModel>(context);
    return ActionButton(
      title: title,
      selected: appModel.currentPage == page,
      onPressed: () => {appModel.setCurrentPage(page)},
    );
  }
}

class _CartButton extends StatelessWidget {
  const _CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    var appModel = context.watch<AppModel>();
    return ActionButton(
      title: "Din kundvagn",
      icon: Icons.shopping_cart,
      selected: appModel.cartOpen,
      onPressed: appModel.toogleCart,
    );
  }
}
