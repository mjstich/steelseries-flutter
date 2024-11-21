import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/tools.dart';

import 'linear_bargraph_gauge_painter.dart';

///
/// Creates a LinearBargraphGauge.
///
///```dart
/// ```
class LinearBargraphGauge extends StatefulWidget {
  /// Creates a LinearBargraphGauge.
  ///
  ///```dart
  /// ```
  const LinearBargraphGauge({
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
    this.valueColor = ColorEnum.RED,
    this.lcdColor = LcdColorEnum.STANDARD,
    this.lcdVisible = true,
    this.lcdDecimals = 1,
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
    this.fontType = FontTypeEnum.RobotoMono,
    this.section,
    this.useSectionColors = false,
    this.valueGradient,
    this.useValueGradient = false,
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `start` Sets the starting value of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   start : 0.0
  /// ),
  /// ```
  final double? start;

  ///
  /// `end` Sets the ending value of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   end : 0.0
  /// ),
  /// ```
  ///
  final double? end;

  ///
  /// `value` Sets the value of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   value : 0.0
  /// ),
  /// ```
  ///
  final double? value;

  ///
  /// `titleString` Sets the title of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   titleString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? titleString;

  ///
  /// `unitString` Sets the units of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   unitString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? unitString;

  ///
  /// `frameDesign` Sets the frame design of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   frameDesign : FrameDesignEnum.Metal
  /// ),
  /// ```
  ///
  final FrameDesignEnum? frameDesign;

  ///
  /// `frameVisible` Sets the visibility state of the frame of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? frameVisible;

  ///
  /// `foregroundType` Sets the foreground type of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   foregroundType : ForegroundTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final ForegroundTypeEnum? foregroundType;

  ///
  /// `foregroundVisible` Sets the visibility state of the foreground of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   foregroundVisible : true
  /// ),
  /// ```
  ///
  final bool? foregroundVisible;

  ///
  /// `backgroundColor` Sets the background color of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   backgroundColor : BackgroundColorEnum.DARK_GRAY
  /// ),
  /// ```
  ///
  final BackgroundColorEnum? backgroundColor;

  ///
  /// `backgroundVisible` Sets the visibility state of the background of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? backgroundVisible;

  ///
  /// `valueColor` Sets the value color of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   valueColor : ColorEnum.RED
  /// ),
  /// ```
  ///
  final ColorEnum? valueColor;

  ///
  /// `lcdColor` Sets the lcd color of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   lcdColor : LcdColorEnum.STANDARD
  /// ),
  /// ```
  ///
  final LcdColorEnum? lcdColor;

  ///
  /// `lcdVisible` Sets the visibility of the lcd panel of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   lcdVisible : true
  /// ),
  /// ```
  ///
  final bool? lcdVisible;

  ///
  /// `lcdDecimals` Sets the number of decimals points of the lcd panel of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   lcdDecimals : 1
  /// ),
  /// ```
  ///
  final int? lcdDecimals;

  ///
  /// `ledColor` Sets the led color of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   ledColor : LedColorEnum.RED_LED
  /// ),
  /// ```
  ///
  final LedColorEnum? ledColor;

  ///
  /// `ledVisible` Sets the visibility of the led of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   ledVisible : false
  /// ),
  /// ```
  ///
  final bool? ledVisible;

  ///
  /// `ledOn` Sets the on state of the led of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   ledOn : false
  /// ),
  /// ```
  ///
  final bool? ledOn;

  ///
  /// `niceScale` Sets the nice scale state of the frame of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   niceScale : true
  /// ),
  /// ```
  ///
  final bool? niceScale;

  ///
  /// `threshold` Sets value of threshold indicator of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   threshold : 50
  /// ),
  /// ```
  ///
  final double? threshold;

  ///
  /// `thresholdVisible` Sets the visibility state of the frame of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   thresholdVisible : true
  /// ),
  /// ```
  ///
  final bool? thresholdVisible;

  ///
  /// `minMeasuredValue` Sets the min measure value of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   minMeasuredValue : 10
  /// ),
  /// ```
  ///
  final double? minMeasuredValue;

  ///
  /// `minMeasuredValueVisible` Sets the min measure value indicator visibility of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   minMeasuredValueVisible : false
  /// ),
  /// ```
  ///
  final bool? minMeasuredValueVisible;

  ///
  /// `maxMeasuredValue` Sets the min measure value of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   maxMeasuredValue : 90
  /// ),
  /// ```
  ///
  final double? maxMeasuredValue;

  ///
  /// `maxMeasuredValueVisible` Sets the max measure value indicator visibility of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   maxMeasuredValueVisible : false
  /// ),
  /// ```
  ///
  final bool? maxMeasuredValueVisible;

  ///
  /// `labelNumberFormat` Sets the format to use when drawing the dial number labels of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   labelNumberFormat : LabelNumberFormatEnum.STANDARD
  /// ),
  /// ```
  ///
  final LabelNumberFormatEnum? labelNumberFormat;

  ///
  /// `section`
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   section : [Section(30, 50, Colors.deepPurple), Section(85, 100, Colors.purpleAccent)]
  /// ),
  /// ```
  ///
  final List<Section>? section;

  ///
  /// `useSectionColors`
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   useSectionColors : false
  /// ),
  /// ```
  ///
  final bool? useSectionColors;

  ///
  /// `useSectionColors`
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   valueGradient : GradientWrapper(50, 3000, LIQUID_GRADIENT_FRACTIONS, LIQUID_COLORS_DARK)
  /// ),
  /// ```
  ///
  final GradientWrapper? valueGradient;

  ///
  /// `useValueGradient`
  ///
  /// ```dart
  /// const LinearBargraphGauge(
  ///   useValueGradient : false
  /// ),
  /// ```
  ///
  final bool? useValueGradient;

  ///
  /// `fontType` Sets the font type of the [LinearBargraphGauge]
  ///
  /// ```dart
  /// const LinearBargraphGauge(
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
  /// const LinearBargraphGauge(
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
  /// LinearBargraphGauge (
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
  /// LinearBargraphGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<LinearBargraphGauge> createState() => _LinearBargraphGaugeState();
}

class _LinearBargraphGaugeState extends State<LinearBargraphGauge>
    with TickerProviderStateMixin {
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
  void didUpdateWidget(covariant LinearBargraphGauge oldWidget) {
    if (oldWidget.enableAnimation != widget.enableAnimation ||
        oldWidget.value != widget.value ||
        oldWidget.start != widget.start ||
        oldWidget.end != widget.end) {
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
      _animation =
          Tween<double>(begin: _from ?? widget.start, end: widget.value)
              .animate(
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
    return _LeafLinearBargraphGauge(
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
      valueColor: widget.valueColor,
      lcdColor: widget.lcdColor,
      lcdVisible: widget.lcdVisible,
      lcdDecimals: widget.lcdDecimals,
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
      useSectionColors: widget.useSectionColors,
      valueGradient: widget.valueGradient,
      useValueGradient: widget.useValueGradient,
      fontType: widget.fontType,
    );
  }
}

class _LeafLinearBargraphGauge extends LeafRenderObjectWidget {
  const _LeafLinearBargraphGauge({
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
    this.valueColor,
    this.lcdColor,
    this.lcdVisible,
    this.lcdDecimals,
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
    this.useSectionColors,
    this.valueGradient,
    this.useValueGradient,
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
  final ColorEnum? valueColor;
  final LcdColorEnum? lcdColor;
  final int? lcdDecimals;
  final bool? lcdVisible;
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
  final bool? useSectionColors;
  final GradientWrapper? valueGradient;
  final bool? useValueGradient;
  final FontTypeEnum? fontType;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderLinearBargraphGauge(
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
      valueColor: valueColor,
      lcdColor: lcdColor,
      lcdVisible: lcdVisible,
      lcdDecimals: lcdDecimals,
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
      useSectionColors: useSectionColors,
      valueGradient: valueGradient,
      useValueGradient: useValueGradient,
      fontType: fontType,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderLinearBargraphGauge renderObject) {
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
      ..setValueColor = valueColor
      ..setLcdColor = lcdColor
      ..setLcdVisible = lcdVisible
      ..setLcdDecimals = lcdDecimals
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
      ..setUseSectionColors = useSectionColors
      ..setValueGradient = valueGradient
      ..setUseValueGradient = useValueGradient
      ..setFontType = fontType;
  }
}
