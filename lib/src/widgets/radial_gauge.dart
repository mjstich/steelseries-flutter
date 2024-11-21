import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';

import 'radial_gauge_painter.dart';

///
/// Creates a RadialGauge.
///
///```dart
/// ```
class RadialGauge extends StatefulWidget {
  /// Creates a RadialGauge.
  ///
  ///```dart
  /// ```
  const RadialGauge({
    super.key,
    this.start = 0,
    this.end = 100,
    this.value = 0,
    this.titleString,
    this.unitString,
    this.gaugeType = GaugeTypeEnum.TYPE4,
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
    this.lcdColor = LcdColorEnum.STANDARD,
    this.lcdVisible = true,
    this.lcdDecimals = 1,
    this.ledColor = LedColorEnum.RED_LED,
    this.ledVisible = false,
    this.ledOn = false,
    this.userLedColor = LedColorEnum.GREEN_LED,
    this.userLedVisible = false,
    this.userLedOn = false,
    this.fractionalScaleDecimals = 1,
    this.niceScale = true,
    this.threshold,
    this.thresholdVisible = true,
    this.minMeasuredValue,
    this.minMeasuredValueVisible = false,
    this.maxMeasuredValue,
    this.maxMeasuredValueVisible = false,
    this.trendColors,
    this.trendState = TrendStateEnum.OFF,
    this.trendVisible = false,
    this.labelNumberFormat = LabelNumberFormatEnum.STANDARD,
    this.tickLabelOrientation,
    this.odometerParams,
    this.useOdometer,
    this.section,
    this.area,
    this.customLayer,
    this.fontType = FontTypeEnum.RobotoMono,
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `start` Sets the starting value of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   start : 0.0
  /// ),
  /// ```
  final double? start;

  ///
  /// `end` Sets the ending value of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   end : 0.0
  /// ),
  /// ```
  ///
  final double? end;

  ///
  /// `value` Sets the value of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   value : 0.0
  /// ),
  /// ```
  ///
  final double? value;

  ///
  /// `titleString` Sets the title of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   titleString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? titleString;

  ///
  /// `unitString` Sets the units of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   unitString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? unitString;

  ///
  /// `gaugeType` Sets the gauge type of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   gaugeType : GaugeTypeEnum.TYPE4
  /// ),
  /// ```
  ///
  final GaugeTypeEnum? gaugeType;

  ///
  /// `frameDesign` Sets the frame design of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   frameDesign : FrameDesignEnum.Metal
  /// ),
  /// ```
  ///
  final FrameDesignEnum? frameDesign;

  ///
  /// `frameVisible` Sets the visibility state of the frame of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? frameVisible;

  ///
  /// `foregroundType` Sets the foreground type of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   foregroundType : ForegroundTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final ForegroundTypeEnum? foregroundType;

  ///
  /// `foregroundVisible` Sets the visibility state of the foreground of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   foregroundVisible : true
  /// ),
  /// ```
  ///
  final bool? foregroundVisible;

  ///
  /// `backgroundColor` Sets the background color of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   backgroundColor : BackgroundColorEnum.DARK_GRAY
  /// ),
  /// ```
  ///
  final BackgroundColorEnum? backgroundColor;

  ///
  /// `backgroundVisible` Sets the visibility state of the background of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? backgroundVisible;

  ///
  /// `pointerType` Sets the pointer type of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   pointerType : PointerTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final PointerTypeEnum? pointerType;

  ///
  /// `pointerType` Sets the pointer type of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   pointerColor : ColorEnum.RED
  /// ),
  /// ```
  ///
  final ColorEnum? pointerColor;

  ///
  /// `knobType` Sets the knob type of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   knobType : KnobTypeEnum.STANDARD_KNOB
  /// ),
  /// ```
  ///
  final KnobTypeEnum? knobType;

  ///
  /// `knobType` Sets the knob style of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   knobStyle : KnobStyleEnum.SILVER
  /// ),
  /// ```
  ///
  final KnobStyleEnum? knobStyle;

  ///
  /// `lcdColor` Sets the lcd color of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   lcdColor : LcdColorEnum.STANDARD
  /// ),
  /// ```
  ///
  final LcdColorEnum? lcdColor;

  ///
  /// `lcdVisible` Sets the visibility of the lcd panel of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   lcdVisible : true
  /// ),
  /// ```
  ///
  final bool? lcdVisible;

  ///
  /// `lcdDecimals` Sets the number of decimals points of the lcd panel of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   lcdDecimals : 1
  /// ),
  /// ```
  ///
  final int? lcdDecimals;

  ///
  /// `ledColor` Sets the led color of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   ledColor : LedColorEnum.RED_LED
  /// ),
  /// ```
  ///
  final LedColorEnum? ledColor;

  ///
  /// `ledVisible` Sets the visibility of the led of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   ledVisible : false
  /// ),
  /// ```
  ///
  final bool? ledVisible;

  ///
  /// `ledOn` Sets the on state of the led of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   ledOn : false
  /// ),
  /// ```
  ///
  final bool? ledOn;

  ///
  /// `userLedColor` Sets the user led color of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   userLedColor : LedColorEnum.GREEN_LED
  /// ),
  /// ```
  ///
  final LedColorEnum? userLedColor;

  ///
  /// `userLedVisible` Sets the visibility of the user led of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   userLedVisible : false
  /// ),
  /// ```
  ///
  final bool? userLedVisible;

  ///
  /// `useLedOn` Sets the on state of the user led of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   userLedOn : false
  /// ),
  /// ```
  ///
  final bool? userLedOn;

  ///
  /// `fractionalScaleDecimals`
  ///
  /// ```dart
  /// const RadialGauge(
  ///   fractionalScaleDecimals : 1
  /// ),
  /// ```
  ///
  final int? fractionalScaleDecimals;

  ///
  /// `niceScale` Sets the nice scale state of the frame of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   niceScale : true
  /// ),
  /// ```
  ///
  final bool? niceScale;

  ///
  /// `threshold` Sets value of threshold indicator of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   threshold : 50
  /// ),
  /// ```
  ///
  final double? threshold;

  ///
  /// `thresholdVisible` Sets the visibility state of the frame of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   thresholdVisible : true
  /// ),
  /// ```
  ///
  final bool? thresholdVisible;

  ///
  /// `minMeasuredValue` Sets the min measure value of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   minMeasuredValue : 10
  /// ),
  /// ```
  ///
  final double? minMeasuredValue;

  ///
  /// `minMeasuredValueVisible` Sets the min measure value indicator visibility of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   minMeasuredValueVisible : false
  /// ),
  /// ```
  ///
  final bool? minMeasuredValueVisible;

  ///
  /// `maxMeasuredValue` Sets the min measure value of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   maxMeasuredValue : 90
  /// ),
  /// ```
  ///
  final double? maxMeasuredValue;

  ///
  /// `maxMeasuredValueVisible` Sets the max measure value indicator visibility of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   maxMeasuredValueVisible : false
  /// ),
  /// ```
  ///
  final bool? maxMeasuredValueVisible;

  ///
  /// `trendColors` Sets the colors used for indicating a value trend in the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   trendColors : [LedColorEnum.RED_LED, LedColorEnum.GREEN_LED, LedColorEnum.CYAN_LED]
  /// ),
  /// ```
  ///
  final List<LedColorEnum>? trendColors;

  ///
  /// `trendState` Sets the trend indicator state in the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   trendState : TrendStateEnum.OFF
  /// ),
  /// ```
  ///
  final TrendStateEnum? trendState;

  ///
  /// `trendVisible` Sets the visibility state of the trend indicator of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   trendVisible : false
  /// ),
  /// ```
  ///
  final bool? trendVisible;

  ///
  /// `labelNumberFormat` Sets the format to use when drawing the dial number labels of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   labelNumberFormat : LabelNumberFormatEnum.STANDARD
  /// ),
  /// ```
  ///
  final LabelNumberFormatEnum? labelNumberFormat;

  ///
  /// `tickLabelOrientation` Sets the orientation of the tick labels of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   tickLabelOrientation : TickLabelOrientationEnum.NORMAL
  /// ),
  /// ```
  ///
  final TickLabelOrientationEnum? tickLabelOrientation;

  ///
  /// `odometerParams` Sets the drawing parameters when drawing the odometer of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   odometerParams : OdometerParameters()
  /// ),
  /// ```
  ///
  final OdometerParameters? odometerParams;

  ///
  /// `useOdometer` Sets if the odometer is displayed vs the lcd display of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   useOdometer : false
  /// ),
  /// ```
  ///
  final bool? useOdometer;

  ///
  /// `section`
  ///
  /// ```dart
  /// const RadialGauge(
  ///   section : [Section(30, 50, Colors.deepPurple), Section(85, 100, Colors.purpleAccent)]
  /// ),
  /// ```
  ///
  final List<Section>? section;

  ///
  /// `area` Sets if the odometer is displayed vs the lcd display of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
  ///   area : [Section(30, 40, Colors.lightGreen), Section(40, 50, Colors.yellow.withOpacity(0.5))]
  /// ),
  /// ```
  ///
  final List<Section>? area;

  ///
  /// `customLayer`
  ///
  /// ```dart
  /// const RadialGauge(
  ///   customLayer : [Section(30, 40, Colors.lightGreen), Section(40, 50, Colors.yellow.withOpacity(0.5))]
  /// ),
  /// ```
  ///
  final ui.Image? customLayer;

  ///
  /// `fontType` Sets the font type of the [RadialGauge]
  ///
  /// ```dart
  /// const RadialGauge(
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
  /// const RadialGauge(
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
  /// RadialGauge (
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
  /// RadialGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<RadialGauge> createState() => _RadialGaugeState();
}

class _RadialGaugeState extends State<RadialGauge> with TickerProviderStateMixin {
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
  void didUpdateWidget(covariant RadialGauge oldWidget) {
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
    return _LeafRadialGauge(
      start: widget.start,
      end: widget.end,
      value: value,
      titleString: widget.titleString,
      unitString: widget.unitString,
      gaugeType: widget.gaugeType,
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
      lcdColor: widget.lcdColor,
      lcdVisible: widget.lcdVisible,
      lcdDecimals: widget.lcdDecimals,
      ledColor: widget.ledColor,
      ledVisible: widget.ledVisible,
      ledOn: widget.ledOn,
      userLedColor: widget.userLedColor,
      userLedVisible: widget.userLedVisible,
      userLedOn: widget.userLedOn,
      fractionalScaleDecimals: widget.fractionalScaleDecimals,
      niceScale: widget.niceScale,
      threshold: widget.threshold,
      thresholdVisible: widget.thresholdVisible,
      minMeasuredValue: widget.minMeasuredValue,
      minMeasuredValueVisible: widget.minMeasuredValueVisible,
      maxMeasuredValue: widget.maxMeasuredValue,
      maxMeasuredValueVisible: widget.maxMeasuredValueVisible,
      trendColors: widget.trendColors,
      trendState: widget.trendState,
      trendVisible: widget.trendVisible,
      labelNumberFormat: widget.labelNumberFormat,
      tickLabelOrientation: widget.tickLabelOrientation,
      odometerParams: widget.odometerParams,
      useOdometer: widget.useOdometer,
      section: widget.section,
      area: widget.area,
      customLayer: widget.customLayer,
      fontType: widget.fontType,
    );
  }
}

class _LeafRadialGauge extends LeafRenderObjectWidget {
  const _LeafRadialGauge({
    this.start = 0,
    this.end = 100,
    this.value = 0,
    this.titleString,
    this.unitString,
    this.gaugeType,
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
    this.lcdColor,
    this.lcdVisible,
    this.lcdDecimals,
    this.ledColor,
    this.ledVisible,
    this.ledOn,
    this.userLedColor,
    this.userLedVisible,
    this.userLedOn,
    this.fractionalScaleDecimals,
    this.niceScale,
    this.threshold,
    this.thresholdVisible,
    this.minMeasuredValue,
    this.minMeasuredValueVisible,
    this.maxMeasuredValue,
    this.maxMeasuredValueVisible,
    this.trendColors,
    this.trendState,
    this.trendVisible,
    this.labelNumberFormat,
    this.tickLabelOrientation,
    this.odometerParams,
    this.useOdometer,
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
  final GaugeTypeEnum? gaugeType;
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
  final LcdColorEnum? lcdColor;
  final int? lcdDecimals;
  final bool? lcdVisible;
  final LedColorEnum? ledColor;
  final bool? ledVisible;
  final bool? ledOn;
  final LedColorEnum? userLedColor;
  final bool? userLedVisible;
  final bool? userLedOn;
  final int? fractionalScaleDecimals;
  final bool? niceScale;
  final double? threshold;
  final bool? thresholdVisible;
  final double? minMeasuredValue;
  final bool? minMeasuredValueVisible;
  final double? maxMeasuredValue;
  final bool? maxMeasuredValueVisible;
  final List<LedColorEnum>? trendColors;
  final TrendStateEnum? trendState;
  final bool? trendVisible;
  final LabelNumberFormatEnum? labelNumberFormat;
  final TickLabelOrientationEnum? tickLabelOrientation;
  final OdometerParameters? odometerParams;
  final bool? useOdometer;
  final List<Section>? section;
  final List<Section>? area;
  final ui.Image? customLayer;
  final FontTypeEnum? fontType;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderRadialGauge(
      value: value!,
      start: start!,
      end: end!,
      titleString: titleString,
      unitString: unitString,
      gaugeType: gaugeType,
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
      lcdColor: lcdColor,
      lcdVisible: lcdVisible,
      lcdDecimals: lcdDecimals,
      ledColor: ledColor,
      ledVisible: ledVisible,
      ledOn: ledOn,
      userLedColor: userLedColor,
      userLedVisible: userLedVisible,
      userLedOn: userLedOn,
      fractionalScaleDecimals: fractionalScaleDecimals,
      niceScale: niceScale,
      threshold: threshold,
      thresholdVisible: thresholdVisible,
      minMeasuredValue: minMeasuredValue,
      minMeasuredValueVisible: minMeasuredValueVisible,
      maxMeasuredValue: maxMeasuredValue,
      maxMeasuredValueVisible: maxMeasuredValueVisible,
      trendColors: trendColors,
      trendState: trendState,
      trendVisible: trendVisible,
      labelNumberFormat: labelNumberFormat,
      tickLabelOrientation: tickLabelOrientation,
      odometerParams: odometerParams,
      useOdometer: useOdometer,
      section: section,
      area: area,
      customLayer: customLayer,
      fontType: fontType,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderRadialGauge renderObject) {
    renderObject
      ..setValue = value!
      ..setStart = start!
      ..setEnd = end!
      ..setTitleString = titleString
      ..setUnitString = unitString
      ..setGaugeType = gaugeType
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
      ..setLcdColor = lcdColor
      ..setLcdVisible = lcdVisible
      ..setLcdDecimals = lcdDecimals
      ..setLedColor = ledColor
      ..setLedVisible = ledVisible
      ..setLedOn = ledOn
      ..setUserLedColor = userLedColor
      ..setUserLedVisible = userLedVisible
      ..setUserLedOn = userLedOn
      ..setFractionalScaleDecimals = fractionalScaleDecimals
      ..setNiceScale = niceScale
      ..setThreshold = threshold
      ..setThresholdVisible = thresholdVisible
      ..setMinMeasuredValue = minMeasuredValue
      ..setMinMeasuredValueVisible = minMeasuredValueVisible
      ..setMaxMeasuredValue = maxMeasuredValue
      ..setMaxMeasuredValueVisible = maxMeasuredValueVisible
      ..setTrendColors = trendColors
      ..setTrendState = trendState
      ..setTrendVisible = trendVisible
      ..setLabelNumberFormat = labelNumberFormat
      ..setTickLabelOrientation = tickLabelOrientation
      ..setOdometerParams = odometerParams
      ..setUseOdometer = useOdometer
      ..setSection = section
      ..setArea = area
      ..setCustomLayer = customLayer
      ..setFontType = fontType;
  }
}
