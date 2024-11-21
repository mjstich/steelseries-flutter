import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/tools.dart';
import 'package:steelseries_flutter/src/draw/compass.dart';

class RenderCompassGauge extends RenderBox {
  RenderCompassGauge({
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
    KnobTypeEnum? knobType,
    KnobStyleEnum? knobStyle,
    List<String>? pointSymbols,
    bool? pointSymbolsVisible,
    bool? degreeScale,
    bool? roseVisible,
    bool? rotateFace,
    Color? degreeFontColor,
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
        _knobType = knobType,
        _knobStyle = knobStyle,
        _pointSymbols = pointSymbols,
        _pointSymbolsVisible = pointSymbolsVisible,
        _degreeScale = degreeScale,
        _roseVisible = roseVisible,
        _rotateFace = rotateFace,
        _degreeFontColor = degreeFontColor,
        _customLayer = customLayer,
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

  KnobTypeEnum? get getKnobType => _knobType;
  KnobTypeEnum? _knobType;
  set setKnobType(KnobTypeEnum? knobType) {
    if (_knobType == knobType) return;
    _knobType = knobType;
    markNeedsPaint();
  }

  KnobStyleEnum? get getKnobStyle => _knobStyle;
  KnobStyleEnum? _knobStyle;
  set setKnobStyle(KnobStyleEnum? knobStyle) {
    if (_knobStyle == knobStyle) return;
    _knobStyle = knobStyle;
    markNeedsPaint();
  }

  List<String>? get getPointSymbols => _pointSymbols;
  List<String>? _pointSymbols;
  set setPointSymbols(List<String>? pointSymbols) {
    if (_pointSymbols == pointSymbols) return;
    _pointSymbols = pointSymbols;
    markNeedsPaint();
  }

  bool? get getPointSymbolsVisible => _pointSymbolsVisible;
  bool? _pointSymbolsVisible;
  set setPointSymbolsVisible(bool? pointSymbolsVisible) {
    if (_pointSymbolsVisible == pointSymbolsVisible) return;
    _pointSymbolsVisible = pointSymbolsVisible;
    markNeedsPaint();
  }

  bool? get getDegreeScale => _degreeScale;
  bool? _degreeScale;
  set setDegreeScale(bool? degreeScale) {
    if (_degreeScale == degreeScale) return;
    _degreeScale = degreeScale;
    markNeedsPaint();
  }

  bool? get getRoseVisible => _roseVisible;
  bool? _roseVisible;
  set setRoseVisible(bool? roseVisible) {
    if (_roseVisible == roseVisible) return;
    _roseVisible = roseVisible;
    markNeedsPaint();
  }

  bool? get getRotateFace => _rotateFace;
  bool? _rotateFace;
  set setRotateFace(bool? rotateFace) {
    if (_rotateFace == rotateFace) return;
    _rotateFace = rotateFace;
    markNeedsPaint();
  }

  Color? get getDegreeFontColor => _degreeFontColor;
  Color? _degreeFontColor;
  set setDegreeFontColor(Color? degreeFontColor) {
    if (_degreeFontColor == degreeFontColor) return;
    _degreeFontColor = degreeFontColor;
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
    if (compassPath.contains(calulatedPosition)) {
      return true;
    } else if (compassPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the compass gauge
  }

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  late Path compassPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    compassPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    compassPath.addArc(rect, 0, TWO_PI);
    compassPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    drawCompass(
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
        knobType: _knobType,
        knobStyle: _knobStyle,
        pointerSymbols: _pointSymbols,
        pointSymbolsVisible: _pointSymbolsVisible,
        degreeScale: _degreeScale,
        roseVisible: _roseVisible,
        rotateFace: _rotateFace,
        degreeFontColor: _degreeFontColor,
        customLayer: _customLayer,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
