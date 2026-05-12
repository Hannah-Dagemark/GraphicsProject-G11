import 'package:flutter/material.dart';
import 'package:prototyp/app_theme.dart';
import 'package:prototyp/model/app_model.dart';
import 'package:provider/provider.dart';

class ActionButton extends StatelessWidget {
  final String title;
  final IconData? icon;
  final bool selected;
  final Function() onPressed;

  const ActionButton({
    this.title = "",
    this.icon,
    this.selected = false,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var appModel = Provider.of<AppModel>(context);
    var backgroundColor = selected
        ? AppTheme.colorScheme.primary
        : AppTheme.colorScheme.onPrimary;
    var foregroundColor = selected
        ? AppTheme.colorScheme.onPrimary
        : AppTheme.colorScheme.onSurface;

    var titleText = appModel.zoomCancelWrapper(
      context,
      Text(
        title,
        style: TextTheme.of(
          context,
        ).displaySmall!.copyWith(color: foregroundColor),
      ),
    );

    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: .circular(AppTheme.radiusSmall),
            side: const BorderSide(width: 1, color: Colors.black),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: .stretch,
        spacing: AppTheme.paddingSmall,
        children: icon == null
            ? [titleText]
            : [Icon(icon, color: foregroundColor), titleText],
      ),
    );
  }
}
