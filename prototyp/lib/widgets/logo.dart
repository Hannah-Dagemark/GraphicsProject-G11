import 'package:flutter/material.dart';
import 'package:prototyp/model/app_model.dart';
import 'package:prototyp/model/page_index.dart';
import 'package:provider/provider.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    var appModel = Provider.of<AppModel>(context);
    return TextButton(
      child: Text("iMat", style: Theme.of(context).textTheme.titleLarge),
      onPressed: () => {appModel.setCurrentPage(PageIndex.home)},
    );
  }
}
