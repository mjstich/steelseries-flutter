import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';

import 'radial_vertical_gauge_painter.dart';

///
/// Creates a RadialVerticalGauge.
///
///```dart
/// ```
class RadialVerticalGauge extends StatefulWidget {
  /// Creates a RadialVerticalGauge.
  ///
  ///```dart
  /// ```
  const RadialVerticalGauge({
    super.key,
    this.start = 0,
    this.end = 100,
    this.value = 0,
    this.titleString,
    this.unitString,
    this.frameDesign = FrameDesignEnum.METAL,
    this.frameVisible = true,
    this.foregroundType = ForegroundTypeEnum.TYPE1,
    this.foregroundVisible = true,
    this.backgroundColor = BackgroundColorEnum.DARK_GRAY,
    this.backgroundVisible = true,
    this.pointerType = PointerTypeEnum.TYPE1,
    this.pointerColor = ColorEnum.RED,
    this.knobType = KnobTypeEnum.STANDARD_KNOB,
    this.knobStyle = KnobStyleEnum.SILVER,
    this.ledColor = LedColorEnum.RED_LED,
    this.ledVisible = false,
    this.ledOn = false,
    this.niceScale = true,
    this.threshold,
    this.thresholdVisible = true,
    this.minMeasuredValue,
    this.minMeasuredValueVisible = false,
    this.maxMeasuredValue,
    this.maxMeasuredValueVisible = false,
    this.labelNumberFormat = LabelNumberFormatEnum.STANDARD,
    this.section,
    this.area,
    this.customLayer,
    this.fontType = FontTypeEnum.RobotoMono,
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `start` Sets the starting value of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   start : 0.0
  /// ),
  /// ```
  final double? start;

  ///
  /// `end` Sets the ending value of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   end : 0.0
  /// ),
  /// ```
  ///
  final double? end;

  ///
  /// `value` Sets the value of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   value : 0.0
  /// ),
  /// ```
  ///
  final double? value;

  ///
  /// `titleString` Sets the title of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   titleString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? titleString;

  ///
  /// `unitString` Sets the units of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   unitString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? unitString;

  ///
  /// `frameDesign` Sets the frame design of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   frameDesign : FrameDesignEnum.Metal
  /// ),
  /// ```
  ///
  final FrameDesignEnum? frameDesign;

  ///
  /// `frameVisible` Sets the visibility state of the frame of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? frameVisible;

  ///
  /// `foregroundType` Sets the foreground type of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   foregroundType : ForegroundTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final ForegroundTypeEnum? foregroundType;

  ///
  /// `foregroundVisible` Sets the visibility state of the foreground of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   foregroundVisible : true
  /// ),
  /// ```
  ///
  final bool? foregroundVisible;

  ///
  /// `backgroundColor` Sets the background color of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   backgroundColor : BackgroundColorEnum.DARK_GRAY
  /// ),
  /// ```
  ///
  final BackgroundColorEnum? backgroundColor;

  ///
  /// `backgroundVisible` Sets the visibility state of the background of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? backgroundVisible;

  ///
  /// `pointerType` Sets the pointer type of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   pointerType : PointerTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final PointerTypeEnum? pointerType;

  ///
  /// `pointerType` Sets the pointer type of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   pointerColor : ColorEnum.RED
  /// ),
  /// ```
  ///
  final ColorEnum? pointerColor;

  ///
  /// `knobType` Sets the knob type of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   knobType : KnobTypeEnum.STANDARD_KNOB
  /// ),
  /// ```
  ///
  final KnobTypeEnum? knobType;

  ///
  /// `knobType` Sets the knob style of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   knobStyle : KnobStyleEnum.SILVER
  /// ),
  /// ```
  ///
  final KnobStyleEnum? knobStyle;

  ///
  /// `ledColor` Sets the led color of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   ledColor : LedColorEnum.RED_LED
  /// ),
  /// ```
  ///
  final LedColorEnum? ledColor;

  ///
  /// `ledVisible` Sets the visibility of the led of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   ledVisible : false
  /// ),
  /// ```
  ///
  final bool? ledVisible;

  ///
  /// `ledOn` Sets the on state of the led of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   ledOn : false
  /// ),
  /// ```
  ///
  final bool? ledOn;

  ///
  /// `niceScale` Sets the nice scale state of the frame of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   niceScale : true
  /// ),
  /// ```
  ///
  final bool? niceScale;

  ///
  /// `threshold` Sets value of threshold indicator of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   threshold : 50
  /// ),
  /// ```
  ///
  final double? threshold;

  ///
  /// `thresholdVisible` Sets the visibility state of the frame of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   thresholdVisible : true
  /// ),
  /// ```
  ///
  final bool? thresholdVisible;

  ///
  /// `minMeasuredValue` Sets the min measure value of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   minMeasuredValue : 10
  /// ),
  /// ```
  ///
  final double? minMeasuredValue;

  ///
  /// `minMeasuredValueVisible` Sets the min measure value indicator visibility of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   minMeasuredValueVisible : false
  /// ),
  /// ```
  ///
  final bool? minMeasuredValueVisible;

  ///
  /// `maxMeasuredValue` Sets the min measure value of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   maxMeasuredValue : 90
  /// ),
  /// ```
  ///
  final double? maxMeasuredValue;

  ///
  /// `maxMeasuredValueVisible` Sets the max measure value indicator visibility of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   maxMeasuredValueVisible : false
  /// ),
  /// ```
  ///
  final bool? maxMeasuredValueVisible;

  ///
  /// `labelNumberFormat` Sets the format to use when drawing the dial number labels of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   labelNumberFormat : LabelNumberFormatEnum.STANDARD
  /// ),
  /// ```
  ///
  final LabelNumberFormatEnum? labelNumberFormat;

  ///
  /// `section`
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   section : [Section(30, 50, Colors.deepPurple), Section(85, 100, Colors.purpleAccent)]
  /// ),
  /// ```
  ///
  final List<Section>? section;

  ///
  /// `area` Sets if the odometer is displayed vs the lcd display of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   area : [Section(30, 40, Colors.lightGreen), Section(40, 50, Colors.yellow.withOpacity(0.5))]
  /// ),
  /// ```
  ///
  final List<Section>? area;

  ///
  /// `customLayer`
  ///
  /// ```dart
  /// const RadialVerticalGauge(
  ///   customLayer : [Section(30, 40, Colors.lightGreen), Section(40, 50, Colors.yellow.withOpacity(0.5))]
  /// ),
  /// ```
  ///
  final ui.Image? customLayer;

  ///
  /// `fontType` Sets the font type of the [RadialVerticalGauge]
  ///
  /// ```dart
  /// const RadialVerticalGauge(
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
  /// const RadialVerticalGauge(
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
  /// RadialVerticalGauge (
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
  /// RadialVerticalGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<RadialVerticalGauge> createState() => _RadialVerticalGaugeState();
}

class _RadialVerticalGaugeState extends State<RadialVerticalGauge> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  double? _from;

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
  void didUpdateWidget(covariant RadialVerticalGauge oldWidget) {
    if (oldWidget.enableAnimation != widget.enableAnimation || oldWidget.value != widget.value || oldWidget.start != widget.start || oldWidget.end != widget.end) {
      if (oldWidget.start != widget.start || oldWidget.end != widget.end) {
        _from = null;
      } else {
        _from = oldWidget.value;
      }
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
      _animation = Tween<double>(begin: _from ?? widget.start, end: widget.value).animate(
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
    return _LeafRadialVerticalGauge(
      start: widget.start,
      end: widget.end,
      value: value,
      titleString: widget.titleString,
      unitString: widget.unitString,
      frameDesign: widget.frameDesign,
      frameVisible: widget.frameVisible,
      foregroundType: widget.foregroundType,
      foregroundVisible: widget.foregroundVisible,
      backgroundColor: widget.backgroundColor,
      backgroundVisible: widget.backgroundVisible,
      pointerType: widget.pointerType,
      pointerColor: widget.pointerColor,
      knobType: widget.knobType,
      knobStyle: widget.knobStyle,
      ledColor: widget.ledColor,
      ledVisible: widget.ledVisible,
      ledOn: widget.ledOn,
      niceScale: widget.niceScale,
      threshold: widget.threshold,
      thresholdVisible: widget.thresholdVisible,
      minMeasuredValue: widget.minMeasuredValue,
      minMeasuredValueVisible: widget.minMeasuredValueVisible,
      maxMeasuredValue: widget.maxMeasuredValue,
      maxMeasuredValueVisible: widget.maxMeasuredValueVisible,
      labelNumberFormat: widget.labelNumberFormat,
      section: widget.section,
      area: widget.area,
      customLayer: widget.customLayer,
      fontType: widget.fontType,
    );
  }
}

class _LeafRadialVerticalGauge extends LeafRenderObjectWidget {
  const _LeafRadialVerticalGauge({
    this.start = 0,
    this.end = 100,
    this.value = 0,
    this.titleString,
    this.unitString,
    this.frameDesign,
    this.frameVisible,
    this.foregroundType,
    this.foregroundVisible,
    this.backgroundColor,
    this.backgroundVisible,
    this.pointerType,
    this.pointerColor,
    this.knobType,
    this.knobStyle,
    this.ledColor,
    this.ledVisible,
    this.ledOn,
    this.niceScale,
    this.threshold,
    this.thresholdVisible,
    this.minMeasuredValue,
    this.minMeasuredValueVisible,
    this.maxMeasuredValue,
    this.maxMeasuredValueVisible,
    this.labelNumberFormat,
    this.section,
    this.area,
    this.customLayer,
    this.fontType,
  });

  final double? start;
  final double? end;
  final double? value;
  final String? titleString;
  final String? unitString;
  final FrameDesignEnum? frameDesign;
  final bool? frameVisible;
  final ForegroundTypeEnum? foregroundType;
  final bool? foregroundVisible;
  final BackgroundColorEnum? backgroundColor;
  final bool? backgroundVisible;
  final PointerTypeEnum? pointerType;
  final KnobTypeEnum? knobType;
  final KnobStyleEnum? knobStyle;
  final ColorEnum? pointerColor;
  final LedColorEnum? ledColor;
  final bool? ledVisible;
  final bool? ledOn;

  final bool? niceScale;
  final double? threshold;
  final bool? thresholdVisible;
  final double? minMeasuredValue;
  final bool? minMeasuredValueVisible;
  final double? maxMeasuredValue;
  final bool? maxMeasuredValueVisible;

  final LabelNumberFormatEnum? labelNumberFormat;

  final List<Section>? section;
  final List<Section>? area;
  final ui.Image? customLayer;
  final FontTypeEnum? fontType;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderRadialVerticalGauge(
      value: value!,
      start: start!,
      end: end!,
      titleString: titleString,
      unitString: unitString,
      frameDesign: frameDesign,
      frameVisible: frameVisible,
      foregroundType: foregroundType,
      foregroundVisible: foregroundVisible,
      backgroundColor: backgroundColor,
      backgroundVisible: backgroundVisible,
      pointerType: pointerType,
      pointerColor: pointerColor,
      knobType: knobType,
      knobStyle: knobStyle,
      ledColor: ledColor,
      ledVisible: ledVisible,
      ledOn: ledOn,
      niceScale: niceScale,
      threshold: threshold,
      thresholdVisible: thresholdVisible,
      minMeasuredValue: minMeasuredValue,
      minMeasuredValueVisible: minMeasuredValueVisible,
      maxMeasuredValue: maxMeasuredValue,
      maxMeasuredValueVisible: maxMeasuredValueVisible,
      labelNumberFormat: labelNumberFormat,
      section: section,
      area: area,
      customLayer: customLayer,
      fontType: fontType,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderRadialVerticalGauge renderObject) {
    renderObject
      ..setValue = value!
      ..setStart = start!
      ..setEnd = end!
      ..setTitleString = titleString
      ..setUnitString = unitString
      ..setFrameDesign = frameDesign
      ..setFrameVisible = frameVisible
      ..setForegroundType = foregroundType
      ..setForegroundVisible = foregroundVisible
      ..setBackgroundColor = backgroundColor
      ..setBackgroundVisible = backgroundVisible
      ..setPointerType = pointerType
      ..setPointerColor = pointerColor
      ..setKnobType = knobType
      ..setKnobStyle = knobStyle
      ..setLedColor = ledColor
      ..setLedVisible = ledVisible
      ..setLedOn = ledOn
      ..setNiceScale = niceScale
      ..setThreshold = threshold
      ..setThresholdVisible = thresholdVisible
      ..setMinMeasuredValue = minMeasuredValue
      ..setMinMeasuredValueVisible = minMeasuredValueVisible
      ..setMaxMeasuredValue = maxMeasuredValue
      ..setMaxMeasuredValueVisible = maxMeasuredValueVisible
      ..setLabelNumberFormat = labelNumberFormat
      ..setSection = section
      ..setArea = area
      ..setCustomLayer = customLayer
      ..setFontType = fontType;
  }
}
