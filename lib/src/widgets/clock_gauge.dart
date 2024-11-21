import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';

import 'clock_gauge_painter.dart';

///
/// Creates a ClockGauge.
///
///```dart
/// ```
class ClockGauge extends StatefulWidget {
  /// Creates a ClockGauge.
  ///
  ///```dart
  /// ```
  const ClockGauge({
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
    this.secondPointerVisible = true,
    this.customLayer,
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `value` Sets the time of the clock.  value is the number of seconds since the start of the day [ClockGauge]
  ///
  /// ```dart
  /// const ClockGauge(
  ///   value : 0.0
  /// ),
  /// ```
  ///
  final int? value;

  ///
  /// `frameDesign` Sets the frame design of the [ClockGauge]
  ///
  /// ```dart
  /// const ClockGauge(
  ///   frameDesign : FrameDesignEnum.Metal
  /// ),
  /// ```
  ///
  final FrameDesignEnum? frameDesign;

  ///
  /// `frameVisible` Sets the visibility state of the frame of the [ClockGauge]
  ///
  /// ```dart
  /// const ClockGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? frameVisible;

  ///
  /// `foregroundType` Sets the foreground type of the [ClockGauge]
  ///
  /// ```dart
  /// const ClockGauge(
  ///   foregroundType : ForegroundTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final ForegroundTypeEnum? foregroundType;

  ///
  /// `foregroundVisible` Sets the visibility state of the foreground of the [ClockGauge]
  ///
  /// ```dart
  /// const ClockGauge(
  ///   foregroundVisible : true
  /// ),
  /// ```
  ///
  final bool? foregroundVisible;

  ///
  /// `backgroundColor` Sets the background color of the [ClockGauge]
  ///
  /// ```dart
  /// const ClockGauge(
  ///   backgroundColor : BackgroundColorEnum.DARK_GRAY
  /// ),
  /// ```
  ///
  final BackgroundColorEnum? backgroundColor;

  ///
  /// `backgroundVisible` Sets the visibility state of the background of the [ClockGauge]
  ///
  /// ```dart
  /// const ClockGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? backgroundVisible;

  ///
  /// `pointerType` Sets the pointer type of the [ClockGauge]
  ///
  /// ```dart
  /// const ClockGauge(
  ///   pointerType : PointerTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final PointerTypeEnum? pointerType;

  ///
  /// `pointerType` Sets the pointer type of the [ClockGauge]
  ///
  /// ```dart
  /// const ClockGauge(
  ///   pointerColor : ColorEnum.RED
  /// ),
  /// ```
  ///
  final ColorEnum? pointerColor;

  ///
  /// `secondPointerVisible` Sets the visibility state of the second pointer of the [ClockGauge]
  ///
  /// ```dart
  /// const ClockGauge(
  ///   secondPointerVisible : true
  /// ),
  /// ```
  ///
  final bool? secondPointerVisible;

  ///
  /// `customLayer`
  ///
  /// ```dart
  /// const ClockGauge(
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
  /// const ClockGauge(
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
  /// ClockGauge (
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
  /// ClockGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<ClockGauge> createState() => _ClockGaugeState();
}

class _ClockGaugeState extends State<ClockGauge> with TickerProviderStateMixin {
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
  void didUpdateWidget(covariant ClockGauge oldWidget) {
    if (oldWidget.enableAnimation != widget.enableAnimation || oldWidget.value != widget.value) {
      _from = oldWidget.value!.toDouble();

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
      _animation = Tween<double>(begin: _from, end: widget.value!.toDouble()).animate(
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
      return _getChild(context, widget.value!.toDouble());
    }
  }

  Widget _getChild(BuildContext context, double value) {
    return _LeafClockGauge(
      value: value,
      frameDesign: widget.frameDesign,
      frameVisible: widget.frameVisible,
      foregroundType: widget.foregroundType,
      foregroundVisible: widget.foregroundVisible,
      backgroundColor: widget.backgroundColor,
      backgroundVisible: widget.backgroundVisible,
      pointerType: widget.pointerType,
      pointerColor: widget.pointerColor,
      secondPointerVisible: widget.secondPointerVisible,
      customLayer: widget.customLayer,
    );
  }
}

class _LeafClockGauge extends LeafRenderObjectWidget {
  const _LeafClockGauge({
    this.value,
    this.frameDesign,
    this.frameVisible,
    this.foregroundType,
    this.foregroundVisible,
    this.backgroundColor,
    this.backgroundVisible,
    this.pointerType,
    this.pointerColor,
    this.secondPointerVisible,
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
  final ColorEnum? pointerColor;
  final bool? secondPointerVisible;
  final ui.Image? customLayer;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderClockGauge(
      value: value!,
      frameDesign: frameDesign,
      frameVisible: frameVisible,
      foregroundType: foregroundType,
      foregroundVisible: foregroundVisible,
      backgroundColor: backgroundColor,
      backgroundVisible: backgroundVisible,
      pointerType: pointerType,
      pointerColor: pointerColor,
      secondPointerVisible: secondPointerVisible,
      customLayer: customLayer,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderClockGauge renderObject) {
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
      ..setSecondPointerVisible = secondPointerVisible
      ..setCustomLayer = customLayer;
  }
}
