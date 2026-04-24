import 'package:flutter/material.dart';
import 'package:prototyp/model/app_model.dart';
import 'package:prototyp/model/page_index.dart';
import 'package:provider/provider.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(width: 0.5, color: Colors.black)),
      ),
      child: Row(
        spacing: 10,
        children: [
          _NavbarButton(title: "Din profil", page: PageIndex.profile),
          _NavbarButton(title: "Handla", page: PageIndex.browse),
          _NavbarButton(title: "Kassa", page: PageIndex.checkout),
        ],
      ),
    );
  }
}

class _NavbarButton extends StatelessWidget {
  final String title;

  final PageIndex page;
  const _NavbarButton({super.key, required this.title, required this.page});

  @override
  Widget build(BuildContext context) {
    var appModel = Provider.of<AppModel>(context);
    return Expanded(
      child: TextButton(
        onPressed: () => {appModel.setCurrentPage(page)},
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            (appModel.currentPage == page) ? Colors.grey : Colors.white,
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 1, color: Colors.black),
            ),
          ),
        ),
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
