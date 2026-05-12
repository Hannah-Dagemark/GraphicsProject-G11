import 'package:flutter/material.dart';

class AppTheme {
  static const double radiusSmall = 6.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;

  static const double paddingTiny = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMediumSmall = 12.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingHuge = 32.0;

  static ColorScheme colorScheme = .fromSeed(seedColor: Colors.deepPurple);

  static Color colorOverlay = Colors.black.withAlpha(50);

  static BoxDecoration appBarButtonBoxDecoration = BoxDecoration(
    color: Colors.black.withAlpha(20),
    borderRadius: .circular(AppTheme.radiusSmall),
  );

  static final _scrollbarThemeData = ScrollbarThemeData(
    thickness: .all(12.0),
    thumbColor: .all(Colors.grey.shade700),
    radius: .circular(radiusSmall),
    trackVisibility: .all(false),
  );

  static ScrollbarTheme scrollbarTheme(
    ScrollController scrollController,
    Widget child,
  ) {
    return ScrollbarTheme(
      data: _scrollbarThemeData,
      child: Scrollbar(
        controller: scrollController,
        thumbVisibility: true,
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: .only(top: AppTheme.paddingLarge),
            child: child,
          ),
        ),
      ),
    );
  }
}
