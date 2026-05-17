import 'package:flutter/material.dart';
import 'package:prototyp/app_theme.dart';
import 'package:prototyp/model/app_model.dart';
import 'package:prototyp/model/page_index.dart';
import 'package:prototyp/pages/browse.dart';
import 'package:prototyp/pages/checkout.dart';
import 'package:prototyp/pages/home.dart';
import 'package:prototyp/pages/profile.dart';
import 'package:prototyp/widgets/app_bar_actions.dart';
import 'package:prototyp/widgets/cart_overlay.dart';
import 'package:prototyp/widgets/logo.dart';
import 'package:provider/provider.dart';

class _PageScrollWrapper extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();

  final Widget child;

  _PageScrollWrapper({required this.child});

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
    var pageWidget = _PageScrollWrapper(
      child: _getPageWidget(appModel.currentPage),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorScheme.of(context).inversePrimary,
        title: Logo(),
        actions: [AppBarActions()],
        actionsPadding: .all(AppTheme.paddingSmall),
        titleSpacing: AppTheme.paddingSmall,
      ),
      body: SizedBox.expand(
        child: Stack(
          children: appModel.cartOpen
              ? [pageWidget, CartOverlay()]
              : [pageWidget],
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
