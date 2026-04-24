import 'package:flutter/material.dart';
import 'package:prototyp/model/app_model.dart';
import 'package:prototyp/model/page_index.dart';
import 'package:prototyp/pages/browse.dart';
import 'package:prototyp/pages/checkout.dart';
import 'package:prototyp/pages/home.dart';
import 'package:prototyp/pages/profile.dart';
import 'package:prototyp/widgets/logo.dart';
import 'package:prototyp/widgets/navbar.dart';
import 'package:provider/provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = Provider.of<AppModel>(context, listen: true);
    var currentPage = appState.currentPage;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Logo(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .start,
          children: [
            Navbar(),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: _getPageWidget(currentPage),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getPageWidget(PageIndex page) {
    switch (page) {
      case PageIndex.home:
        return HomePage();
      case PageIndex.profile:
        return ProfilePage();
      case PageIndex.browse:
        return BrowsePage();
      case PageIndex.checkout:
        return CheckoutPage();
    }
  }
}
