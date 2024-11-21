import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/altimeter.dart';
import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/tools.dart';

class RenderAltimeterGauge extends RenderBox {
  RenderAltimeterGauge({
    Key? key,
    required double value,
    String? titleString,
    String? unitString,
    FrameDesignEnum? frameDesign,
    bool? frameVisible,
    ForegroundTypeEnum? foregroundType,
    bool? foregroundVisible,
    BackgroundColorEnum? backgroundColor,
    bool? backgroundVisible,
    KnobTypeEnum? knobType,
    KnobStyleEnum? knobStyle,
    LcdColorEnum? lcdColor,
    bool? lcdVisible,
    ui.Image? customLayer,
    FontTypeEnum? fontType,
  })  : _value = value,
        _titleString = titleString,
        _unitString = unitString,
        _frameDesign = frameDesign,
        _frameVisible = frameVisible,
        _foregroundType = foregroundType,
        _foregroundVisible = foregroundVisible,
        _backgroundColor = backgroundColor,
        _backgroundVisible = backgroundVisible,
        _knobType = knobType,
        _knobStyle = knobStyle,
        _lcdColor = lcdColor,
        _lcdVisible = lcdVisible,
        _customLayer = customLayer,
        _fontType = fontType,
        super();

  double get getValue => _value;
  double _value;
  set setValue(double value) {
    if (_value == value) return;
    _value = value;
    markNeedsPaint();
    //markNeedsLayout();
  }

  String? get getTitleString => _titleString;
  String? _titleString;
  set setTitleString(String? titleString) {
    if (_titleString == titleString) return;
    _titleString = titleString;
    markNeedsPaint();
  }

  String? get getUnitString => _unitString;
  String? _unitString;
  set setUnitString(String? unitString) {
    if (_unitString == unitString) return;
    _unitString = unitString;
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

  LcdColorEnum? get getLcdColor => _lcdColor;
  LcdColorEnum? _lcdColor;
  set setLcdColor(LcdColorEnum? lcdColor) {
    if (_lcdColor == lcdColor) return;
    _lcdColor = lcdColor;
    markNeedsPaint();
  }

  bool? get getLcdVisible => _lcdVisible;
  bool? _lcdVisible;
  set setLcdVisible(bool? lcdVisible) {
    if (_lcdVisible == lcdVisible) return;
    _lcdVisible = lcdVisible;
    markNeedsPaint();
  }

  ui.Image? get customLayer => _customLayer;
  ui.Image? _customLayer;
  set setCustomLayer(ui.Image? customLayer) {
    if (_customLayer == customLayer) return;
    _customLayer = customLayer;
    markNeedsPaint();
  }

  FontTypeEnum? get getFontType => _fontType;
  FontTypeEnum? _fontType;
  set setFontType(FontTypeEnum? fontType) {
    if (_fontType == fontType) return;
    _fontType = fontType;
    markNeedsPaint();
  }

  @override
  bool hitTestSelf(Offset position) {
    Offset calulatedPosition = localToGlobal(position);
    if (altimeterPath.contains(calulatedPosition)) {
      return true;
    } else if (altimeterPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the altimeter gauge
  }

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  late Path altimeterPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    altimeterPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    altimeterPath.addArc(rect, 0, TWO_PI);
    altimeterPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    drawAltimeter(
      canvas,
      size,
      Parameters(
        value: _value,
        titleString: _titleString,
        unitString: _unitString,
        frameDesign: _frameDesign,
        frameVisible: _frameVisible,
        foregroundType: _foregroundType,
        foregroundVisible: _foregroundVisible,
        backgroundColor: _backgroundColor,
        backgroundVisible: _backgroundVisible,
        knobType: _knobType,
        knobStyle: _knobStyle,
        lcdColor: _lcdColor,
        lcdVisible: _lcdVisible,
        customLayer: _customLayer,
        fontType: _fontType,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
