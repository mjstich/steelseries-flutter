import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';

import 'wind_direction_gauge_painter.dart';

///
/// Creates a WindDirectionGauge.
///
///```dart
/// ```
class WindDirectionGauge extends StatefulWidget {
  /// Creates a WindDirectionGauge.
  ///
  ///```dart
  /// ```
  const WindDirectionGauge({
    super.key,
    this.value = 0,
    this.valueAverage = 0,
    this.frameDesign = FrameDesignEnum.METAL,
    this.frameVisible = true,
    this.foregroundType = ForegroundTypeEnum.TYPE1,
    this.foregroundVisible = true,
    this.backgroundColor = BackgroundColorEnum.DARK_GRAY,
    this.backgroundVisible = true,
    this.pointerType = PointerTypeEnum.TYPE1,
    this.pointerTypeAverage = PointerTypeEnum.TYPE8,
    this.pointerColor = ColorEnum.RED,
    this.pointerColorAverage = ColorEnum.BLUE,
    this.knobType = KnobTypeEnum.STANDARD_KNOB,
    this.knobStyle = KnobStyleEnum.SILVER,
    this.lcdColor = LcdColorEnum.STANDARD,
    this.lcdVisible = true,
    this.pointSymbols = const ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'],
    this.pointSymbolsVisible = true,
    this.degreeScale = true,
    this.degreeScaleHalf = false,
    this.roseVisible = true,
    this.lcdTitleStrings = const ['Latest', 'Average'],
    this.titleString,
    this.useColorLabels = false,
    this.section,
    this.area,
    this.customLayer,
    this.fontType = FontTypeEnum.RobotoMono,
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `value` Sets the value of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   value : 0.0
  /// ),
  /// ```
  ///
  final double? value;

  ///
  /// `valueAverage` Sets the average value of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   valueAverage : 0.0
  /// ),
  /// ```
  ///
  final double? valueAverage;

  ///
  /// `frameDesign` Sets the frame design of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   frameDesign : FrameDesignEnum.Metal
  /// ),
  /// ```
  ///
  final FrameDesignEnum? frameDesign;

  ///
  /// `frameVisible` Sets the visibility state of the frame of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? frameVisible;

  ///
  /// `foregroundType` Sets the foreground type of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   foregroundType : ForegroundTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final ForegroundTypeEnum? foregroundType;

  ///
  /// `foregroundVisible` Sets the visibility state of the foreground of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   foregroundVisible : true
  /// ),
  /// ```
  ///
  final bool? foregroundVisible;

  ///
  /// `backgroundColor` Sets the background color of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   backgroundColor : BackgroundColorEnum.DARK_GRAY
  /// ),
  /// ```
  ///
  final BackgroundColorEnum? backgroundColor;

  ///
  /// `backgroundVisible` Sets the visibility state of the background of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? backgroundVisible;

  ///
  /// `pointerType` Sets the pointer type of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   pointerType : PointerTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final PointerTypeEnum? pointerType;

  ///
  /// `pointerTypeAverage` Sets the pointer average type of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   pointerTypeAverage : PointerTypeEnum.TYPE8
  /// ),
  /// ```
  ///
  final PointerTypeEnum? pointerTypeAverage;

  ///
  /// `pointerColor` Sets the pointer color of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   pointerColor : ColorEnum.RED
  /// ),
  /// ```
  ///
  final ColorEnum? pointerColor;

  ///
  /// `pointerColorAverage` Sets the pointer color average of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   pointerColorAverage : ColorEnum.BLUE
  /// ),
  /// ```
  ///
  final ColorEnum? pointerColorAverage;

  ///
  /// `knobType` Sets the knob type of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   knobType : KnobTypeEnum.STANDARD_KNOB
  /// ),
  /// ```
  ///
  final KnobTypeEnum? knobType;

  ///
  /// `knobType` Sets the knob style of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   knobStyle : KnobStyleEnum.SILVER
  /// ),
  /// ```
  ///
  final KnobStyleEnum? knobStyle;

  ///
  /// `lcdColor` Sets the lcd color of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   lcdColor : LcdColorEnum.STANDARD
  /// ),
  /// ```
  ///
  final LcdColorEnum? lcdColor;

  ///
  /// `lcdVisible` Sets the visibility of the lcd panel of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   lcdVisible : true
  /// ),
  /// ```
  ///
  final bool? lcdVisible;

  ///
  /// `pointSymbols` compass points of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   pointSymbols : ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']
  /// ),
  /// ```
  ///
  final List<String>? pointSymbols;

  ///
  /// `pointSymbolsVisible` indicates if points symbols are visible on the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   pointSymbolsVisible : true
  /// ),
  /// ```
  ///
  final bool? pointSymbolsVisible;

  ///
  /// `degreeScale` indicates if degree scale is used on the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   degreeScale : true
  /// ),
  /// ```
  ///
  final bool? degreeScale;

  ///
  /// `degreeScaleHalf` indicates if degree scale half is used on the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   degreeScaleHalf : true
  /// ),
  /// ```
  ///
  final bool? degreeScaleHalf;

  ///
  /// `roseVisible` indicates if compass rose is visible on the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   roseVisible : true
  /// ),
  /// ```
  ///
  final bool? roseVisible;

  ///
  /// `titleString` Sets the title of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   titleString : 'Gauge'
  /// ),
  /// ```
  ///
  final String? titleString;

  ///
  /// `lcdTitleStrings` Sets the title of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   lcdTitleStrings : const ['Latest', 'Average']
  /// ),
  /// ```
  ///
  final List<String>? lcdTitleStrings;

  ///
  /// `useColorLabels` Sets the visibility state of the lables of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   useColorLabels : true
  /// ),
  /// ```
  ///
  final bool? useColorLabels;

  ///
  /// `section`
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   section : [Section(30, 50, Colors.deepPurple), Section(85, 100, Colors.purpleAccent)]
  /// ),
  /// ```
  ///
  final List<Section>? section;

  ///
  /// `area` Sets if the odometer is displayed vs the lcd display of the [RadialGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   area : [Section(30, 40, Colors.lightGreen), Section(40, 50, Colors.yellow.withOpacity(0.5))]
  /// ),
  /// ```
  ///
  final List<Section>? area;

  ///
  /// `customLayer`
  ///
  /// ```dart
  /// const WindDirectionGauge(
  ///   customLayer : [Section(30, 40, Colors.lightGreen), Section(40, 50, Colors.yellow.withOpacity(0.5))]
  /// ),
  /// ```
  ///
  final ui.Image? customLayer;

  ///
  /// `fontType` Sets the font type of the [WindDirectionGauge]
  ///
  /// ```dart
  /// const WindDirectionGauge(
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
  /// const WindDirectionGauge(
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
  /// WindDirectionGauge (
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
  /// WindDirectionGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<WindDirectionGauge> createState() => _WindDirectionGaugeState();
}

class _WindDirectionGaugeState extends State<WindDirectionGauge>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _valueAnimation;
  Animation<double>? _valueAverageAnimation;
  double _valueFrom = 0;
  double _valueAverageFrom = 0;

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
  void didUpdateWidget(covariant WindDirectionGauge oldWidget) {
    if (oldWidget.enableAnimation != widget.enableAnimation ||
        oldWidget.value != widget.value ||
        oldWidget.valueAverage != widget.valueAverage) {
      _valueFrom = oldWidget.value!;
      _valueAverageFrom = oldWidget.valueAverage!;

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
      _valueAnimation =
          Tween<double>(begin: _valueFrom, end: widget.value).animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Interval(
            0.05,
            1.0,
            curve: widget.animationType,
          ),
        ),
      );
      _valueAverageAnimation =
          Tween<double>(begin: _valueAverageFrom, end: widget.valueAverage)
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
          return _getChild(
              context, _valueAnimation!.value, _valueAverageAnimation!.value);
        },
      );
    } else {
      return _getChild(context, widget.value!, widget.valueAverage!);
    }
  }

  Widget _getChild(BuildContext context, double value, double valueAverage) {
    return _LeafWindDirectionGauge(
      value: value,
      valueAverage: valueAverage,
      frameDesign: widget.frameDesign,
      frameVisible: widget.frameVisible,
      foregroundType: widget.foregroundType,
      foregroundVisible: widget.foregroundVisible,
      backgroundColor: widget.backgroundColor,
      backgroundVisible: widget.backgroundVisible,
      pointerType: widget.pointerType,
      pointerTypeAverage: widget.pointerTypeAverage,
      pointerColor: widget.pointerColor,
      pointerColorAverage: widget.pointerColorAverage,
      knobType: widget.knobType,
      knobStyle: widget.knobStyle,
      lcdColor: widget.lcdColor,
      lcdVisible: widget.lcdVisible,
      pointSymbols: widget.pointSymbols,
      pointSymbolsVisible: widget.pointSymbolsVisible,
      degreeScale: widget.degreeScale,
      degreeScaleHalf: widget.degreeScaleHalf,
      roseVisible: widget.roseVisible,
      titleString: widget.titleString,
      lcdTitleStrings: widget.lcdTitleStrings,
      useColorLabels: widget.useColorLabels,
      section: widget.section,
      area: widget.area,
      customLayer: widget.customLayer,
      fontType: widget.fontType,
    );
  }
}

