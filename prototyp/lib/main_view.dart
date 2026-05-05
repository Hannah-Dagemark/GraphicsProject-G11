import 'package:flutter/material.dart';
import 'package:prototyp/app_theme.dart';
import 'package:prototyp/model/app_model.dart';
import 'package:prototyp/model/page_index.dart';
import 'package:prototyp/pages/browse.dart';
import 'package:prototyp/pages/checkout.dart';
import 'package:prototyp/pages/home.dart';
import 'package:prototyp/pages/profile.dart';
import 'package:prototyp/widgets/logo.dart';
import 'package:prototyp/widgets/navbar.dart';
import 'package:prototyp/widgets/zoom_control.dart';
import 'package:provider/provider.dart';

class _PageScrollWrapper extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  final Widget child;

  _PageScrollWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: AppTheme.scrollbarTheme(_scrollController, child));
  }
}

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    var appModel = Provider.of<AppModel>(context, listen: true);
    var currentPage = appModel.currentPage;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorScheme.of(context).inversePrimary,
        title: Logo(),
        actions: [ZoomControl()],
      ),
      body: SizedBox.expand(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Navbar(),
              _PageScrollWrapper(child: _getPageWidget(currentPage)),
            ],
          ),
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
