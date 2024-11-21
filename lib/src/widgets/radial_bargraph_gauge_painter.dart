import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/tools.dart';
import 'package:steelseries_flutter/src/draw/radialBargraph.dart';

class RenderRadialBargraphGauge extends RenderBox {
  RenderRadialBargraphGauge({
    Key? key,
    required double value,
    required double start,
    required double end,
    String? titleString,
    String? unitString,
    GaugeTypeEnum? gaugeType,
    FrameDesignEnum? frameDesign,
    bool? frameVisible,
    ForegroundTypeEnum? foregroundType,
    bool? foregroundVisible,
    BackgroundColorEnum? backgroundColor,
    bool? backgroundVisible,
    LcdColorEnum? lcdColor,
    bool? lcdVisible,
    int? lcdDecimals,
    LedColorEnum? ledColor,
    bool? ledVisible,
    bool? ledOn,
    LedColorEnum? userLedColor,
    bool? userLedVisible,
    bool? userLedOn,
    int? fractionalScaleDecimals,
    bool? niceScale,
    double? threshold,
    bool? thresholdVisible,
    double? minMeasuredValue,
    bool? minMeasuredValueVisible,
    double? maxMeasuredValue,
    bool? maxMeasuredValueVisible,
    List<LedColorEnum>? trendColors,
    TrendStateEnum? trendState,
    bool? trendVisible,
    LabelNumberFormatEnum? labelNumberFormat,
    TickLabelOrientationEnum? tickLabelOrientation,
    final List<Section>? section,
    final bool? useSectionColors,
    final GradientWrapper? valueGradient,
    final bool? useValueGradient,
    ui.Image? customLayer,
    FontTypeEnum? fontType,
  })  : _value = value,
        _start = start,
        _end = end,
        _titleString = titleString,
        _unitString = unitString,
        _gaugeType = gaugeType,
        _frameDesign = frameDesign,
        _frameVisible = frameVisible,
        _foregroundType = foregroundType,
        _foregroundVisible = foregroundVisible,
        _backgroundColor = backgroundColor,
        _backgroundVisible = backgroundVisible,
        _lcdColor = lcdColor,
        _lcdVisible = lcdVisible,
        _lcdDecimals = lcdDecimals,
        _ledColor = ledColor,
        _ledVisible = ledVisible,
        _ledOn = ledOn,
        _userLedColor = userLedColor,
        _userLedVisible = userLedVisible,
        _userLedOn = userLedOn,
        _fractionalScaleDecimals = fractionalScaleDecimals,
        _niceScale = niceScale,
        _threshold = threshold,
        _thresholdVisible = thresholdVisible,
        _minMeasuredValue = minMeasuredValue,
        _minMeasuredValueVisible = minMeasuredValueVisible,
        _maxMeasuredValue = maxMeasuredValue,
        _maxMeasuredValueVisible = maxMeasuredValueVisible,
        _trendColors = trendColors,
        _trendState = trendState,
        _trendVisible = trendVisible,
        _labelNumberFormat = labelNumberFormat,
        _tickLabelOrientation = tickLabelOrientation,
        _section = section,
        _useSectionColors = useSectionColors,
        _valueGradient = valueGradient,
        _useValueGradient = useValueGradient,
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

  double get getStart => _start;
  double _start;
  set setStart(double start) {
    if (_start == start) return;
    _start = start;
    markNeedsPaint();
    //markNeedsLayout();
  }

