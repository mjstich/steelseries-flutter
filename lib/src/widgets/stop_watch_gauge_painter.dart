import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/tools.dart';
import 'package:steelseries_flutter/src/draw/stopWatch.dart';

class RenderStopwatchGauge extends RenderBox {
  RenderStopwatchGauge({
    Key? key,
    required double seconds,
    FrameDesignEnum? frameDesign,
    bool? frameVisible,
    ForegroundTypeEnum? foregroundType,
    bool? foregroundVisible,
    BackgroundColorEnum? backgroundColor,
    bool? backgroundVisible,
    ColorEnum? pointerColor,
    ui.Image? customLayer,
  })  : _seconds = seconds,
        _frameDesign = frameDesign,
        _frameVisible = frameVisible,
        _foregroundType = foregroundType,
        _foregroundVisible = foregroundVisible,
        _backgroundColor = backgroundColor,
        _backgroundVisible = backgroundVisible,
        _pointerColor = pointerColor,
        _customLayer = customLayer,
        super();

  double get getSeconds => _seconds;
  double _seconds;
  set setSeconds(double seconds) {
    if (_seconds == seconds) return;
    _seconds = seconds;
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

  BackgroundColorEnum? get getBackgroundColor => _backgroundColor;
  BackgroundColorEnum? _backgroundColor;
  set setBackgroundColor(BackgroundColorEnum? backgroundColor) {
    if (_backgroundColor == backgroundColor) return;
    _backgroundColor = backgroundColor;
    markNeedsPaint();
  }

  bool? get getBackgroundVisible => _backgroundVisible;
  bool? _backgroundVisible;
  set setBackgroundVisible(bool? backgroundVisible) {
    if (_backgroundVisible == backgroundVisible) return;
    _backgroundVisible = backgroundVisible;
    markNeedsPaint();
  }

  ColorEnum? get getPointerColor => _pointerColor;
  ColorEnum? _pointerColor;
  set setPointerColor(ColorEnum? pointerColor) {
    if (_pointerColor == pointerColor) return;
    _pointerColor = pointerColor;
    markNeedsPaint();
  }

  ui.Image? get customLayer => _customLayer;
  ui.Image? _customLayer;
  set setCustomLayer(ui.Image? customLayer) {
    if (_customLayer == customLayer) return;
    _customLayer = customLayer;
    markNeedsPaint();
  }

  @override
  bool hitTestSelf(Offset position) {
    Offset calulatedPosition = localToGlobal(position);
    if (stopWatchPath.contains(calulatedPosition)) {
      return true;
    } else if (stopWatchPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the stop watch gauge
  }

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  late Path stopWatchPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    stopWatchPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    stopWatchPath.addArc(rect, 0, TWO_PI);
    stopWatchPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    drawStopwatch(
      canvas,
      size,
      Parameters(
        seconds: _seconds,
        frameDesign: _frameDesign,
        frameVisible: _frameVisible,
        foregroundType: _foregroundType,
        foregroundVisible: _foregroundVisible,
        backgroundColor: _backgroundColor,
        backgroundVisible: _backgroundVisible,
        pointerColor: _pointerColor,
        customLayer: _customLayer,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
