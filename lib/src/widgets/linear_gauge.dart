import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';

import 'linear_gauge_painter.dart';

///
/// Creates a LinearGauge.
///
///```dart
/// ```
class LinearGauge extends StatefulWidget {
  /// Creates a LinearGauge.
  ///
  ///```dart
  /// ```
  const LinearGauge({
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
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `start` Sets the starting value of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   start : 0.0
  /// ),
  /// ```
  final double? start;

  ///
  /// `end` Sets the ending value of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   end : 0.0
  /// ),
  /// ```
  ///
  final double? end;

  ///
  /// `value` Sets the value of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   value : 0.0
  /// ),
  /// ```
  ///
  final double? value;

  ///
  /// `titleString` Sets the title of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   titleString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? titleString;

  ///
  /// `unitString` Sets the units of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   unitString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? unitString;

  ///
  /// `frameDesign` Sets the frame design of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   frameDesign : FrameDesignEnum.Metal
  /// ),
  /// ```
  ///
  final FrameDesignEnum? frameDesign;

  ///
  /// `frameVisible` Sets the visibility state of the frame of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? frameVisible;

  ///
  /// `foregroundType` Sets the foreground type of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   foregroundType : ForegroundTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final ForegroundTypeEnum? foregroundType;

  ///
  /// `foregroundVisible` Sets the visibility state of the foreground of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   foregroundVisible : true
  /// ),
  /// ```
  ///
  final bool? foregroundVisible;

  ///
  /// `backgroundColor` Sets the background color of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   backgroundColor : BackgroundColorEnum.DARK_GRAY
  /// ),
  /// ```
  ///
  final BackgroundColorEnum? backgroundColor;

  ///
  /// `backgroundVisible` Sets the visibility state of the background of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? backgroundVisible;

  ///
  /// `valueColor` Sets the value color of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   valueColor : ColorEnum.RED
  /// ),
  /// ```
  ///
  final ColorEnum? valueColor;

  ///
  /// `lcdColor` Sets the lcd color of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   lcdColor : LcdColorEnum.STANDARD
  /// ),
  /// ```
  ///
  final LcdColorEnum? lcdColor;

  ///
  /// `lcdVisible` Sets the visibility of the lcd panel of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   lcdVisible : true
  /// ),
  /// ```
  ///
  final bool? lcdVisible;

  ///
  /// `lcdDecimals` Sets the number of decimals points of the lcd panel of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   lcdDecimals : 1
  /// ),
  /// ```
  ///
  final int? lcdDecimals;

  ///
  /// `ledColor` Sets the led color of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   ledColor : LedColorEnum.RED_LED
  /// ),
  /// ```
  ///
  final LedColorEnum? ledColor;

  ///
  /// `ledVisible` Sets the visibility of the led of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   ledVisible : false
  /// ),
  /// ```
  ///
  final bool? ledVisible;

  ///
  /// `ledOn` Sets the on state of the led of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   ledOn : false
  /// ),
  /// ```
  ///
  final bool? ledOn;

  ///
  /// `niceScale` Sets the nice scale state of the frame of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   niceScale : true
  /// ),
  /// ```
  ///
  final bool? niceScale;

  ///
  /// `threshold` Sets value of threshold indicator of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   threshold : 50
  /// ),
  /// ```
  ///
  final double? threshold;

  ///
  /// `thresholdVisible` Sets the visibility state of the frame of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   thresholdVisible : true
  /// ),
  /// ```
  ///
  final bool? thresholdVisible;

  ///
  /// `minMeasuredValue` Sets the min measure value of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   minMeasuredValue : 10
  /// ),
  /// ```
  ///
  final double? minMeasuredValue;

  ///
  /// `minMeasuredValueVisible` Sets the min measure value indicator visibility of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   minMeasuredValueVisible : false
  /// ),
  /// ```
  ///
  final bool? minMeasuredValueVisible;

  ///
  /// `maxMeasuredValue` Sets the min measure value of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   maxMeasuredValue : 90
  /// ),
  /// ```
  ///
  final double? maxMeasuredValue;

  ///
  /// `maxMeasuredValueVisible` Sets the max measure value indicator visibility of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   maxMeasuredValueVisible : false
  /// ),
  /// ```
  ///
  final bool? maxMeasuredValueVisible;

  ///
  /// `labelNumberFormat` Sets the format to use when drawing the dial number labels of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
  ///   labelNumberFormat : LabelNumberFormatEnum.STANDARD
  /// ),
  /// ```
  ///
  final LabelNumberFormatEnum? labelNumberFormat;

  ///
  /// `fontType` Sets the font type of the [LinearGauge]
  ///
  /// ```dart
  /// const LinearGauge(
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
  /// const LinearGauge(
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
  /// LinearGauge (
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
  /// LinearGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<LinearGauge> createState() => _LinearGaugeState();
}

class _LinearGaugeState extends State<LinearGauge> with TickerProviderStateMixin {
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
  void didUpdateWidget(covariant LinearGauge oldWidget) {
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
    return _LeafLinearGauge(
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
      fontType: widget.fontType,
    );
  }
}

class _LeafLinearGauge extends LeafRenderObjectWidget {
  const _LeafLinearGauge({
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
  final FontTypeEnum? fontType;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderLinearGauge(
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
      fontType: fontType,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderLinearGauge renderObject) {
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
      ..setFontType = fontType;
  }
}
