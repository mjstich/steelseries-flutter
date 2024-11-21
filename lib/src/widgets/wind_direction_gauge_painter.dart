import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/tools.dart';
import 'package:steelseries_flutter/src/draw/windDirection.dart';

class RenderWindDirectionGauge extends RenderBox {
  RenderWindDirectionGauge({
    Key? key,
    required double value,
    required double valueAverage,
    FrameDesignEnum? frameDesign,
    bool? frameVisible,
    ForegroundTypeEnum? foregroundType,
    bool? foregroundVisible,
    BackgroundColorEnum? backgroundColor,
    bool? backgroundVisible,
    PointerTypeEnum? pointerType,
    PointerTypeEnum? pointerTypeAverage,
    ColorEnum? pointerColor,
    ColorEnum? pointerColorAverage,
    KnobTypeEnum? knobType,
    KnobStyleEnum? knobStyle,
    LcdColorEnum? lcdColor,
    bool? lcdVisible,
    List<String>? pointSymbols,
    bool? pointSymbolsVisible,
    bool? degreeScale,
    bool? degreeScaleHalf,
    bool? roseVisible,
    String? titleString,
    List<String>? lcdTitleStrings,
    bool? useColorLabels,
    List<Section>? section,
    List<Section>? area,
    ui.Image? customLayer,
    FontTypeEnum? fontType,
  })  : _value = value,
        _valueAverage = valueAverage,
        _frameDesign = frameDesign,
        _frameVisible = frameVisible,
        _foregroundType = foregroundType,
        _foregroundVisible = foregroundVisible,
        _backgroundColor = backgroundColor,
        _backgroundVisible = backgroundVisible,
        _pointerType = pointerType,
        _pointerTypeAverage = pointerTypeAverage,
        _pointerColor = pointerColor,
        _pointerColorAverage = pointerColorAverage,
        _knobType = knobType,
        _knobStyle = knobStyle,
        _lcdColor = lcdColor,
        _lcdVisible = lcdVisible,
        _pointSymbols = pointSymbols,
        _pointSymbolsVisible = pointSymbolsVisible,
        _degreeScale = degreeScale,
        _degreeScaleHalf = degreeScaleHalf,
        _roseVisible = roseVisible,
        _titleString = titleString,
        _lcdTitleStrings = lcdTitleStrings,
        _useColorLabels = useColorLabels,
        _section = section,
        _area = area,
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

  double get getValueAverage => _valueAverage;
  double _valueAverage;
  set setValueAverage(double valueAverage) {
    if (_valueAverage == valueAverage) return;
    _valueAverage = valueAverage;
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

  PointerTypeEnum? get getPointerTypeAverage => _pointerTypeAverage;
  PointerTypeEnum? _pointerTypeAverage;
  set setPointerTypeAverage(PointerTypeEnum? pointerTypeAverage) {
    if (_pointerTypeAverage == pointerTypeAverage) return;
    _pointerTypeAverage = pointerTypeAverage;
    markNeedsPaint();
  }

  ColorEnum? get getPointerColor => _pointerColor;
  ColorEnum? _pointerColor;
  set setPointerColor(ColorEnum? pointerColor) {
    if (_pointerColor == pointerColor) return;
    _pointerColor = pointerColor;
    markNeedsPaint();
  }

  ColorEnum? get getPointerColorAverage => _pointerColorAverage;
  ColorEnum? _pointerColorAverage;
  set setPointerColorAverage(ColorEnum? pointerColorAverage) {
    if (_pointerColorAverage == pointerColorAverage) return;
    _pointerColorAverage = pointerColorAverage;
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

  bool? get getDegreeScaleHalf => _degreeScaleHalf;
  bool? _degreeScaleHalf;
  set setDegreeScaleHalf(bool? degreeScaleHalf) {
    if (_degreeScaleHalf == degreeScaleHalf) return;
    _degreeScaleHalf = degreeScaleHalf;
    markNeedsPaint();
  }

  bool? get getRoseVisible => _roseVisible;
  bool? _roseVisible;
  set setRoseVisible(bool? roseVisible) {
    if (_roseVisible == roseVisible) return;
    _roseVisible = roseVisible;
    markNeedsPaint();
  }

  String? get getTitleString => _titleString;
  String? _titleString;
  set setTitleString(String? titleString) {
    if (_titleString == titleString) return;
    _titleString = titleString;
    markNeedsPaint();
  }

  List<String>? get getLcdTitleStrings => _lcdTitleStrings;
  List<String>? _lcdTitleStrings;
  set setLcdTitleStrings(List<String>? lcdTitleStrings) {
    if (_lcdTitleStrings == lcdTitleStrings) return;
    _lcdTitleStrings = lcdTitleStrings;
    markNeedsPaint();
  }

  bool? get getUseColorLabels => _useColorLabels;
  bool? _useColorLabels;
  set setUseColorLabels(bool? useColorLabels) {
    if (_useColorLabels == useColorLabels) return;
    _useColorLabels = useColorLabels;
    markNeedsPaint();
  }

  List<Section>? get section => _section;
  List<Section>? _section;
  set setSection(List<Section>? section) {
    if (_section == section) return;
    _section = section;
    markNeedsPaint();
  }

  List<Section>? get area => _area;
  List<Section>? _area;
  set setArea(List<Section>? area) {
    if (_area == area) return;
    _area = area;
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
    if (windDirectionPath.contains(calulatedPosition)) {
      return true;
    } else if (windDirectionPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the wind direction gauge
  }

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  late Path windDirectionPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    windDirectionPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    windDirectionPath.addArc(rect, 0, TWO_PI);
    windDirectionPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    drawWindDirection(
      canvas,
      size,
      Parameters(
        value: _value,
        valueAverage: _valueAverage,
        frameDesign: _frameDesign,
        frameVisible: _frameVisible,
        foregroundType: _foregroundType,
        foregroundVisible: _foregroundVisible,
        backgroundColor: _backgroundColor,
        backgroundVisible: _backgroundVisible,
        pointerType: _pointerType,
        pointerTypeAverage: _pointerTypeAverage,
        pointerColor: _pointerColor,
        pointerColorAverage: _pointerColorAverage,
        knobType: _knobType,
        knobStyle: _knobStyle,
        lcdColor: _lcdColor,
        lcdVisible: _lcdVisible,
        pointerSymbols: _pointSymbols,
        pointSymbolsVisible: _pointSymbolsVisible,
        degreeScale: _degreeScale,
        degreeScaleHalf: _degreeScaleHalf,
        roseVisible: _roseVisible,
        titleString: _titleString,
        lcdTitleStrings: _lcdTitleStrings,
        useColorLabels: _useColorLabels,
        section: _section,
        area: _area,
        customLayer: _customLayer,
        fontType: _fontType,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
