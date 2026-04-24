import 'package:flutter/material.dart';
import 'package:prototyp/model/app_model.dart';
import 'package:prototyp/model/page_index.dart';
import 'package:provider/provider.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _NavbarButton(title: "Din profil", page: PageIndex.profile),
        _NavbarButton(title: "Handla", page: PageIndex.browse),
        _NavbarButton(title: "Kassa", page: PageIndex.checkout),
      ],
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
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: (appModel.currentPage == page) ? Colors.grey : Colors.white,
        ),
        child: TextButton(
          child: Padding(
            padding: .all(5),
            child: Text(title, style: Theme.of(context).textTheme.titleLarge),
          ),
          onPressed: () => {appModel.setCurrentPage(page)},
        ),
      ),
    );
  }
}
