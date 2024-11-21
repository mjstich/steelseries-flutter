import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/tools.dart';
import 'package:steelseries_flutter/src/draw/level.dart';

class RenderLevelGauge extends RenderBox {
  RenderLevelGauge({
    Key? key,
    required double value,
    FrameDesignEnum? frameDesign,
    bool? frameVisible,
    ForegroundTypeEnum? foregroundType,
    bool? foregroundVisible,
    BackgroundColorEnum? backgroundColor,
    bool? backgroundVisible,
    ColorEnum? pointerColor,
    bool? rotateFace,
    bool? decimalsVisible,
    bool? textOrientationFixed,
  })  : _value = value,
        _frameDesign = frameDesign,
        _frameVisible = frameVisible,
        _foregroundType = foregroundType,
        _foregroundVisible = foregroundVisible,
        _backgroundColor = backgroundColor,
        _backgroundVisible = backgroundVisible,
        _pointerColor = pointerColor,
        _rotateFace = rotateFace,
        _decimalsVisible = decimalsVisible,
        _textOrientationFixed = textOrientationFixed,
        super();

  double get getValue => _value;
  double _value;
  set setValue(double value) {
    if (_value == value) return;
    _value = value;
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

  bool? get getRotateFace => _rotateFace;
  bool? _rotateFace;
  set setRotateFace(bool? rotateFace) {
    if (_rotateFace == rotateFace) return;
    _rotateFace = rotateFace;
    markNeedsPaint();
  }

  bool? get getDecimalsVisible => _decimalsVisible;
  bool? _decimalsVisible;
  set setDecimalsVisible(bool? decimalsVisible) {
    if (_decimalsVisible == decimalsVisible) return;
    _decimalsVisible = decimalsVisible;
    markNeedsPaint();
  }

  bool? get getTextOrientationFixed => _textOrientationFixed;
  bool? _textOrientationFixed;
  set setTextOrientationFixed(bool? textOrientationFixed) {
    if (_textOrientationFixed == textOrientationFixed) return;
    _textOrientationFixed = textOrientationFixed;
    markNeedsPaint();
  }

  @override
  bool hitTestSelf(Offset position) {
    Offset calulatedPosition = localToGlobal(position);
    if (levelPath.contains(calulatedPosition)) {
      return true;
    } else if (levelPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the level gauge
  }

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  late Path levelPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    levelPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    levelPath.addArc(rect, 0, TWO_PI);
    levelPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    drawLevel(
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
        pointerColor: _pointerColor,
        rotateFace: _rotateFace,
        decimalsVisible: _decimalsVisible,
        textOrientationFixed: _textOrientationFixed,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
