import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/tools.dart';

import 'radial_bargraph_gauge_painter.dart';

///
/// Creates a RadialBargraphGauge.
///
///```dart
/// ```
class RadialBargraphGauge extends StatefulWidget {
  /// Creates a RadialBargraphGauge.
  ///
  ///```dart
  /// ```
  const RadialBargraphGauge({
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
    this.section,
    this.useSectionColors = false,
    this.valueGradient,
    this.useValueGradient = false,
    this.customLayer,
    this.fontType = FontTypeEnum.RobotoMono,
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `start` Sets the starting value of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   start : 0.0
  /// ),
  /// ```
  final double? start;

  ///
  /// `end` Sets the ending value of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   end : 0.0
  /// ),
  /// ```
  ///
  final double? end;

  ///
  /// `value` Sets the value of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   value : 0.0
  /// ),
  /// ```
  ///
  final double? value;

  ///
  /// `titleString` Sets the title of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   titleString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? titleString;

  ///
  /// `unitString` Sets the units of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   unitString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? unitString;

  ///
  /// `gaugeType` Sets the gauge type of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   gaugeType : GaugeTypeEnum.TYPE4
  /// ),
  /// ```
  ///
  final GaugeTypeEnum? gaugeType;

  ///
  /// `frameDesign` Sets the frame design of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   frameDesign : FrameDesignEnum.Metal
  /// ),
  /// ```
  ///
  final FrameDesignEnum? frameDesign;

  ///
  /// `frameVisible` Sets the visibility state of the frame of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? frameVisible;

  ///
  /// `foregroundType` Sets the foreground type of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   foregroundType : ForegroundTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final ForegroundTypeEnum? foregroundType;

  ///
  /// `foregroundVisible` Sets the visibility state of the foreground of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   foregroundVisible : true
  /// ),
  /// ```
  ///
  final bool? foregroundVisible;

  ///
  /// `backgroundColor` Sets the background color of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   backgroundColor : BackgroundColorEnum.DARK_GRAY
  /// ),
  /// ```
  ///
  final BackgroundColorEnum? backgroundColor;

  ///
  /// `backgroundVisible` Sets the visibility state of the background of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? backgroundVisible;

  ///
  /// `lcdColor` Sets the lcd color of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   lcdColor : LcdColorEnum.STANDARD
  /// ),
  /// ```
  ///
  final LcdColorEnum? lcdColor;

  ///
  /// `lcdVisible` Sets the visibility of the lcd panel of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   lcdVisible : true
  /// ),
  /// ```
  ///
  final bool? lcdVisible;

  ///
  /// `lcdDecimals` Sets the number of decimals points of the lcd panel of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   lcdDecimals : 1
  /// ),
  /// ```
  ///
  final int? lcdDecimals;

  ///
  /// `ledColor` Sets the led color of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   ledColor : LedColorEnum.RED_LED
  /// ),
  /// ```
  ///
  final LedColorEnum? ledColor;

  ///
  /// `ledVisible` Sets the visibility of the led of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   ledVisible : false
  /// ),
  /// ```
  ///
  final bool? ledVisible;

  ///
  /// `ledOn` Sets the on state of the led of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   ledOn : false
  /// ),
  /// ```
  ///
  final bool? ledOn;

  ///
  /// `userLedColor` Sets the user led color of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   userLedColor : LedColorEnum.GREEN_LED
  /// ),
  /// ```
  ///
  final LedColorEnum? userLedColor;

  ///
  /// `userLedVisible` Sets the visibility of the user led of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   userLedVisible : false
  /// ),
  /// ```
  ///
  final bool? userLedVisible;

  ///
  /// `useLedOn` Sets the on state of the user led of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   userLedOn : false
  /// ),
  /// ```
  ///
  final bool? userLedOn;

  ///
  /// `fractionalScaleDecimals`
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   fractionalScaleDecimals : 1
  /// ),
  /// ```
  ///
  final int? fractionalScaleDecimals;

  ///
  /// `niceScale` Sets the nice scale state of the frame of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   niceScale : true
  /// ),
  /// ```
  ///
  final bool? niceScale;

  ///
  /// `threshold` Sets value of threshold indicator of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   threshold : 50
  /// ),
  /// ```
  ///
  final double? threshold;

  ///
  /// `thresholdVisible` Sets the visibility state of the frame of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   thresholdVisible : true
  /// ),
  /// ```
  ///
  final bool? thresholdVisible;

  ///
  /// `minMeasuredValue` Sets the min measure value of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   minMeasuredValue : 10
  /// ),
  /// ```
  ///
  final double? minMeasuredValue;

  ///
  /// `minMeasuredValueVisible` Sets the min measure value indicator visibility of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   minMeasuredValueVisible : false
  /// ),
  /// ```
  ///
  final bool? minMeasuredValueVisible;

  ///
  /// `maxMeasuredValue` Sets the min measure value of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   maxMeasuredValue : 90
  /// ),
  /// ```
  ///
  final double? maxMeasuredValue;

  ///
  /// `maxMeasuredValueVisible` Sets the max measure value indicator visibility of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   maxMeasuredValueVisible : false
  /// ),
  /// ```
  ///
  final bool? maxMeasuredValueVisible;

  ///
  /// `trendColors` Sets the colors used for indicating a value trend in the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   trendColors : [LedColorEnum.RED_LED, LedColorEnum.GREEN_LED, LedColorEnum.CYAN_LED]
  /// ),
  /// ```
  ///
  final List<LedColorEnum>? trendColors;

  ///
  /// `trendState` Sets the trend indicator state in the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   trendState : TrendStateEnum.OFF
  /// ),
  /// ```
  ///
  final TrendStateEnum? trendState;

  ///
  /// `trendVisible` Sets the visibility state of the trend indicator of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   trendVisible : false
  /// ),
  /// ```
  ///
  final bool? trendVisible;

  ///
  /// `labelNumberFormat` Sets the format to use when drawing the dial number labels of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   labelNumberFormat : LabelNumberFormatEnum.STANDARD
  /// ),
  /// ```
  ///
  final LabelNumberFormatEnum? labelNumberFormat;

  ///
  /// `tickLabelOrientation` Sets the orientation of the tick labels of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   tickLabelOrientation : TickLabelOrientationEnum.NORMAL
  /// ),
  /// ```
  ///
  final TickLabelOrientationEnum? tickLabelOrientation;

  ///
  /// `section`
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   section : [Section(30, 50, Colors.deepPurple), Section(85, 100, Colors.purpleAccent)]
  /// ),
  /// ```
  ///
  final List<Section>? section;

  ///
  /// `useSectionColors`
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   useSectionColors : false
  /// ),
  /// ```
  ///
  final bool? useSectionColors;

  ///
  /// `useSectionColors`
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   valueGradient : GradientWrapper(50, 3000, LIQUID_GRADIENT_FRACTIONS, LIQUID_COLORS_DARK)
  /// ),
  /// ```
  ///
  final GradientWrapper? valueGradient;

  ///
  /// `useValueGradient`
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   useValueGradient : false
  /// ),
  /// ```
  ///
  final bool? useValueGradient;

  ///
  /// `customLayer`
  ///
  /// ```dart
  /// const RadialBargraphGauge(
  ///   customLayer : [Section(30, 40, Colors.lightGreen), Section(40, 50, Colors.yellow.withOpacity(0.5))]
  /// ),
  /// ```
  ///
  final ui.Image? customLayer;

  ///
  /// `fontType` Sets the font type of the [RadialBargraphGauge]
  ///
  /// ```dart
  /// const RadialBargraphGauge(
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
  /// const RadialBargraphGauge(
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
  /// RadialBargraphGauge (
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
  /// RadialBargraphGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<RadialBargraphGauge> createState() => _RadialBargraphGaugeState();
}

class _RadialBargraphGaugeState extends State<RadialBargraphGauge> with TickerProviderStateMixin {
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
  void didUpdateWidget(covariant RadialBargraphGauge oldWidget) {
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
    return _LeafRadialBargraphGauge(
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
      section: widget.section,
      useSectionColors: widget.useSectionColors,
      valueGradient: widget.valueGradient,
      useValueGradient: widget.useValueGradient,
      customLayer: widget.customLayer,
      fontType: widget.fontType,
    );
  }
}

class _LeafRadialBargraphGauge extends LeafRenderObjectWidget {
  const _LeafRadialBargraphGauge({
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
    this.section,
    this.useSectionColors,
    this.valueGradient,
    this.useValueGradient,
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
  final List<Section>? section;
  final bool? useSectionColors;
  final GradientWrapper? valueGradient;
  final bool? useValueGradient;
  final ui.Image? customLayer;
  final FontTypeEnum? fontType;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderRadialBargraphGauge(
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
      section: section,
      useSectionColors: useSectionColors,
      valueGradient: valueGradient,
      useValueGradient: useValueGradient,
      customLayer: customLayer,
      fontType: fontType,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderRadialBargraphGauge renderObject) {
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
      ..setSection = section
      ..setUseSectionColors = useSectionColors
      ..setValueGradient = valueGradient
      ..setUseValueGradient = useValueGradient
      ..setCustomLayer = customLayer
      ..setFontType = fontType;
  }
}
