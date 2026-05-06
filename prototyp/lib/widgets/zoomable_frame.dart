import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

/// Wraps [child] with browser-like pinch-to-zoom and trackpad pan behaviour:
///
///  • Trackpad two-finger scroll → pan (only consumed when zoomed in)
///  • Pinch gesture              → zoom around focal point
///  • Mouse drag                 → pan when zoomed in
///  • Overlay scrollbars         → appear when zoomed in
///
/// When the content is at minimum scale (fully zoomed out), scroll events are
/// NOT consumed, so they fall through to any scrollable child.
class ZoomableFrame extends StatefulWidget {
  const ZoomableFrame({
    required this.child,
    super.key,
    this.maxScale = 10.0,
    this.backgroundColor = Colors.white,
    this.scrollbarThickness = 8.0,
  });

  final Widget child;
  final double maxScale;
  final Color backgroundColor;

  /// Thickness of the overlay scrollbar thumb in logical pixels.
  final double scrollbarThickness;

  @override
  State<ZoomableFrame> createState() => _ZoomableFrameState();
}

class _ZoomableFrameState extends State<ZoomableFrame>
    with SingleTickerProviderStateMixin {
  final TransformationController _controller = TransformationController();

  Size _viewportSize = .zero;
  bool _updating = false;

  // Scrollbar fade-out animation.
  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  static const double _epsilon = 0.0001;

  // Baseline locked at gesture start to prevent scale compounding and drift.
  double _gestureStartScale = 1.0;
  Offset _gestureStartTranslation = .zero;
  Offset _gestureStartFocal = .zero;

  // Continuously updated from pointer hover/move so we have the true cursor
  // position the moment a pinch begins (InteractiveViewer's localFocalPoint
  // in onInteractionStart can be stale by the time it fires).
  Offset _lastPointerPosition = .zero;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );
    _controller.addListener(_onTransformChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onTransformChanged);
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  double get _minScale => 1.0;
  double get _currentScale => _controller.value.getMaxScaleOnAxis();
  bool get _isZoomedIn => _currentScale > _minScale + _epsilon;

  Offset get _translation {
    final t = _controller.value.getTranslation();
    return Offset(t.x, t.y);
  }

  double get _maxScrollX =>
      math.max(0.0, _viewportSize.width * _currentScale - _viewportSize.width);

  double get _maxScrollY => math.max(
    0.0,
    _viewportSize.height * _currentScale - _viewportSize.height,
  );

  void _applyTransform(double dx, double dy, double scale) {
    if (_viewportSize == Size.zero) return;
    final s = scale.clamp(_minScale, widget.maxScale);
    final scaledW = _viewportSize.width * s;
    final scaledH = _viewportSize.height * s;
    final minX = math.min(0.0, _viewportSize.width - scaledW);
    final minY = math.min(0.0, _viewportSize.height - scaledH);

    _updating = true;
    _controller.value = Matrix4.identity()
      ..translateByVector3(
        .new(dx.clamp(minX, 0.0).toDouble(), dy.clamp(minY, 0.0).toDouble(), 0),
      )
      ..scaleByDouble(s, s, s, 1);
    _updating = false;
  }

  void _clampTransform() {
    if (_updating || _viewportSize == Size.zero) return;
    final t = _translation;
    _applyTransform(t.dx, t.dy, _currentScale);
  }

  void _onTransformChanged() {
    if (_updating) return;
    _clampTransform();
    _showScrollbars();
  }

  void _showScrollbars() {
    if (!_isZoomedIn) {
      _fadeController.reverse();
      return;
    }
    _fadeController.forward();
  }

  void _handlePointerSignal(PointerSignalEvent event) {
    if (event is! PointerScrollEvent) return;
    if (_viewportSize == Size.zero) return;

    // Not zoomed → do NOT consume; let the child's own scroller handle it.
    if (!_isZoomedIn) return;

    // Zoomed → consume and pan.
    final t = _translation;
    _applyTransform(
      t.dx - event.scrollDelta.dx,
      t.dy - event.scrollDelta.dy,
      _currentScale,
    );
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _gestureStartScale = _currentScale;
    _gestureStartTranslation = _translation;
    // Use the continuously-tracked pointer position rather than
    // details.localFocalPoint, which can be stale or incorrectly offset
    // when InteractiveViewer fires this callback.
    _gestureStartFocal = _lastPointerPosition;
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    if (_viewportSize == Size.zero || details.scale == 1.0) return;

    // details.scale is RELATIVE TO GESTURE START (not the previous frame), so
    // multiply against the locked baseline — never against the current scale.
    final targetScale = (_gestureStartScale * details.scale)
        .clamp(_minScale, widget.maxScale)
        .toDouble();

    // Focal point is locked to gesture start so it stays pinned under fingers.
    final focal = _gestureStartFocal;
    final tx = _gestureStartTranslation.dx;
    final ty = _gestureStartTranslation.dy;

    // Convert focal from viewport-space to content-space using the start
    // matrix, then re-project with the new scale.
    final localX = (focal.dx - tx) / _gestureStartScale;
    final localY = (focal.dy - ty) / _gestureStartScale;

    _applyTransform(
      focal.dx - localX * targetScale,
      focal.dy - localY * targetScale,
      targetScale,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _viewportSize = Size(constraints.maxWidth, constraints.maxHeight);
        WidgetsBinding.instance.addPostFrameCallback((_) => _clampTransform());

        return Listener(
          onPointerSignal: _handlePointerSignal,
          onPointerHover: (e) => _lastPointerPosition = e.localPosition,
          onPointerMove: (e) => _lastPointerPosition = e.localPosition,
          child: ClipRect(
            child: ColoredBox(
              color: widget.backgroundColor,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, _) {
                  final zoomed = _isZoomedIn;
                  return Stack(
                    fit: .expand,
                    children: [
                      InteractiveViewer(
                        transformationController: _controller,
                        constrained: true,
                        boundaryMargin: .zero,
                        minScale: _minScale,
                        maxScale: widget.maxScale,
                        // Allow drag-to-pan only when zoomed in so that normal
                        // mouse interaction works when fully zoomed out.
                        panEnabled: zoomed,
                        scaleEnabled: true,
                        // Trackpad two-finger scroll is handled by the Listener
                        // above; we do NOT want InteractiveViewer to also
                        // intercept it as a zoom.
                        trackpadScrollCausesScale: false,
                        onInteractionStart: _handleScaleStart,
                        onInteractionUpdate: _handleScaleUpdate,
                        onInteractionEnd: (_) => _clampTransform(),
                        child: SizedBox(
                          width: _viewportSize.width,
                          height: _viewportSize.height,
                          child: widget.child,
                        ),
                      ),

                      if (zoomed)
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: _ScrollbarOverlay(
                            scrollX: -_translation.dx,
                            scrollY: -_translation.dy,
                            maxScrollX: _maxScrollX,
                            maxScrollY: _maxScrollY,
                            viewportSize: _viewportSize,
                            thickness: widget.scrollbarThickness,
                            onScrollX: (delta) {
                              final t = _translation;
                              _applyTransform(
                                t.dx - delta,
                                t.dy,
                                _currentScale,
                              );
                            },
                            onScrollY: (delta) {
                              final t = _translation;
                              _applyTransform(
                                t.dx,
                                t.dy - delta,
                                _currentScale,
                              );
                            },
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ScrollbarOverlay extends StatelessWidget {
  const _ScrollbarOverlay({
    required this.scrollX,
    required this.scrollY,
    required this.maxScrollX,
    required this.maxScrollY,
    required this.viewportSize,
    required this.thickness,
    required this.onScrollX,
    required this.onScrollY,
  });

  final double scrollX;
  final double scrollY;
  final double maxScrollX;
  final double maxScrollY;
  final Size viewportSize;
  final double thickness;
  final void Function(double delta) onScrollX;
  final void Function(double delta) onScrollY;

  @override
  Widget build(BuildContext context) {
    // Gap so the two bars don't overlap at the corner.
    final cornerGap = maxScrollX > 0 && maxScrollY > 0 ? thickness + 4.0 : 0.0;

    return Stack(
      fit: StackFit.expand,
      children: [
        if (maxScrollY > 0)
          Positioned(
            right: 2,
            top: 2,
            bottom: cornerGap,
            width: thickness,
            child: _ScrollThumb(
              axis: Axis.vertical,
              scrollOffset: scrollY,
              maxScroll: maxScrollY,
              viewportExtent: viewportSize.height,
              thickness: thickness,
              onScroll: onScrollY,
            ),
          ),
        if (maxScrollX > 0)
          Positioned(
            bottom: 2,
            left: 2,
            right: cornerGap,
            height: thickness,
            child: _ScrollThumb(
              axis: Axis.horizontal,
              scrollOffset: scrollX,
              maxScroll: maxScrollX,
              viewportExtent: viewportSize.width,
              thickness: thickness,
              onScroll: onScrollX,
            ),
          ),
      ],
    );
  }
}

class _ScrollThumb extends StatefulWidget {
  const _ScrollThumb({
    required this.axis,
    required this.scrollOffset,
    required this.maxScroll,
    required this.viewportExtent,
    required this.thickness,
    required this.onScroll,
  });

  final Axis axis;
  final double scrollOffset;
  final double maxScroll;
  final double viewportExtent;
  final double thickness;

  /// Called with the pixel-delta to apply (positive = scroll right/down).
  final void Function(double delta) onScroll;

  @override
  State<_ScrollThumb> createState() => _ScrollThumbState();
}

class _ScrollThumbState extends State<_ScrollThumb> {
  bool _hovered = false;
  bool _dragging = false;
  double _dragStartPointer = 0;
  double _dragStartScroll = 0;

  void _onDragStart(double pointerOffset) {
    setState(() => _dragging = true);
    _dragStartPointer = pointerOffset;
    _dragStartScroll = widget.scrollOffset;
  }

  void _onDragUpdate(double pointerOffset, double trackLength) {
    if (!_dragging) return;
    final thumbLength = _thumbLength(trackLength);
    final available = trackLength - thumbLength;
    if (available <= 0) return;
    final delta = pointerOffset - _dragStartPointer;
    final newScroll = _dragStartScroll + (delta / available) * widget.maxScroll;
    widget.onScroll(newScroll - widget.scrollOffset);
  }

  void _onDragEnd() => setState(() => _dragging = false);

  double _thumbLength(double trackLength) {
    final fraction =
        widget.viewportExtent / (widget.maxScroll + widget.viewportExtent);
    return (trackLength * fraction).clamp(widget.thickness * 3, trackLength);
  }

  double _thumbPosition(double trackLength) {
    if (widget.maxScroll <= 0) return 0;
    final thumbLen = _thumbLength(trackLength);
    final available = trackLength - thumbLen;
    return (widget.scrollOffset / widget.maxScroll) * available;
  }

  @override
  Widget build(BuildContext context) {
    final isVertical = widget.axis == Axis.vertical;
    final isActive = _hovered || _dragging;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onVerticalDragStart: isVertical
            ? (d) => _onDragStart(d.localPosition.dy)
            : null,
        onVerticalDragUpdate: isVertical
            ? (d) {
                final box = context.findRenderObject() as RenderBox?;
                _onDragUpdate(d.localPosition.dy, box?.size.height ?? 0);
              }
            : null,
        onVerticalDragEnd: isVertical ? (_) => _onDragEnd() : null,
        onHorizontalDragStart: !isVertical
            ? (d) => _onDragStart(d.localPosition.dx)
            : null,
        onHorizontalDragUpdate: !isVertical
            ? (d) {
                final box = context.findRenderObject() as RenderBox?;
                _onDragUpdate(d.localPosition.dx, box?.size.width ?? 0);
              }
            : null,
        onHorizontalDragEnd: !isVertical ? (_) => _onDragEnd() : null,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final trackLength = isVertical
                ? constraints.maxHeight
                : constraints.maxWidth;
            final thumbLen = _thumbLength(trackLength);
            final thumbPos = _thumbPosition(trackLength);

            return Stack(
              children: [
                // Track background (visible on hover/drag)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  decoration: BoxDecoration(
                    color: isActive
                        ? Colors.grey.shade400.withAlpha(60)
                        : Colors.transparent,
                    borderRadius: .circular(widget.thickness / 2),
                  ),
                ),
                // Thumb
                Positioned(
                  left: isVertical ? 0 : thumbPos,
                  top: isVertical ? thumbPos : 0,
                  width: isVertical ? widget.thickness : thumbLen,
                  height: isVertical ? thumbLen : widget.thickness,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.grey.shade700.withAlpha(220)
                          : Colors.grey.shade600.withAlpha(160),
                      borderRadius: .circular(widget.thickness / 2),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
