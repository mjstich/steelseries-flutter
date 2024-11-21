import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/tools.dart';
import 'package:steelseries_flutter/src/draw/battery.dart';

class RenderBatteryGauge extends RenderBox {
  RenderBatteryGauge({
    Key? key,
    required double value,
  })  : _value = value,
        super();

  double get getValue => _value;
  double _value;
  set setValue(double value) {
    if (_value == value) return;
    _value = value;
    markNeedsPaint();
    //markNeedsLayout();
  }

  @override
  bool hitTestSelf(Offset position) {
    Offset calulatedPosition = localToGlobal(position);
    if (batteryPath.contains(calulatedPosition)) {
      return true;
    } else if (batteryPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the battery gauge
  }

  @override
  void performLayout() {
    size = Size(constraints.maxWidth, constraints.maxHeight);
  }

  late Path batteryPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    batteryPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.width * 0.45);
    batteryPath.addArc(rect, 0, TWO_PI);
    batteryPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    drawBattery(
      canvas,
      size,
      Parameters(
        value: _value,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
