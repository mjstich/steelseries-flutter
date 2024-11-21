import 'package:flutter/material.dart';

import 'odometer_gauge_painter.dart';

///
/// Creates a OdometerGauge.
///
///```dart
/// ```
class OdometerGauge extends StatefulWidget {
  /// Creates a OdometerGauge.
  ///
  ///```dart
  /// ```
  const OdometerGauge({
    super.key,
    this.value = 0,
    this.digits = 6,
    this.decimals = 1,
    this.decimalBackColor = const Color.fromRGBO(0xf0, 0xf0, 0xf0, 1),
    this.decimalForeColor = const Color.fromRGBO(0xf0, 0x10, 0x10, 1),
    this.digitBackColor = const Color.fromRGBO(0x05, 0x05, 0x05, 1),
    this.digitForeColor = const Color.fromRGBO(0xf8, 0xf8, 0xf8, 1),
    this.enableAnimation = true,
    this.animationDuration = 1000,
    this.animationType = Curves.ease,
  });

  ///
  /// `value` Sets the value of the [OdometerGauge]
  ///
  /// ```dart
  /// const OdometerGauge(
  ///   value : 0.0
  /// ),
  /// ```
  ///
  final double? value;

  ///
  /// `digits` Sets the number of digits to show in the [OdometerGauge]
  ///
  /// ```dart
  /// const OdometerGauge(
  ///   digits : 6
  /// ),
  /// ```
  ///
  final int? digits;

  ///
  /// `decimals` Sets the number of dicimals to show in the [OdometerGauge]
  ///
  /// ```dart
  /// const OdometerGauge(
  ///   decimals : 1
  /// ),
  /// ```
  ///
  final int? decimals;

  ///
  /// `decimalBackColor` Sets the background color of dicimals to show in the [OdometerGauge]
  ///
  /// ```dart
  /// const OdometerGauge(
  ///   decimalBackColor :
  /// ),
  /// ```
  ///
  final Color? decimalBackColor;

  ///
  /// `diidecimalForeColor` Sets the foreground color of dicimals to show in the [OdometerGauge]
  ///
  /// ```dart
  /// const OdometerGauge(
  ///   decimalForeColor :
  /// ),
  /// ```
  ///
  final Color? decimalForeColor;

  ///
  /// `deigitBackColor` Sets the background color of digits to show in the [OdometerGauge]
  ///
  /// ```dart
  /// const OdometerGauge(
  ///   digitBackColor :
  /// ),
  /// ```
  ///
  final Color? digitBackColor;

  ///
  /// `digitForeColor` Sets the foreground color of digits to show in the [OdometerGauge]
  ///
  /// ```dart
  /// const OdometerGauge(
  ///   digitForeColor :
  /// ),
  /// ```
  ///
  final Color? digitForeColor;

  ///
  /// `enableAnimation` will enable animations.
  ///  It's default to true.
  ///
  /// ```
  /// const OdometerGauge(
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
  /// OdometerGauge (
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
  /// OdometerGauge (
  /// enableAnimation: true,
  /// animationType: Curves.linear
  ///  )
  /// ```
  ///
  final Curve animationType;

  @override
  State<OdometerGauge> createState() => _OdometerGaugeState();
}

class _OdometerGaugeState extends State<OdometerGauge> with TickerProviderStateMixin {
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
  void didUpdateWidget(covariant OdometerGauge oldWidget) {
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
    return _LeafOdometerGauge(
      value: value,
      digits: widget.digits,
      decimals: widget.decimals,
      decimalBackColor: widget.decimalBackColor,
      decimalForeColor: widget.decimalForeColor,
      digitBackColor: widget.digitBackColor,
      digitForeColor: widget.digitForeColor,
    );
  }
}

class _LeafOdometerGauge extends LeafRenderObjectWidget {
  const _LeafOdometerGauge({
    this.value = 0,
    this.digits,
    this.decimals,
    this.decimalBackColor,
    this.decimalForeColor,
    this.digitBackColor,
    this.digitForeColor,
  });

  final double? value;
  final int? digits;
  final int? decimals;
  final Color? decimalBackColor;
  final Color? decimalForeColor;
  final Color? digitBackColor;
  final Color? digitForeColor;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderOdometerGauge(
      value: value!,
      digits: digits,
      decimals: decimals,
      decimalBackColor: decimalBackColor,
      decimalForeColor: decimalForeColor,
      digitBackColor: digitBackColor,
      digitForeColor: digitForeColor,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderOdometerGauge renderObject) {
    renderObject
      ..setValue = value!
      ..setDigits = digits
      ..setDecimals = decimals
      ..setDecimalBackColor = decimalBackColor
      ..setDecimalForeColor = decimalForeColor
      ..setDigitBackColor = digitBackColor
      ..setDigitForeColor = digitForeColor;
  }
}
