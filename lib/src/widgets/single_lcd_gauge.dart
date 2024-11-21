import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';

import 'single_lcd_gauge_painter.dart';

///
/// Creates a SingleLCDGauge.
///
///```dart
/// ```
class SingleLCDGauge extends StatefulWidget {
  /// Creates a SingleLCDGauge.
  ///
  ///```dart
  /// ```
  const SingleLCDGauge({
    super.key,
    this.value = 0,
    this.stringValue,
    this.unitString,
    this.unitStringVisible = true,
    this.headerString,
    this.headerStringVisible = false,
    this.lcdColor = LcdColorEnum.STANDARD,
    this.lcdDecimals = 1,
    this.section,
    this.fontType = FontTypeEnum.RobotoMono,
    this.customLayer,
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `value` Sets the value of the [SingleLCDGauge]
  ///
  /// ```dart
  /// const SingleLCDGauge(
  ///   value : 0.0
  /// ),
  /// ```
  ///
  final double? value;

  ///
  /// `stringValue` Sets the display string value of the [SingleLCDGauge]
  ///
  /// ```dart
  /// const SingleLCDGauge(
  ///   stringValue : 'Alert'
  /// ),
  /// ```
  ///
  final String? stringValue;

  ///
  /// `unitString` Sets the units of the [SingleLCDGauge]
  ///
  /// ```dart
  /// const SingleLCDGauge(
  ///   unitString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? unitString;

  ///
  /// `unitStringVisible` Sets the visibility of units of the [SingleLCDGauge]
  ///
  /// ```dart
  /// const SingleLCDGauge(
  ///   unitStringVisible : true
  /// ),
  /// ```
  ///
  final bool? unitStringVisible;

  ///
  /// `headerString` Sets the units of the [SingleLCDGauge]
  ///
  /// ```dart
  /// const SingleLCDGauge(
  ///   headerString : 'Pressure'
  /// ),
  /// ```
  ///
  final String? headerString;

  ///
  /// `headerStringVisible` Sets the visibility of the header of the [SingleLCDGauge]
  ///
  /// ```dart
  /// const SingleLCDGauge(
  ///   headerStringVisible : false
  /// ),
  /// ```
  ///
  final bool? headerStringVisible;

  ///
  /// `lcdColor` Sets the lcd color of the [SingleLCDGauge]
  ///
  /// ```dart
  /// const SingleLCDGauge(
  ///   lcdColor : LcdColorEnum.STANDARD
  /// ),
  /// ```
  ///
  final LcdColorEnum? lcdColor;

  ///
  /// `lcdDecimals` Sets the number of decimals points of the lcd panel of the [SingleLCDGauge]
  ///
  /// ```dart
  /// const SingleLCDGauge(
  ///   lcdDecimals : 1
  /// ),
  /// ```
  ///
  final int? lcdDecimals;

  ///
  /// `section`
  ///
  /// ```dart
  /// const SingleLCDGauge(
  ///   section : [Section(30, 50, Colors.deepPurple), Section(85, 100, Colors.purpleAccent)]
  /// ),
  /// ```
  ///
  final List<Section>? section;

  ///
  /// `customLayer`
  ///
  /// ```dart
  /// const SingleLCDGauge(
  ///   customLayer : [Section(30, 40, Colors.lightGreen), Section(40, 50, Colors.yellow.withOpacity(0.5))]
  /// ),
  /// ```
  ///
  final ui.Image? customLayer;

  ///
  /// `fontType` Sets the font type of the [SingleLCDGauge]
  ///
  /// ```dart
  /// const SingleLCDGauge(
  ///   fontType : FontTypeEnum.RobotoMono
  /// ),
  /// ```
  ///
  final FontTypeEnum? fontType;

  ///
  /// `enableAnimation` will enable animations.
  ///  It's default to true.
  ///
  /// ```
  /// const SingleLCDGauge(
  ///   enableAnimation:true;
  /// )
  /// ```
  ///
  final bool enableAnimation;

  /// Specifies the load time animation duration with [enableAnimation].
  /// Duration is defined in milliseconds.
  ///
  /// Defaults to 1000.
  ///
  /// ```dart
  ///
  /// SingleLCDGauge (
  /// enableAnimation: true,
  /// animationDuration: 4000
  ///  )
  /// ```
  ///
  final int animationDuration;

  /// Specifies the animation type.
  ///
  /// Defaults to [Curves.ease].
  ///
  /// ```dart
  ///
  /// SingleLCDGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<SingleLCDGauge> createState() => _SingleLCDGaugeState();
}

class _SingleLCDGaugeState extends State<SingleLCDGauge>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  double? _from = 0;
  var key = UniqueKey();

  @override
  void initState() {
    super.initState();

    _initializeAnimation();
  }

  @override
  void dispose() {
    if (_animationController != null) {
      _animationController?.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SingleLCDGauge oldWidget) {
    if (oldWidget.enableAnimation != widget.enableAnimation ||
        oldWidget.value != widget.value) {
      _from = oldWidget.value;
      _initializeAnimation();
    }

    super.didUpdateWidget(oldWidget);
  }

  void _initializeAnimation() {
    if (_animationController != null) {
      _animationController?.dispose();
      _animationController = null;
    }

    if (widget.enableAnimation && widget.stringValue == null) {
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: widget.animationDuration,
        ),
      );
      _animation = Tween<double>(begin: _from, end: widget.value).animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Interval(
            0.05,
            1.0,
            curve: widget.animationType,
          ),
        ),
      );
      _animationController!.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enableAnimation && widget.stringValue == null) {
      return AnimatedBuilder(
        animation: _animationController!,
        builder: (context, child) {
          return _getChild(context, _animation!.value, widget.stringValue);
        },
      );
    } else {
      return _getChild(context, widget.value!, widget.stringValue);
    }
  }

  Widget _getChild(BuildContext context, double value, String? stringValue) {
    return _LeafSingleLCDGauge(
      value: value,
      stringValue: stringValue,
      unitString: widget.unitString,
      unitStringVisible: widget.unitStringVisible,
      headerString: widget.headerString,
      headerStringVisible: widget.headerStringVisible,
      lcdColor: widget.lcdColor,
      lcdDecimals: widget.lcdDecimals,
      section: widget.section,
      customLayer: widget.customLayer,
      fontType: widget.fontType,
    );
  }
}

