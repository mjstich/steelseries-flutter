import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/tools.dart';
import 'package:steelseries_flutter/src/draw/clock.dart';

class RenderClockGauge extends RenderBox {
  RenderClockGauge({
    Key? key,
    required double value,
    FrameDesignEnum? frameDesign,
    bool? frameVisible,
    ForegroundTypeEnum? foregroundType,
    bool? foregroundVisible,
    BackgroundColorEnum? backgroundColor,
    bool? backgroundVisible,
    PointerTypeEnum? pointerType,
    ColorEnum? pointerColor,
    bool? secondPointerVisible,
    ui.Image? customLayer,
  })  : _value = value,
        _frameDesign = frameDesign,
        _frameVisible = frameVisible,
        _foregroundType = foregroundType,
        _foregroundVisible = foregroundVisible,
        _backgroundColor = backgroundColor,
        _backgroundVisible = backgroundVisible,
        _pointerType = pointerType,
        _pointerColor = pointerColor,
        _secondPointerVisible = secondPointerVisible,
        _customLayer = customLayer,
        super();

  double get getValue => _value;
  double _value;
  set setValue(double value) {
    if (_value == value) return;
    _value = value;
    markNeedsPaint();
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

  PointerTypeEnum? get getPointerType => _pointerType;
  PointerTypeEnum? _pointerType;
  set setPointerType(PointerTypeEnum? pointerType) {
    if (_pointerType == pointerType) return;
    _pointerType = pointerType;
    markNeedsPaint();
  }

  ColorEnum? get getPointerColor => _pointerColor;
  ColorEnum? _pointerColor;
  set setPointerColor(ColorEnum? pointerColor) {
    if (_pointerColor == pointerColor) return;
    _pointerColor = pointerColor;
    markNeedsPaint();
  }

  bool? get getSecondPointerVisible => _secondPointerVisible;
  bool? _secondPointerVisible;
  set setSecondPointerVisible(bool? secondPointerVisible) {
    if (_secondPointerVisible == secondPointerVisible) return;
    _secondPointerVisible = secondPointerVisible;
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
    if (clockPath.contains(calulatedPosition)) {
      return true;
    } else if (clockPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the clock gauge
  }

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  late Path clockPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    clockPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    clockPath.addArc(rect, 0, TWO_PI);
    clockPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    drawClock(
      canvas,
      size,
      Parameters(
        value: _value,
        frameDesign: _frameDesign,
        frameVisible: _frameVisible,
        foregroundType: _foregroundType,
        foregroundVisible: _foregroundVisible,
        backgroundColor: _backgroundColor,
        backgroundVisible: _backgroundVisible,
        pointerType: _pointerType,
        pointerColor: _pointerColor,
        customLayer: _customLayer,
        secondPointerVisible: _secondPointerVisible,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
