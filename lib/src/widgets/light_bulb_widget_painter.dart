import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/lightBulb.dart';

class RenderLightBulbWidget extends RenderBox {
  RenderLightBulbWidget({
    Key? key,
    Color? glowColor,
    bool? lightOn,
  })  : _glowColor = glowColor,
        _lightOn = lightOn,
        super();

  Color? get getGlowColor => _glowColor;
  Color? _glowColor;
  set setGlowColor(Color? glowColor) {
    if (_glowColor == glowColor) return;
    _glowColor = glowColor;
    markNeedsPaint();
  }

  bool? get getLightOn => _lightOn;
  bool? _lightOn;
  set setLightOn(bool? lightOn) {
    if (_lightOn == lightOn) return;
    _lightOn = lightOn;
    markNeedsPaint();
  }

  @override
  bool hitTestSelf(Offset position) {
    Offset calulatedPosition = localToGlobal(position);
    if (lightBulbPath.contains(calulatedPosition)) {
      return true;
    } else if (lightBulbPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the light bulb widget
  }

  @override
  void performLayout() {
    double minMaxWidthHeight = math.min(constraints.maxWidth, constraints.maxHeight);
    size = Size(minMaxWidthHeight, minMaxWidthHeight);
  }

  late Path lightBulbPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    lightBulbPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    lightBulbPath.addRect(rect);
    lightBulbPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    drawLightbulb(
      canvas,
      size,
      Parameters(
        glowColor: _glowColor,
        lightOn: _lightOn,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