class _LeafWindDirectionGauge extends LeafRenderObjectWidget {
  const _LeafWindDirectionGauge({
    this.value = 0,
    this.valueAverage = 0,
    this.frameDesign,
    this.frameVisible,
    this.foregroundType,
    this.foregroundVisible,
    this.backgroundColor,
    this.backgroundVisible,
    this.pointerType,
    this.pointerTypeAverage,
    this.pointerColor,
    this.pointerColorAverage,
    this.knobType,
    this.knobStyle,
    this.lcdColor,
    this.lcdVisible,
    this.pointSymbols,
    this.pointSymbolsVisible,
    this.degreeScale,
    this.degreeScaleHalf,
    this.roseVisible,
    this.titleString,
    this.lcdTitleStrings,
    this.useColorLabels,
    this.section,
    this.area,
    this.customLayer,
    this.fontType,
  });

  final double? value;
  final double? valueAverage;
  final FrameDesignEnum? frameDesign;
  final bool? frameVisible;
  final ForegroundTypeEnum? foregroundType;
  final bool? foregroundVisible;
  final BackgroundColorEnum? backgroundColor;
  final bool? backgroundVisible;
  final PointerTypeEnum? pointerType;
  final PointerTypeEnum? pointerTypeAverage;
  final KnobTypeEnum? knobType;
  final KnobStyleEnum? knobStyle;
  final LcdColorEnum? lcdColor;
  final bool? lcdVisible;
  final ColorEnum? pointerColor;
  final ColorEnum? pointerColorAverage;
  final List<String>? pointSymbols;
  final bool? pointSymbolsVisible;
  final bool? degreeScale;
  final bool? degreeScaleHalf;
  final bool? roseVisible;
  final String? titleString;
  final List<String>? lcdTitleStrings;
  final bool? useColorLabels;
  final List<Section>? section;
  final List<Section>? area;
  final ui.Image? customLayer;
  final FontTypeEnum? fontType;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderWindDirectionGauge(
      value: value!,
      valueAverage: valueAverage!,
      frameDesign: frameDesign,
      frameVisible: frameVisible,
      foregroundType: foregroundType,
      foregroundVisible: foregroundVisible,
      backgroundColor: backgroundColor,
      backgroundVisible: backgroundVisible,
      pointerType: pointerType,
      pointerTypeAverage: pointerTypeAverage,
      pointerColor: pointerColor,
      pointerColorAverage: pointerColorAverage,
      knobType: knobType,
      knobStyle: knobStyle,
      lcdColor: lcdColor,
      lcdVisible: lcdVisible,
      pointSymbols: pointSymbols,
      pointSymbolsVisible: pointSymbolsVisible,
      degreeScale: degreeScale,
      degreeScaleHalf: degreeScaleHalf,
      roseVisible: roseVisible,
      titleString: titleString,
      lcdTitleStrings: lcdTitleStrings,
      useColorLabels: useColorLabels,
      section: section,
      area: area,
      customLayer: customLayer,
      fontType: fontType,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderWindDirectionGauge renderObject) {
    renderObject
      ..setValue = value!
      ..setValueAverage = valueAverage!
      ..setFrameDesign = frameDesign
      ..setFrameVisible = frameVisible
      ..setForegroundType = foregroundType
      ..setForegroundVisible = foregroundVisible
      ..setBackgroundColor = backgroundColor
      ..setBackgroundVisible = backgroundVisible
      ..setPointerType = pointerType
      ..setPointerTypeAverage = pointerTypeAverage
      ..setPointerColor = pointerColor
      ..setPointerColorAverage = pointerColorAverage
      ..setKnobType = knobType
      ..setKnobStyle = knobStyle
      ..setLcdColor = lcdColor
      ..setLcdVisible = lcdVisible
      ..setPointSymbols = pointSymbols
      ..setPointSymbolsVisible = pointSymbolsVisible
      ..setDegreeScale = degreeScale
      ..setDegreeScaleHalf = degreeScaleHalf
      ..setRoseVisible = roseVisible
      ..setTitleString = titleString
      ..setLcdTitleStrings = lcdTitleStrings
      ..setUseColorLabels = useColorLabels
      ..setSection = section
      ..setArea = area
      ..setCustomLayer = customLayer
      ..setFontType = fontType;
  }
}
