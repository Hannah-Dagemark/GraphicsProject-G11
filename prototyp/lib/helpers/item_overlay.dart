import 'package:flutter/material.dart';

class ItemOverlay {
  static OverlayEntry? _entry;

  static void show({
    required BuildContext context,
    required Widget overlayWidget,
  }) {
    _entry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          const ModalBarrier(dismissible: false, color: Colors.transparent),
          Center(child: overlayWidget),
        ],
      ),
    );
    Overlay.of(context).insert(_entry!);
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
  }
}
