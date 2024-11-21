import 'package:flutter/material.dart';

import 'battery_gauge_painter.dart';

///
/// Creates a BatteryGauge.
///
///```dart
/// ```
class BatteryGauge extends StatefulWidget {
  /// Creates a BatteryGauge.
  ///
  ///```dart
  /// ```
  const BatteryGauge({
    super.key,
    this.value = 0,
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `value` Sets the value of the [BatteryGauge].  The value should be in the range of 0..100.
  ///
  /// ```dart
  /// const BatteryGauge(
  ///   value : 0.0
  /// ),
  /// ```
  ///
  final double? value;

  ///
  /// `enableAnimation` will enable animations.
  ///  It's default to true.
  ///
  /// ```
  /// const BatteryGauge(
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
  /// BatteryGauge (
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
  /// BatteryGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<BatteryGauge> createState() => _BatteryGaugeState();
}

class _BatteryGaugeState extends State<BatteryGauge> with TickerProviderStateMixin {
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
  void didUpdateWidget(covariant BatteryGauge oldWidget) {
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
    return _LeafBatteryGauge(
      value: value,
    );
  }
}

class _LeafBatteryGauge extends LeafRenderObjectWidget {
  const _LeafBatteryGauge({
    this.value = 0,
  });

  final double? value;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderBatteryGauge(
      value: value!,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderBatteryGauge renderObject) {
    renderObject.setValue = value!;
  }
}
