import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototyp/app_theme.dart';
import 'package:prototyp/main_view.dart';
import 'package:prototyp/model/app_model.dart';
import 'package:prototyp/widgets/zoomable_frame.dart';
import 'package:prototyp/model/browsecategory_model.dart';
import 'package:prototyp/model/imat/imat_data_handler.dart';
import 'package:provider/provider.dart';
import 'package:prototyp/model/checkout_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppModel()),
        ChangeNotifierProvider(create: (context) => CheckoutController()),
        ChangeNotifierProvider(create: (context) => ImatDataHandler()),
        ChangeNotifierProvider(create: (context) => BrowsecategoryModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, appModel, child) {
        return MaterialApp(
          title: 'iMat',
          theme: ThemeData(
            colorScheme: AppTheme.colorScheme,
            textTheme: TextTheme.of(
              context,
            ).apply(bodyColor: Colors.black, displayColor: Colors.black),
          ),
          builder: (context, child) {
            return appModel.zoomWrapper(context, child!);
          },
          home: CallbackShortcuts(
            bindings: {
              const SingleActivator(LogicalKeyboardKey.add, control: true): () {
                appModel.zoomIn();
              },
              const SingleActivator(
                LogicalKeyboardKey.minus,
                control: true,
              ): () {
                appModel.zoomOut();
              },
            },
            child: Focus(
              autofocus: true,
              child: ZoomableFrame(child: const MainView()),
            ),
          ),
        );
      },
    );
  }
}
