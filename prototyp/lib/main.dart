import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototyp/main_view.dart';
import 'package:prototyp/model/app_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<AppModel>(
      builder: (context, appModel, child) {
        final double scale = appModel.zoomLevel;
        return MaterialApp(
          title: 'iMat',
          theme: ThemeData(
            colorScheme: .fromSeed(seedColor: Colors.deepPurple),
            textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.black,
              displayColor: Colors.black,
              fontSizeFactor: appModel.zoomLevel,
            ),
          ),
          builder: (context, child) {
            return MediaQuery(
              // Scale text and layout based on the AppModel
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(scale)),
              child: child!,
            );
          },
          home: CallbackShortcuts(
            bindings: {
              const SingleActivator(LogicalKeyboardKey.add, control: true): () {
                final model = Provider.of<AppModel>(context, listen: false);
                model.setZoom(model.zoomLevel + 0.1);
              },
              const SingleActivator(
                LogicalKeyboardKey.minus,
                control: true,
              ): () {
                final model = Provider.of<AppModel>(context, listen: false);
                model.setZoom(model.zoomLevel - 0.1);
              },
            },
            child: Focus(autofocus: true, child: MainView()),
          ),
        );
      },
    );
  }
}
