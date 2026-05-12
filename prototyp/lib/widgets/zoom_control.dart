import 'package:flutter/material.dart';
import 'package:prototyp/app_theme.dart';
import 'package:prototyp/model/app_model.dart';
import 'package:provider/provider.dart';

class ZoomControl extends StatelessWidget {
  const ZoomControl({super.key});

  @override
  Widget build(BuildContext context) {
    final appModel = Provider.of<AppModel>(context, listen: true);
    final pct = (appModel.zoomLevel * 100).round();
    final atMin = appModel.zoomLevel <= AppModel.zoomLevelMin;
    final atMax = appModel.zoomLevel >= AppModel.zoomLevelMax;

    return Container(
      decoration: AppTheme.appBarButtonBoxDecoration,
      child: Row(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          Tooltip(
            message: 'Återställ inzooming',
            child: InkWell(
              borderRadius: .horizontal(
                left: .circular(AppTheme.radiusSmall),
              ),
              onTap: () => appModel.setZoom(AppModel.zoomLevelDefault),
              child: Padding(
                padding: .symmetric(horizontal: AppTheme.paddingSmall),
                child: Row(
                  mainAxisSize: .min,
                  spacing: AppTheme.paddingTiny,
                  children: [
                    const Icon(Icons.search),
                    appModel.zoomCancelWrapper(
                      context,
                      Text('$pct%', style: TextTheme.of(context).titleLarge),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _Divider(),
          _ZoomButton(
            icon: Icons.remove,
            tooltip: 'Zooma ut (Ctrl -)',
            enabled: !atMin,
            onTap: () => appModel.zoomOut(),
            isLeft: false,
            isRight: false,
          ),
          _Divider(),
          _ZoomButton(
            icon: Icons.add,
            tooltip: 'Zooma in (Ctrl +)',
            enabled: !atMax,
            onTap: () => appModel.zoomIn(),
            isLeft: false,
            isRight: true,
          ),
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, color: Colors.black.withAlpha(30));
  }
}

class _ZoomButton extends StatelessWidget {
  const _ZoomButton({
    required this.icon,
    required this.tooltip,
    required this.enabled,
    required this.onTap,
    required this.isLeft,
    required this.isRight,
  });

  final IconData icon;
  final String tooltip;
  final bool enabled;
  final VoidCallback onTap;
  final bool isLeft;
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: .horizontal(
          left: isLeft ? .circular(AppTheme.radiusSmall) : .zero,
          right: isRight ? .circular(AppTheme.radiusSmall) : .zero,
        ),
        onTap: enabled ? onTap : null,
        child: Padding(
          padding: .symmetric(
            horizontal: AppTheme.paddingSmall,
          ),
          child: Icon(icon, color: enabled ? null : Colors.black.withAlpha(60)),
        ),
      ),
    );
  }
}
