import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';

class RenderProgressBar extends RenderBox {
  RenderProgressBar({
    required Color thumbColor,
    required Color pointsColor,
    required double thumbSize,
    required Color trackColor,
  }) {
    _thumbColor = thumbColor;
    _trackColor = trackColor;
    _pointsColor = pointsColor;
    _thumbSize = thumbSize;
    _gestureRecognizer = HorizontalDragGestureRecognizer();
    _gestureRecognizer.onStart =
        (details) => onDragUpdate(details.localPosition);
    _gestureRecognizer.onUpdate =
        (details) => onDragUpdate(details.localPosition);
  }
  double thumpPoistion = 0.1;
  late Color _thumbColor;
  late Color _trackColor;
  late Color _pointsColor;
  late double _thumbSize;
  set thumbColor(Color color) {
    if (_thumbColor == color) return;
    _thumbColor = color;
    markNeedsPaint();
  }

  set pointsColor(Color color) {
    if (_pointsColor == color) return;
    _pointsColor = color;
    markNeedsPaint();
  }

  set trackColor(Color color) {
    if (_trackColor == color) return;
    _trackColor = color;
    markNeedsPaint();
  }

  set thumbSize(double size) {
    if (_thumbSize == size) return;
    _thumbSize = size;
    markNeedsPaint();
  }

  @override
  void performLayout() {
    final width = constraints.maxWidth;
    final height = _thumbSize;
    final constraintsSize = Size(width, height);
    size = constraints.constrain(constraintsSize);
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    // paint dots
    final paintDots = Paint()
      ..color = _pointsColor
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // paint Thumb
    final paintThumb = Paint()
      ..color = _thumbColor
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    // paint Track
    final paintTrack = Paint()
      ..color = _trackColor
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final pointSpace = size.width / 10;
    for (var i = 0; i < 11; i++) {
      final p1 = Offset(pointSpace * i, size.height);
      double upperPoint = size.height * 0.75;
      if (i % 2 == 0) upperPoint = size.height * 0.55;
      final p2 = Offset(pointSpace * i, upperPoint);
      canvas.drawLine(p1, p2, paintDots);
    }

    final thumbDx = size.width * thumpPoistion;

    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(thumbDx, size.height / 2),
      paintTrack,
    );

    canvas.drawCircle(
      Offset(thumbDx, size.height / 2),
      size.height / 2,
      paintThumb,
    );

    super.paint(context, offset);
  }

  late HorizontalDragGestureRecognizer _gestureRecognizer;

  @override
  bool hitTestSelf(Offset position) => true;

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {
    if (event is PointerDownEvent) {
      _gestureRecognizer.addPointer(event);
    }
    super.handleEvent(event, entry);
  }

  void onDragUpdate(Offset details) {
    final dx = details.dx.clamp(0, size.width);
    thumpPoistion = double.parse((dx / size.width).toStringAsFixed(1));
    markNeedsPaint();
    markNeedsSemanticsUpdate();
  }
}
