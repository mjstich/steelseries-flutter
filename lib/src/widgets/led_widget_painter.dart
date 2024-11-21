import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/tools.dart';
import 'package:steelseries_flutter/src/draw/led.dart';

class RenderLEDWidget extends RenderBox {
  RenderLEDWidget({
    Key? key,
    LedColorEnum? ledColor,
    bool? ledOn,
  })  : _ledColor = ledColor,
        _ledOn = ledOn,
        super();

  LedColorEnum? get getLedColor => _ledColor;
  LedColorEnum? _ledColor;
  set setLedColor(LedColorEnum? ledColor) {
    if (_ledColor == ledColor) return;
    _ledColor = ledColor;
    markNeedsPaint();
  }

  bool? get getLedOn => _ledOn;
  bool? _ledOn;
  set setLedOn(bool? ledOn) {
    if (_ledOn == ledOn) return;
    _ledOn = ledOn;
    markNeedsPaint();
  }

  @override
  bool hitTestSelf(Offset position) {
    Offset calulatedPosition = localToGlobal(position);
    if (ledPath.contains(calulatedPosition)) {
      return true;
    } else if (ledPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the led widget
  }

  @override
  void performLayout() {
    double minWidthHeight = math.min(constraints.maxWidth, constraints.maxHeight);
    size = Size(minWidthHeight, minWidthHeight);
  }

  late Path ledPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    ledPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    ledPath.addArc(rect, 0, TWO_PI);
    ledPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    drawLed(
      canvas,
      size,
      _ledOn == true ? 1 : 0,
      Parameters(
        ledColor: _ledColor,
        ledOn: _ledOn,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
