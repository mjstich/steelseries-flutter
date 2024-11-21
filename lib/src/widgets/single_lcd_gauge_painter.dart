import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/drawSingle.dart';

class RenderSingleLCDGauge extends RenderBox {
  RenderSingleLCDGauge({
    Key? key,
    required double value,
    String? stringValue,
    String? unitString,
    bool? unitStringVisible,
    String? headerString,
    bool? headerStringVisible,
    LcdColorEnum? lcdColor,
    int? lcdDecimals,
    List<Section>? section,
    ui.Image? customLayer,
    FontTypeEnum? fontType,
  })  : _value = value,
        _stringValue = stringValue,
        _unitString = unitString,
        _unitStringVisible = unitStringVisible,
        _headerString = headerString,
        _headerStringVisible = headerStringVisible,
        _lcdColor = lcdColor,
        _lcdDecimals = lcdDecimals,
        _section = section,
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

  String? get getStringValue => _stringValue;
  String? _stringValue;
  set setStringValue(String? stringValue) {
    if (_stringValue == stringValue) return;
    _stringValue = stringValue;
    markNeedsPaint();
  }

  String? get getHeaderString => _headerString;
  String? _headerString;
  set setHeaderString(String? headerString) {
    if (_headerString == headerString) return;
    _headerString = headerString;
    markNeedsPaint();
  }

  bool? get getHeaderStrinVisible => _headerStringVisible;
  bool? _headerStringVisible;
  set setHeaderStringVisible(bool? headerStringVisible) {
    if (_headerStringVisible == headerStringVisible) return;
    _headerStringVisible = headerStringVisible;
    markNeedsPaint();
  }

  String? get getUnitString => _unitString;
  String? _unitString;
  set setUnitString(String? unitString) {
    if (_unitString == unitString) return;
    _unitString = unitString;
    markNeedsPaint();
  }

  bool? get getUnitStrinVisible => _headerStringVisible;
  bool? _unitStringVisible;
  set setUnitStringVisible(bool? unitStringVisible) {
    if (_unitStringVisible == unitStringVisible) return;
    _unitStringVisible = unitStringVisible;
    markNeedsPaint();
  }

  GaugeTypeEnum? get getGaugeType => _gaugeType;
  GaugeTypeEnum? _gaugeType;
  set setGaugeType(GaugeTypeEnum? gaugeType) {
    if (_gaugeType == gaugeType) return;
    _gaugeType = gaugeType;
    markNeedsPaint();
  }

  LcdColorEnum? get getLcdColor => _lcdColor;
  LcdColorEnum? _lcdColor;
  set setLcdColor(LcdColorEnum? lcdColor) {
    if (_lcdColor == lcdColor) return;
    _lcdColor = lcdColor;
    markNeedsPaint();
  }

  int? get getLcdDecimals => _lcdDecimals;
  int? _lcdDecimals;
  set setLcdDecimals(int? lcdDecimals) {
    if (_lcdDecimals == lcdDecimals) return;
    _lcdDecimals = lcdDecimals;
    markNeedsPaint();
  }

  List<Section>? get section => _section;
  List<Section>? _section;
  set setSection(List<Section>? section) {
    if (_section == section) return;
    _section = section;
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
    if (singleLCDPath.contains(calulatedPosition)) {
      return true;
    } else if (singleLCDPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the single lcd gauge
  }

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  late Path singleLCDPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    singleLCDPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    singleLCDPath.addRect(rect);
    singleLCDPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    drawDisplaySingle(
      canvas,
      size,
      Parameters(
        value: _value,
        stringValue: _stringValue,
        unitString: _unitString,
        unitStringVisible: _unitStringVisible,
        headerString: _headerString,
        headerStringVisible: _headerStringVisible,
        gaugeType: _gaugeType,
        lcdColor: _lcdColor,
        lcdDecimals: _lcdDecimals,
        section: _section,
        customLayer: _customLayer,
        fontType: _fontType,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
