import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/tools.dart';
import 'package:steelseries_flutter/src/draw/horizon.dart';

class RenderHorizonGauge extends RenderBox {
  RenderHorizonGauge({
    Key? key,
    required double roll,
    required double pitch,
    FrameDesignEnum? frameDesign,
    bool? frameVisible,
    ForegroundTypeEnum? foregroundType,
    bool? foregroundVisible,
    ColorEnum? pointerColor,
  })  : _roll = roll,
        _pitch = pitch,
        _frameDesign = frameDesign,
        _frameVisible = frameVisible,
        _foregroundType = foregroundType,
        _foregroundVisible = foregroundVisible,
        _pointerColor = pointerColor,
        super();

  double get getRoll => _roll;
  double _roll;
  set setRoll(double roll) {
    if (_roll == roll) return;
    _roll = roll;
    markNeedsPaint();
    //markNeedsLayout();
  }

  double get getPitch => _pitch;
  double _pitch;
  set setPitch(double pitch) {
    if (_pitch == pitch) return;
    _pitch = pitch;
    markNeedsPaint();
    //markNeedsLayout();
  }

  FrameDesignEnum? get getFrameDesign => _frameDesign;
  FrameDesignEnum? _frameDesign;
  set setFrameDesign(FrameDesignEnum? frameDesign) {
    if (_frameDesign == frameDesign) return;
    _frameDesign = frameDesign;
    markNeedsPaint();
    //markNeedsLayout();
  }

  bool? get getFrameVisible => _frameVisible;
  bool? _frameVisible;
  set setFrameVisible(bool? frameVisible) {
    if (_frameVisible == frameVisible) return;
    _frameVisible = frameVisible;
    markNeedsPaint();
  }

  ForegroundTypeEnum? get getForegroundType => _foregroundType;
  ForegroundTypeEnum? _foregroundType;
  set setForegroundType(ForegroundTypeEnum? foregroundType) {
    if (_foregroundType == foregroundType) return;
    _foregroundType = foregroundType;
    markNeedsPaint();
  }

  bool? get getForegroundVisible => _foregroundVisible;
  bool? _foregroundVisible;
  set setForegroundVisible(bool? foregroundVisible) {
    if (_foregroundVisible == foregroundVisible) return;
    _foregroundVisible = foregroundVisible;
    markNeedsPaint();
  }

  ColorEnum? get getPointerColor => _pointerColor;
  ColorEnum? _pointerColor;
  set setPointerColor(ColorEnum? pointerColor) {
    if (_pointerColor == pointerColor) return;
    _pointerColor = pointerColor;
    markNeedsPaint();
  }

  @override
  bool hitTestSelf(Offset position) {
    Offset calulatedPosition = localToGlobal(position);
    if (horizonPath.contains(calulatedPosition)) {
      return true;
    } else if (horizonPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the horizon gauge
  }

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  late Path horizonPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    horizonPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    horizonPath.addArc(rect, 0, TWO_PI);
    horizonPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    drawHorizon(
      canvas,
      size,
      Parameters(
        roll: _roll,
        pitch: _pitch,
        frameDesign: _frameDesign,
        frameVisible: _frameVisible,
        foregroundType: _foregroundType,
        foregroundVisible: _foregroundVisible,
        pointerColor: _pointerColor,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