class _LeafSingleLCDGauge extends LeafRenderObjectWidget {
  const _LeafSingleLCDGauge({
    this.value = 0,
    this.stringValue,
    this.unitString,
    this.unitStringVisible,
    this.headerString,
    this.headerStringVisible,
    this.lcdColor,
    this.lcdDecimals,
    this.section,
    this.customLayer,
    this.fontType,
  });

  final double? value;
  final String? stringValue;
  final String? unitString;
  final bool? unitStringVisible;
  final String? headerString;
  final bool? headerStringVisible;
  final LcdColorEnum? lcdColor;
  final int? lcdDecimals;
  final List<Section>? section;
  final ui.Image? customLayer;
  final FontTypeEnum? fontType;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderSingleLCDGauge(
      value: value!,
      stringValue: stringValue,
      unitString: unitString,
      unitStringVisible: unitStringVisible,
      headerString: headerString,
      headerStringVisible: headerStringVisible,
      lcdColor: lcdColor,
      lcdDecimals: lcdDecimals,
      section: section,
      customLayer: customLayer,
      fontType: fontType,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderSingleLCDGauge renderObject) {
    renderObject
      ..setValue = value!
      ..setStringValue = stringValue
      ..setUnitString = unitString
      ..setUnitStringVisible = unitStringVisible
      ..setHeaderString = headerString
      ..setHeaderStringVisible = headerStringVisible
      ..setLcdColor = lcdColor
      ..setLcdDecimals = lcdDecimals
      ..setSection = section
      ..setCustomLayer = customLayer
      ..setFontType = fontType;
  }
}
