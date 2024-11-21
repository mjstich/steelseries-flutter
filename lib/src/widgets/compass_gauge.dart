import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';

import 'compass_gauge_painter.dart';

///
/// Creates a CompassGauge.
///
///```dart
/// ```
class CompassGauge extends StatefulWidget {
  /// Creates a CompassGauge.
  ///
  ///```dart
  /// ```
  const CompassGauge({
    super.key,
    this.value = 0,
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
    this.pointSymbols,
    this.pointSymbolsVisible = true,
    this.degreeScale = true,
    this.roseVisible = true,
    this.rotateFace = false,
    this.degreeFontColor = Colors.white,
    this.customLayer,
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `value` Sets the value of the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   value : 0.0
  /// ),
  /// ```
  ///
  final double? value;

  ///
  /// `frameDesign` Sets the frame design of the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   frameDesign : FrameDesignEnum.Metal
  /// ),
  /// ```
  ///
  final FrameDesignEnum? frameDesign;

  ///
  /// `frameVisible` Sets the visibility state of the frame of the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? frameVisible;

  ///
  /// `foregroundType` Sets the foreground type of the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   foregroundType : ForegroundTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final ForegroundTypeEnum? foregroundType;

  ///
  /// `foregroundVisible` Sets the visibility state of the foreground of the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   foregroundVisible : true
  /// ),
  /// ```
  ///
  final bool? foregroundVisible;

  ///
  /// `backgroundColor` Sets the background color of the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   backgroundColor : BackgroundColorEnum.DARK_GRAY
  /// ),
  /// ```
  ///
  final BackgroundColorEnum? backgroundColor;

  ///
  /// `backgroundVisible` Sets the visibility state of the background of the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? backgroundVisible;

  ///
  /// `pointerType` Sets the pointer type of the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   pointerType : PointerTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final PointerTypeEnum? pointerType;

  ///
  /// `pointerType` Sets the pointer type of the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   pointerColor : ColorEnum.RED
  /// ),
  /// ```
  ///
  final ColorEnum? pointerColor;

  ///
  /// `knobType` Sets the knob type of the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   knobType : KnobTypeEnum.STANDARD_KNOB
  /// ),
  /// ```
  ///
  final KnobTypeEnum? knobType;

  ///
  /// `knobType` Sets the knob style of the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   knobStyle : KnobStyleEnum.SILVER
  /// ),
  /// ```
  ///
  final KnobStyleEnum? knobStyle;

  ///
  /// `pointSymbols` compass points of the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   pointSymbols : ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW']
  /// ),
  /// ```
  ///
  final List<String>? pointSymbols;

  ///
  /// `pointSymbolsVisible` indicates if points symbols are visible on the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   pointSymbolsVisible : true
  /// ),
  /// ```
  ///
  final bool? pointSymbolsVisible;

  ///
  /// `degreeScale` indicates if degree scale is used on the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   degreeScale : true
  /// ),
  /// ```
  ///
  final bool? degreeScale;

  ///
  /// `roseVisible` indicates if compass rose is visible on the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   roseVisible : true
  /// ),
  /// ```
  ///
  final bool? roseVisible;

  ///
  /// `rotateFace` indicates if compass is rotated to degree value on the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   rotateFace : false
  /// ),
  /// ```
  ///
  final bool? rotateFace;

  ///
  /// `degreeFontColor` color used when painting degree values on the [CompassGauge]
  ///
  /// ```dart
  /// const CompassGauge(
  ///   degreeFontColor : Colors.white
  /// ),
  /// ```
  ///
  final Color? degreeFontColor;

  ///
  /// `customLayer`
  ///
  /// ```dart
  /// const CompassGauge(
  ///   customLayer : [Section(30, 40, Colors.lightGreen), Section(40, 50, Colors.yellow.withOpacity(0.5))]
  /// ),
  /// ```
  ///
  final ui.Image? customLayer;

  ///
  /// `enableAnimation` will enable animations.
  ///  It's default to true.
  ///
  /// ```
  /// const CompassGauge(
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
  /// CompassGauge (
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
  /// CompassGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<CompassGauge> createState() => _CompassGaugeState();
}

class _CompassGaugeState extends State<CompassGauge> with TickerProviderStateMixin {
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
  void didUpdateWidget(covariant CompassGauge oldWidget) {
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
    return _LeafCompassGauge(
      value: value,
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
      pointSymbols: widget.pointSymbols,
      pointSymbolsVisible: widget.pointSymbolsVisible,
      degreeScale: widget.degreeScale,
      roseVisible: widget.roseVisible,
      rotateFace: widget.rotateFace,
      degreeFontColor: widget.degreeFontColor,
      customLayer: widget.customLayer,
    );
  }
}

class _LeafCompassGauge extends LeafRenderObjectWidget {
  const _LeafCompassGauge({
    this.value = 0,
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
    this.pointSymbols,
    this.pointSymbolsVisible,
    this.degreeScale,
    this.roseVisible,
    this.rotateFace,
    this.degreeFontColor,
    this.customLayer,
  });

  final double? value;
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
  final List<String>? pointSymbols;
  final bool? pointSymbolsVisible;
  final bool? degreeScale;
  final bool? roseVisible;
  final bool? rotateFace;
  final Color? degreeFontColor;
  final ui.Image? customLayer;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderCompassGauge(
      value: value!,
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
      pointSymbols: pointSymbols,
      pointSymbolsVisible: pointSymbolsVisible,
      degreeScale: degreeScale,
      roseVisible: roseVisible,
      rotateFace: rotateFace,
      degreeFontColor: degreeFontColor,
      customLayer: customLayer,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderCompassGauge renderObject) {
    renderObject
      ..setValue = value!
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
      ..setPointSymbols = pointSymbols
      ..setPointSymbolsVisible = pointSymbolsVisible
      ..setDegreeScale = degreeScale
      ..setRoseVisible = roseVisible
      ..setRotateFace = rotateFace
      ..setDegreeFontColor = degreeFontColor
      ..setCustomLayer = customLayer;
  }
}
