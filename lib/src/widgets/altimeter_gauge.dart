import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';

import 'altimeter_gauge_painter.dart';

///
/// Creates a AltimeterGauge.
///
///```dart
/// ```
class AltimeterGauge extends StatefulWidget {
  /// Creates a AltimeterGauge.
  ///
  ///```dart
  /// ```
  const AltimeterGauge({
    super.key,
    this.value = 0,
    this.titleString,
    this.unitString,
    this.frameDesign = FrameDesignEnum.METAL,
    this.frameVisible = true,
    this.foregroundType = ForegroundTypeEnum.TYPE4,
    this.foregroundVisible = true,
    this.backgroundColor = BackgroundColorEnum.DARK_GRAY,
    this.backgroundVisible = true,
    this.knobType = KnobTypeEnum.STANDARD_KNOB,
    this.knobStyle = KnobStyleEnum.SILVER,
    this.lcdColor = LcdColorEnum.STANDARD,
    this.lcdVisible = true,
    this.customLayer,
    this.fontType = FontTypeEnum.RobotoMono,
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `value` Sets the value of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   value : 0.0
  /// ),
  /// ```
  ///
  final double? value;

  ///
  /// `titleString` Sets the title of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   titleString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? titleString;

  ///
  /// `unitString` Sets the units of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   unitString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? unitString;

  ///
  /// `frameDesign` Sets the frame design of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   frameDesign : FrameDesignEnum.Metal
  /// ),
  /// ```
  ///
  final FrameDesignEnum? frameDesign;

  ///
  /// `frameVisible` Sets the visibility state of the frame of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? frameVisible;

  ///
  /// `foregroundType` Sets the foreground type of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   foregroundType : ForegroundTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final ForegroundTypeEnum? foregroundType;

  ///
  /// `foregroundVisible` Sets the visibility state of the foreground of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   foregroundVisible : true
  /// ),
  /// ```
  ///
  final bool? foregroundVisible;

  ///
  /// `backgroundColor` Sets the background color of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   backgroundColor : BackgroundColorEnum.DARK_GRAY
  /// ),
  /// ```
  ///
  final BackgroundColorEnum? backgroundColor;

  ///
  /// `backgroundVisible` Sets the visibility state of the background of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? backgroundVisible;

  ///
  /// `knobType` Sets the knob type of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   knobType : KnobTypeEnum.STANDARD_KNOB
  /// ),
  /// ```
  ///
  final KnobTypeEnum? knobType;

  ///
  /// `knobType` Sets the knob style of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   knobStyle : KnobStyleEnum.SILVER
  /// ),
  /// ```
  ///
  final KnobStyleEnum? knobStyle;

  ///
  /// `lcdColor` Sets the lcd color of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   lcdColor : LcdColorEnum.STANDARD
  /// ),
  /// ```
  ///
  final LcdColorEnum? lcdColor;

  ///
  /// `lcdVisible` Sets the visibility of the lcd panel of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   lcdVisible : true
  /// ),
  /// ```
  ///
  final bool? lcdVisible;

  ///
  /// `customLayer`
  ///
  /// ```dart
  /// const AltimeterGauge(
  ///   customLayer : [Section(30, 40, Colors.lightGreen), Section(40, 50, Colors.yellow.withOpacity(0.5))]
  /// ),
  /// ```
  ///
  final ui.Image? customLayer;

  ///
  /// `fontType` Sets the font type of the [AltimeterGauge]
  ///
  /// ```dart
  /// const AltimeterGauge(
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
  /// const AltimeterGauge(
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
  /// AltimeterGauge (
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
  /// AltimeterGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<AltimeterGauge> createState() => _AltimeterGaugeState();
}

class _AltimeterGaugeState extends State<AltimeterGauge> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  double _from = 0;

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
  void didUpdateWidget(covariant AltimeterGauge oldWidget) {
    if (oldWidget.enableAnimation != widget.enableAnimation || oldWidget.value != widget.value) {
      _from = oldWidget.value!;

      _initializeAnimation();
    }

    super.didUpdateWidget(oldWidget);
  }

  void _initializeAnimation() {
    if (_animationController != null) {
      _animationController?.dispose();
      _animationController = null;
    }

    if (widget.enableAnimation) {
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
    if (widget.enableAnimation) {
      return AnimatedBuilder(
        animation: _animationController!,
        builder: (context, child) {
          return _getChild(context, _animation!.value);
        },
      );
    } else {
      return _getChild(context, widget.value!);
    }
  }

  Widget _getChild(BuildContext context, double value) {
    return _LeafAltimeterGauge(
      value: value,
      titleString: widget.titleString,
      unitString: widget.unitString,
      frameDesign: widget.frameDesign,
      frameVisible: widget.frameVisible,
      foregroundType: widget.foregroundType,
      foregroundVisible: widget.foregroundVisible,
      backgroundColor: widget.backgroundColor,
      backgroundVisible: widget.backgroundVisible,
      knobType: widget.knobType,
      knobStyle: widget.knobStyle,
      lcdColor: widget.lcdColor,
      lcdVisible: widget.lcdVisible,
      customLayer: widget.customLayer,
      fontType: widget.fontType,
    );
  }
}

class _LeafAltimeterGauge extends LeafRenderObjectWidget {
  const _LeafAltimeterGauge({
    this.value = 0,
    this.titleString,
    this.unitString,
    this.frameDesign,
    this.frameVisible,
    this.foregroundType,
    this.foregroundVisible,
    this.backgroundColor,
    this.backgroundVisible,
    this.knobType,
    this.knobStyle,
    this.lcdColor,
    this.lcdVisible,
    this.customLayer,
    this.fontType,
  });

  final double? value;
  final String? titleString;
  final String? unitString;
  final FrameDesignEnum? frameDesign;
  final bool? frameVisible;
  final ForegroundTypeEnum? foregroundType;
  final bool? foregroundVisible;
  final BackgroundColorEnum? backgroundColor;
  final bool? backgroundVisible;
  final KnobTypeEnum? knobType;
  final KnobStyleEnum? knobStyle;
  final LcdColorEnum? lcdColor;
  final bool? lcdVisible;

  final ui.Image? customLayer;
  final FontTypeEnum? fontType;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderAltimeterGauge(
      value: value!,
      titleString: titleString,
      unitString: unitString,
      frameDesign: frameDesign,
      frameVisible: frameVisible,
      foregroundType: foregroundType,
      foregroundVisible: foregroundVisible,
      backgroundColor: backgroundColor,
      backgroundVisible: backgroundVisible,
      knobType: knobType,
      knobStyle: knobStyle,
      lcdColor: lcdColor,
      lcdVisible: lcdVisible,
      customLayer: customLayer,
      fontType: fontType,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderAltimeterGauge renderObject) {
    renderObject
      ..setValue = value!
      ..setTitleString = titleString
      ..setUnitString = unitString
      ..setFrameDesign = frameDesign
      ..setFrameVisible = frameVisible
      ..setForegroundType = foregroundType
      ..setForegroundVisible = foregroundVisible
      ..setBackgroundColor = backgroundColor
      ..setBackgroundVisible = backgroundVisible
      ..setKnobType = knobType
      ..setKnobStyle = knobStyle
      ..setLcdColor = lcdColor
      ..setLcdVisible = lcdVisible
      ..setCustomLayer = customLayer
      ..setFontType = fontType;
  }
}
