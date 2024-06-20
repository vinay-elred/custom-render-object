import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'render_progress_bar.dart';

class ProgressBar extends LeafRenderObjectWidget {
  const ProgressBar({
    super.key,
    this.thumbColor = Colors.brown,
    this.pointsColor = Colors.brown,
    this.thumbSize = 20.0,
    this.trackColor = Colors.brown,
  });
  final Color thumbColor;
  final Color trackColor;
  final Color pointsColor;
  final double thumbSize;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderProgressBar(
      thumbColor: thumbColor,
      trackColor: trackColor,
      thumbSize: thumbSize,
      pointsColor: pointsColor,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant RenderProgressBar renderObject,
  ) {
    renderObject
      ..thumbColor = thumbColor
      ..pointsColor = pointsColor
      ..thumbSize = thumbSize
      ..trackColor = trackColor;
    super.updateRenderObject(context, renderObject);
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties.add(ColorProperty('thumbColor', thumbColor));
    properties.add(ColorProperty('pointsColor', pointsColor));
    properties.add(ColorProperty('trackColor', trackColor));
    properties.add(DoubleProperty('thumbSize', thumbSize));
    super.debugFillProperties(properties);
  }
}