  double get getEnd => _end;
  double _end;
  set setEnd(double end) {
    if (_end == end) return;
    _end = end;
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

  GaugeTypeEnum? get getGaugeType => _gaugeType;
  GaugeTypeEnum? _gaugeType;
  set setGaugeType(GaugeTypeEnum? gaugeType) {
    if (_gaugeType == gaugeType) return;
    _gaugeType = gaugeType;
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

  int? get getLcdDecimals => _lcdDecimals;
  int? _lcdDecimals;
  set setLcdDecimals(int? lcdDecimals) {
    if (_lcdDecimals == lcdDecimals) return;
    _lcdDecimals = lcdDecimals;
    markNeedsPaint();
  }

  LedColorEnum? get getLedColor => _ledColor;
  LedColorEnum? _ledColor;
  set setLedColor(LedColorEnum? ledColor) {
    if (_ledColor == ledColor) return;
    _ledColor = ledColor;
    markNeedsPaint();
  }

  bool? get getLedVisible => _ledVisible;
  bool? _ledVisible;
  set setLedVisible(bool? ledVisible) {
    if (_ledVisible == ledVisible) return;
    _ledVisible = ledVisible;
    markNeedsPaint();
  }

  bool? get getLedOn => _ledOn;
  bool? _ledOn;
  set setLedOn(bool? ledOn) {
    if (_ledOn == ledOn) return;
    _ledOn = ledOn;
    markNeedsPaint();
  }

  LedColorEnum? get getUserLedColor => _userLedColor;
  LedColorEnum? _userLedColor;
  set setUserLedColor(LedColorEnum? userLedColor) {
    if (_userLedColor == userLedColor) return;
    _userLedColor = userLedColor;
    markNeedsPaint();
  }

  bool? get getUserLedVisible => _userLedVisible;
  bool? _userLedVisible;
  set setUserLedVisible(bool? userLedVisible) {
    if (_userLedVisible == userLedVisible) return;
    _userLedVisible = userLedVisible;
    markNeedsPaint();
  }

  bool? get getUserLedOn => _userLedOn;
  bool? _userLedOn;
  set setUserLedOn(bool? userLedOn) {
    if (_userLedOn == userLedOn) return;
    _userLedOn = userLedOn;
    markNeedsPaint();
  }

  int? get getFractionalScaleDecimals => _fractionalScaleDecimals;
  int? _fractionalScaleDecimals;
  set setFractionalScaleDecimals(int? fractionalScaleDecimals) {
    if (_fractionalScaleDecimals == fractionalScaleDecimals) return;
    _fractionalScaleDecimals = fractionalScaleDecimals;
    markNeedsPaint();
  }

  bool? get getNiceScale => _niceScale;
  bool? _niceScale;
  set setNiceScale(bool? niceScale) {
    if (_niceScale == niceScale) return;
    _niceScale = niceScale;
    markNeedsPaint();
  }

  double? get getThreshold => _threshold;
  double? _threshold;
  set setThreshold(double? threshold) {
    if (_threshold == threshold) return;
    _threshold = threshold;
    markNeedsPaint();
  }

  bool? get getThresholdVisible => _thresholdVisible;
  bool? _thresholdVisible;
  set setThresholdVisible(bool? thresholdVisible) {
    if (_thresholdVisible == thresholdVisible) return;
    _thresholdVisible = thresholdVisible;
    markNeedsPaint();
  }

  double? get minMeasuredValue => _minMeasuredValue;
  double? _minMeasuredValue;
  set setMinMeasuredValue(double? minMeasuredValue) {
    if (_minMeasuredValue == minMeasuredValue) return;
    _minMeasuredValue = minMeasuredValue;
    markNeedsPaint();
  }

  bool? get minMeasuredValueVisible => _minMeasuredValueVisible;
  bool? _minMeasuredValueVisible;
  set setMinMeasuredValueVisible(bool? minMeasuredValueVisible) {
    if (_minMeasuredValueVisible == minMeasuredValueVisible) return;
    _minMeasuredValueVisible = minMeasuredValueVisible;
    markNeedsPaint();
  }

  double? get maxMeasuredValue => _maxMeasuredValue;
  double? _maxMeasuredValue;
  set setMaxMeasuredValue(double? maxMeasuredValue) {
    if (_maxMeasuredValue == maxMeasuredValue) return;
    _maxMeasuredValue = maxMeasuredValue;
    markNeedsPaint();
  }

  bool? get maxMeasuredValueVisible => _maxMeasuredValueVisible;
  bool? _maxMeasuredValueVisible;
  set setMaxMeasuredValueVisible(bool? maxMeasuredValueVisible) {
    if (_maxMeasuredValueVisible == maxMeasuredValueVisible) return;
    _maxMeasuredValueVisible = maxMeasuredValueVisible;
    markNeedsPaint();
  }

  List<LedColorEnum>? get trendColors => _trendColors;
  List<LedColorEnum>? _trendColors;
  set setTrendColors(List<LedColorEnum>? trendColors) {
    if (_trendColors == trendColors) return;
    _trendColors = trendColors;
    markNeedsPaint();
  }

  TrendStateEnum? get trendState => _trendState;
  TrendStateEnum? _trendState;
  set setTrendState(TrendStateEnum? trendState) {
    if (_trendState == trendState) return;
    _trendState = trendState;
    markNeedsPaint();
  }

  bool? get trendVisible => _trendVisible;
  bool? _trendVisible;
  set setTrendVisible(bool? trendVisible) {
    if (_trendVisible == trendVisible) return;
    _trendVisible = trendVisible;
    markNeedsPaint();
  }

  LabelNumberFormatEnum? get labelNumberFormat => _labelNumberFormat;
  LabelNumberFormatEnum? _labelNumberFormat;
  set setLabelNumberFormat(LabelNumberFormatEnum? labelNumberFormat) {
    if (_labelNumberFormat == labelNumberFormat) return;
    _labelNumberFormat = labelNumberFormat;
    markNeedsPaint();
  }

  TickLabelOrientationEnum? get tickLabelOrientation => _tickLabelOrientation;
  TickLabelOrientationEnum? _tickLabelOrientation;
  set setTickLabelOrientation(TickLabelOrientationEnum? tickLabelOrientation) {
    if (_tickLabelOrientation == tickLabelOrientation) return;
    _tickLabelOrientation = tickLabelOrientation;
    markNeedsPaint();
  }

  List<Section>? get section => _section;
  List<Section>? _section;
  set setSection(List<Section>? section) {
    if (_section == section) return;
    _section = section;
    markNeedsPaint();
  }

  bool? get useSectionColors => _useSectionColors;
  bool? _useSectionColors;
  set setUseSectionColors(bool? useSectionColors) {
    if (_useSectionColors == useSectionColors) return;
    _useSectionColors = useSectionColors;
    markNeedsPaint();
  }

  GradientWrapper? get getValueGradient => _valueGradient;
  GradientWrapper? _valueGradient;
  set setValueGradient(GradientWrapper? valueGradient) {
    if (_valueGradient == valueGradient) return;
    _valueGradient = valueGradient;
    markNeedsPaint();
  }

  bool? get useValueGradient => _useValueGradient;
  bool? _useValueGradient;
  set setUseValueGradient(bool? useValueGradient) {
    if (_useValueGradient == useValueGradient) return;
    _useValueGradient = useValueGradient;
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
    if (radialBargraphPath.contains(calulatedPosition)) {
      return true;
    } else if (radialBargraphPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the radial bargraph gauge
  }

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  late Path radialBargraphPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    radialBargraphPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    radialBargraphPath.addArc(rect, 0, TWO_PI);
    radialBargraphPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    drawRadialBargraph(
      canvas,
      size,
      Parameters(
        value: _value,
        minValue: _start,
        maxValue: _end,
        titleString: _titleString,
        unitString: _unitString,
        gaugeType: _gaugeType,
        frameDesign: _frameDesign,
        frameVisible: _frameVisible,
        foregroundType: _foregroundType,
        foregroundVisible: _foregroundVisible,
        backgroundColor: _backgroundColor,
        backgroundVisible: _backgroundVisible,
        lcdColor: _lcdColor,
        lcdVisible: _lcdVisible,
        lcdDecimals: _lcdDecimals,
        ledColor: _ledColor,
        ledVisible: _ledVisible,
        ledOn: _ledOn,
        userLedColor: _userLedColor,
        userLedVisible: _userLedVisible,
        userLedOn: _userLedOn,
        fractionalScaleDecimals: _fractionalScaleDecimals,
        niceScale: _niceScale,
        threshold: _threshold,
        thresholdVisible: _thresholdVisible,
        minMeasuredValue: _minMeasuredValue,
        minMeasuredValueVisible: _minMeasuredValueVisible,
        maxMeasuredValue: _maxMeasuredValue,
        maxMeasuredValueVisible: _maxMeasuredValueVisible,
        trendColors: _trendColors,
        trendState: _trendState,
        trendVisible: _trendVisible,
        labelNumberFormat: _labelNumberFormat,
        tickLabelOrientation: _tickLabelOrientation,
        section: _section,
        useSectionColors: _useSectionColors,
        valueGradient: _valueGradient,
        useValueGradient: _useValueGradient,
        customLayer: _customLayer,
        fontType: _fontType,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
