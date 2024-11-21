import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';

import 'horizon_gauge_painter.dart';

///
/// Creates a HorizonGauge.
///
///```dart
/// ```
class HorizonGauge extends StatefulWidget {
  /// Creates a HorizonGauge.
  ///
  ///```dart
  /// ```
  const HorizonGauge({
    super.key,
    this.roll = 0,
    this.pitch = 0,
    this.frameDesign = FrameDesignEnum.METAL,
    this.frameVisible = true,
    this.foregroundType = ForegroundTypeEnum.TYPE1,
    this.foregroundVisible = true,
    this.pointerColor = ColorEnum.RED,
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `roll` Sets the roll angle value of the [HorizonGauge]
  ///
  /// ```dart
  /// const HorizonGauge(
  ///   roll : 0.0
  /// ),
  /// ```
  final double? roll;

  ///
  /// `pitch` Sets the pitch angle of the [HorizonGauge]
  ///
  /// ```dart
  /// const HorizonGauge(
  ///   pitch : 0.0
  /// ),
  /// ```
  ///
  final double? pitch;

  ///
  /// `frameDesign` Sets the frame design of the [HorizonGauge]
  ///
  /// ```dart
  /// const HorizonGauge(
  ///   frameDesign : FrameDesignEnum.Metal
  /// ),
  /// ```
  ///
  final FrameDesignEnum? frameDesign;

  ///
  /// `frameVisible` Sets the visibility state of the frame of the [HorizonGauge]
  ///
  /// ```dart
  /// const HorizonGauge(
  ///   frameVisible : true
  /// ),
  /// ```
  ///
  final bool? frameVisible;

  ///
  /// `foregroundType` Sets the foreground type of the [HorizonGauge]
  ///
  /// ```dart
  /// const HorizonGauge(
  ///   foregroundType : ForegroundTypeEnum.TYPE1
  /// ),
  /// ```
  ///
  final ForegroundTypeEnum? foregroundType;

  ///
  /// `foregroundVisible` Sets the visibility state of the foreground of the [HorizonGauge]
  ///
  /// ```dart
  /// const HorizonGauge(
  ///   foregroundVisible : true
  /// ),
  /// ```
  ///
  final bool? foregroundVisible;

  ///
  /// `pointerType` Sets the pointer type of the [RadialGauge]
  ///
  /// ```dart
  /// const HorizonGauge(
  ///   pointerColor : ColorEnum.RED
  /// ),
  /// ```
  ///
  final ColorEnum? pointerColor;

  ///
  /// `enableAnimation` will enable animations.
  ///  It's default to true.
  ///
  /// ```
  /// const HorizonGauge(
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
  /// HorizonGauge (
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
  /// HorizonGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<HorizonGauge> createState() => _HorizonGaugeState();
}

class _HorizonGaugeState extends State<HorizonGauge> with TickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _rollAnimation;
  Animation<double>? _pitchAnimation;
  double _rollFrom = 0;
  double _pitchFrom = 0;

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
  void didUpdateWidget(covariant HorizonGauge oldWidget) {
    if (oldWidget.enableAnimation != widget.enableAnimation || oldWidget.roll != widget.roll || oldWidget.pitch != widget.pitch) {
      _rollFrom = oldWidget.roll!;
      _pitchFrom = oldWidget.pitch!;

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
      _rollAnimation = Tween<double>(begin: _rollFrom, end: widget.roll).animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Interval(
            0.05,
            1.0,
            curve: widget.animationType,
          ),
        ),
      );

      _pitchAnimation = Tween<double>(begin: _pitchFrom, end: widget.pitch).animate(
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
          return _getChild(context, _rollAnimation!.value, _pitchAnimation!.value);
        },
      );
    } else {
      return _getChild(context, widget.roll!, widget.pitch!);
    }
  }

  Widget _getChild(BuildContext context, double roll, double pitch) {
    return _LeafHorizonGauge(
      roll: roll,
      pitch: pitch,
      frameDesign: widget.frameDesign,
      frameVisible: widget.frameVisible,
      foregroundType: widget.foregroundType,
      foregroundVisible: widget.foregroundVisible,
      pointerColor: widget.pointerColor,
    );
  }
}

class _LeafHorizonGauge extends LeafRenderObjectWidget {
  const _LeafHorizonGauge({
    this.roll = 0,
    this.pitch = 100,
    this.frameDesign,
    this.frameVisible,
    this.foregroundType,
    this.foregroundVisible,
    this.pointerColor,
  });

  final double? roll;
  final double? pitch;

  final FrameDesignEnum? frameDesign;
  final bool? frameVisible;
  final ForegroundTypeEnum? foregroundType;
  final bool? foregroundVisible;

  final ColorEnum? pointerColor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderHorizonGauge(
      roll: roll!,
      pitch: pitch!,
      frameDesign: frameDesign,
      frameVisible: frameVisible,
      foregroundType: foregroundType,
      foregroundVisible: foregroundVisible,
      pointerColor: pointerColor,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderHorizonGauge renderObject) {
    renderObject
      ..setRoll = roll!
      ..setPitch = pitch!
      ..setFrameDesign = frameDesign
      ..setFrameVisible = frameVisible
      ..setForegroundType = foregroundType
      ..setForegroundVisible = foregroundVisible
      ..setPointerColor = pointerColor;
  }
}
