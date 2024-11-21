import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';

import 'stop_watch_gauge_painter.dart';

///
/// Creates a StopWatchGauge.
///
///```dart
/// ```
class StopwatchGauge extends StatefulWidget {
  /// Creates a StopWatchGauge.
  ///
  ///```dart
  /// ```
  const StopwatchGauge({
    super.key,
    this.seconds = 0,
    this.frameDesign = FrameDesignEnum.METAL,
    this.frameVisible = true,
    this.foregroundType = ForegroundTypeEnum.TYPE1,
    this.foregroundVisible = true,
    this.backgroundColor = BackgroundColorEnum.DARK_GRAY,
    this.backgroundVisible = true,
    this.pointerColor = ColorEnum.RED,
    this.customLayer,
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `seconds` Sets the seconds of the [StopwatchGauge]
  ///
  /// ```dart
  /// const StopWatchGauge(
  ///   seconds : 0.0
  /// ),
  /// ```
  ///
  final double? seconds;

  ///
  /// `frameDesign` Sets the frame design of the [StopwatchGauge]
  ///
  /// ```dart
  /// const StopWatchGauge(
  ///   frameDesign : FrameDesignEnum.Metal
  /// ),
  /// ```
  ///
  final FrameDesignEnum? frameDesign;

  ///
  /// `frameVisible` Sets the visibility state of the frame of the [StopwatchGauge]
  ///
  /// ```dart
  /// const StopWatchGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? frameVisible;

  ///
  /// `foregroundType` Sets the foreground type of the [StopwatchGauge]
  ///
  /// ```dart
  /// const StopWatchGauge(
  ///   foregroundType : ForegroundTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final ForegroundTypeEnum? foregroundType;

  ///
  /// `foregroundVisible` Sets the visibility state of the foreground of the [StopwatchGauge]
  ///
  /// ```dart
  /// const StopWatchGauge(
  ///   foregroundVisible : true
  /// ),
  /// ```
  ///
  final bool? foregroundVisible;

  ///
  /// `backgroundColor` Sets the background color of the [StopwatchGauge]
  ///
  /// ```dart
  /// const StopWatchGauge(
  ///   backgroundColor : BackgroundColorEnum.DARK_GRAY
  /// ),
  /// ```
  ///
  final BackgroundColorEnum? backgroundColor;

  ///
  /// `backgroundVisible` Sets the visibility state of the background of the [StopwatchGauge]
  ///
  /// ```dart
  /// const StopWatchGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? backgroundVisible;

  ///
  /// `pointerType` Sets the pointer type of the [StopwatchGauge]
  ///
  /// ```dart
  /// const StopWatchGauge(
  ///   pointerColor : ColorEnum.RED
  /// ),
  /// ```
  ///
  final ColorEnum? pointerColor;

  ///
  /// `customLayer`
  ///
  /// ```dart
  /// const StopWatchGauge(
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
  /// const StopWatchGauge(
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
  /// StopWatchGauge (
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
  /// StopWatchGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<StopwatchGauge> createState() => _StopwatchGaugeState();
}

class _StopwatchGaugeState extends State<StopwatchGauge>
    with TickerProviderStateMixin {
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
  void didUpdateWidget(covariant StopwatchGauge oldWidget) {
    if (oldWidget.enableAnimation != widget.enableAnimation ||
        oldWidget.seconds != widget.seconds) {
      _from = oldWidget.seconds!;

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
      _animation = Tween<double>(begin: _from, end: widget.seconds).animate(
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
      return _getChild(context, widget.seconds!);
    }
  }

  Widget _getChild(BuildContext context, double seconds) {
    return _LeafStopwatchGauge(
      seconds: seconds,
      frameDesign: widget.frameDesign,
      frameVisible: widget.frameVisible,
      foregroundType: widget.foregroundType,
      foregroundVisible: widget.foregroundVisible,
      backgroundColor: widget.backgroundColor,
      backgroundVisible: widget.backgroundVisible,
      pointerColor: widget.pointerColor,
      customLayer: widget.customLayer,
    );
  }
}

class _LeafStopwatchGauge extends LeafRenderObjectWidget {
  const _LeafStopwatchGauge({
    this.seconds = 0,
    this.frameDesign,
    this.frameVisible,
    this.foregroundType,
    this.foregroundVisible,
    this.backgroundColor,
    this.backgroundVisible,
    this.pointerColor,
    this.customLayer,
  });

  final double? seconds;
  final FrameDesignEnum? frameDesign;
  final bool? frameVisible;
  final ForegroundTypeEnum? foregroundType;
  final bool? foregroundVisible;
  final BackgroundColorEnum? backgroundColor;
  final bool? backgroundVisible;
  final ColorEnum? pointerColor;
  final ui.Image? customLayer;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderStopwatchGauge(
      seconds: seconds!,
      frameDesign: frameDesign,
      frameVisible: frameVisible,
      foregroundType: foregroundType,
      foregroundVisible: foregroundVisible,
      backgroundColor: backgroundColor,
      backgroundVisible: backgroundVisible,
      pointerColor: pointerColor,
      customLayer: customLayer,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderStopwatchGauge renderObject) {
    renderObject
      ..setSeconds = seconds!
      ..setFrameDesign = frameDesign
      ..setFrameVisible = frameVisible
      ..setForegroundType = foregroundType
      ..setForegroundVisible = foregroundVisible
      ..setBackgroundColor = backgroundColor
      ..setBackgroundVisible = backgroundVisible
      ..setPointerColor = pointerColor
      ..setCustomLayer = customLayer;
  }
}
