import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';

import 'level_gauge_painter.dart';

///
/// Creates a LevelGauge.
///
///```dart
/// ```
class LevelGauge extends StatefulWidget {
  /// Creates a LevelGauge.
  ///
  ///```dart
  /// ```
  const LevelGauge({
    super.key,
    this.value = 0,
    this.frameDesign = FrameDesignEnum.METAL,
    this.frameVisible = true,
    this.foregroundType = ForegroundTypeEnum.TYPE1,
    this.foregroundVisible = true,
    this.backgroundColor = BackgroundColorEnum.DARK_GRAY,
    this.backgroundVisible = true,
    this.pointerColor = ColorEnum.RED,
    this.rotateFace = false,
    this.decimalsVisible = false,
    this.textOrientationFixed = false,
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `value` Sets the value of the [LevelGauge]
  ///
  /// ```dart
  /// const LevelGauge(
  ///   value : 0.0
  /// ),
  /// ```
  ///
  final double? value;

  ///
  /// `frameDesign` Sets the frame design of the [LevelGauge]
  ///
  /// ```dart
  /// const LevelGauge(
  ///   frameDesign : FrameDesignEnum.Metal
  /// ),
  /// ```
  ///
  final FrameDesignEnum? frameDesign;

  ///
  /// `frameVisible` Sets the visibility state of the frame of the [LevelGauge]
  ///
  /// ```dart
  /// const LevelGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? frameVisible;

  ///
  /// `foregroundType` Sets the foreground type of the [LevelGauge]
  ///
  /// ```dart
  /// const LevelGauge(
  ///   foregroundType : ForegroundTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final ForegroundTypeEnum? foregroundType;

  ///
  /// `foregroundVisible` Sets the visibility state of the foreground of the [LevelGauge]
  ///
  /// ```dart
  /// const LevelGauge(
  ///   foregroundVisible : true
  /// ),
  /// ```
  ///
  final bool? foregroundVisible;

  ///
  /// `backgroundColor` Sets the background color of the [LevelGauge]
  ///
  /// ```dart
  /// const LevelGauge(
  ///   backgroundColor : BackgroundColorEnum.DARK_GRAY
  /// ),
  /// ```
  ///
  final BackgroundColorEnum? backgroundColor;

  ///
  /// `backgroundVisible` Sets the visibility state of the background of the [LevelGauge]
  ///
  /// ```dart
  /// const LevelGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? backgroundVisible;

  ///
  /// `pointerType` Sets the pointer type of the [LevelGauge]
  ///
  /// ```dart
  /// const LevelGauge(
  ///   pointerColor : ColorEnum.RED
  /// ),
  /// ```
  ///
  final ColorEnum? pointerColor;

  ///
  /// `rotateFace` indicates if compass is rotated to degree value on the [CompassGauge]
  ///
  /// ```dart
  /// const LevelGauge(
  ///   rotateFace : false
  /// ),
  /// ```
  ///
  final bool? rotateFace;

  ///
  /// `decimalsVisible` indicates if compass is decimal values are displayed on the [CompassGauge]
  ///
  /// ```dart
  /// const LevelGauge(
  ///   decimalsVisible : false
  /// ),
  /// ```
  ///
  final bool? decimalsVisible;

  ///
  /// `textOrientationFixed` indicates if text orientation is fixed on the [CompassGauge]
  ///
  /// ```dart
  /// const LevelGauge(
  ///   textOrientationFixed : false
  /// ),
  /// ```
  ///
  final bool? textOrientationFixed;

  ///
  /// `enableAnimation` will enable animations.
  ///  It's default to true.
  ///
  /// ```
  /// const LevelGauge(
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
  /// LevelGauge (
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
  /// LevelGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<LevelGauge> createState() => _LevelGaugeState();
}

class _LevelGaugeState extends State<LevelGauge> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;
  double? _from = 0;

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
  void didUpdateWidget(covariant LevelGauge oldWidget) {
    if (oldWidget.enableAnimation != widget.enableAnimation || oldWidget.value != widget.value) {
      _from = oldWidget.value;
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
    return _LeafLevelGauge(
      value: value,
      frameDesign: widget.frameDesign,
      frameVisible: widget.frameVisible,
      foregroundType: widget.foregroundType,
      foregroundVisible: widget.foregroundVisible,
      backgroundColor: widget.backgroundColor,
      backgroundVisible: widget.backgroundVisible,
      pointerColor: widget.pointerColor,
      rotateFace: widget.rotateFace,
      decimalsVisible: widget.decimalsVisible,
      textOrientationFixed: widget.textOrientationFixed,
    );
  }
}

class _LeafLevelGauge extends LeafRenderObjectWidget {
  const _LeafLevelGauge({
    this.value = 0,
    this.frameDesign,
    this.frameVisible,
    this.foregroundType,
    this.foregroundVisible,
    this.backgroundColor,
    this.backgroundVisible,
    this.pointerColor,
    this.rotateFace,
    this.decimalsVisible,
    this.textOrientationFixed,
  });

  final double? value;
  final FrameDesignEnum? frameDesign;
  final bool? frameVisible;
  final ForegroundTypeEnum? foregroundType;
  final bool? foregroundVisible;
  final BackgroundColorEnum? backgroundColor;
  final bool? backgroundVisible;
  final ColorEnum? pointerColor;
  final bool? rotateFace;
  final bool? decimalsVisible;
  final bool? textOrientationFixed;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderLevelGauge(
      value: value!,
      frameDesign: frameDesign,
      frameVisible: frameVisible,
      foregroundType: foregroundType,
      foregroundVisible: foregroundVisible,
      backgroundColor: backgroundColor,
      backgroundVisible: backgroundVisible,
      pointerColor: pointerColor,
      rotateFace: rotateFace,
      decimalsVisible: decimalsVisible,
      textOrientationFixed: textOrientationFixed,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderLevelGauge renderObject) {
    renderObject
      ..setValue = value!
      ..setFrameDesign = frameDesign
      ..setFrameVisible = frameVisible
      ..setForegroundType = foregroundType
      ..setForegroundVisible = foregroundVisible
      ..setBackgroundColor = backgroundColor
      ..setBackgroundVisible = backgroundVisible
      ..setPointerColor = pointerColor
      ..setRotateFace = rotateFace
      ..setDecimalsVisible = decimalsVisible
      ..setTextOrientationFixed = textOrientationFixed;
  }
}
