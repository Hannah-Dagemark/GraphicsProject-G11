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

class _PageScrollWrapper extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  final Widget child;

  _PageScrollWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ScrollbarTheme(
        data: ScrollbarThemeData(
          // Makes the scrollbar thicker
          thickness: WidgetStateProperty.all(12.0),
          // Controls the opacity via the color (0xFF is full opacity)
          thumbColor: WidgetStateProperty.all(Colors.grey.shade700),
          // Makes the corners rounded
          radius: const Radius.circular(10),
          // Ensures the track remains invisible but the thumb is prominent
          trackVisibility: WidgetStateProperty.all(false),
        ),
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(padding: EdgeInsets.only(top: 20), child: child),
          ),
        ),
      ),
    );
  }
}

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
            _PageScrollWrapper(child: _getPageWidget(currentPage)),
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
