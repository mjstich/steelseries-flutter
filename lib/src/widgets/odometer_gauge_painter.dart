import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/odometer.dart';

class RenderOdometerGauge extends RenderBox {
  RenderOdometerGauge({
    Key? key,
    required double value,
    int? digits,
    int? decimals,
    Color? decimalBackColor,
    Color? decimalForeColor,
    Color? digitBackColor,
    Color? digitForeColor,
  })  : _value = value,
        _digits = digits,
        _decimals = decimals,
        _decimalBackColor = decimalBackColor,
        _decimalForeColor = decimalForeColor,
        _digitBackColor = digitBackColor,
        _digitForeColor = digitForeColor,
        super();

  double get getValue => _value;
  double _value;
  set setValue(double value) {
    if (_value == value) return;
    _value = value;
    markNeedsPaint();
  }

  int? get getDigits => _digits;
  int? _digits;
  set setDigits(int? digits) {
    if (_digits == digits) return;
    _digits = digits;
    markNeedsPaint();
  }

  int? get getDecimals => _decimals;
  int? _decimals;
  set setDecimals(int? decimals) {
    if (_decimals == decimals) return;
    _decimals = decimals;
    markNeedsPaint();
  }

  Color? get getDecimalBackColor => _decimalBackColor;
  Color? _decimalBackColor;
  set setDecimalBackColor(Color? decimalBackColor) {
    if (_decimalBackColor == decimalBackColor) return;
    _decimalBackColor = decimalBackColor;
    markNeedsPaint();
  }

  Color? get getDecimalForeColor => _decimalForeColor;
  Color? _decimalForeColor;
  set setDecimalForeColor(Color? decimalForeColor) {
    if (_decimalForeColor == decimalForeColor) return;
    _decimalForeColor = decimalForeColor;
    markNeedsPaint();
  }

  Color? get getDigitBackColor => _digitBackColor;
  Color? _digitBackColor;
  set setDigitBackColor(Color? digitBackColor) {
    if (_digitBackColor == digitBackColor) return;
    _digitBackColor = digitBackColor;
    markNeedsPaint();
  }

  Color? get getDigitForeColor => _digitForeColor;
  Color? _digitForeColor;
  set setDigitForeColor(Color? digitForeColor) {
    if (_digitForeColor == digitForeColor) return;
    _digitForeColor = digitForeColor;
    markNeedsPaint();
  }

  @override
  bool hitTestSelf(Offset position) {
    Offset calulatedPosition = localToGlobal(position);
    if (odometerPath.contains(calulatedPosition)) {
      return true;
    } else if (odometerPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the odometer gauge
  }

  @override
  void performLayout() {
    double digitWidth = (constraints.maxHeight * 0.68).floorToDouble();
    double width = digitWidth * (_digits! + _decimals!);

    size = Size(math.min(width, constraints.maxWidth), constraints.maxHeight);
  }

  late Path odometerPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    odometerPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    odometerPath.addRect(rect);
    odometerPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    canvas.clipPath(odometerPath);

    drawOdometer(
      canvas,
      OdometerParameters(
        value: _value,
        digits: _digits,
        decimals: _decimals,
        height: size.height,
        valueBackColor: _digitBackColor,
        valueForeColor: _digitForeColor,
        decimalBackColor: _decimalBackColor,
        decimalForeColor: _decimalForeColor,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
