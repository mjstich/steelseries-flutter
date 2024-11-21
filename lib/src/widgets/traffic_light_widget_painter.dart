import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';
import 'package:steelseries_flutter/src/draw/trafficLight.dart';

class RenderTrafficLightWidget extends RenderBox {
  RenderTrafficLightWidget({
    Key? key,
    bool? redOn,
    bool? yellowOn,
    bool? greenOn,
  })  : _redOn = redOn,
        _yellowOn = yellowOn,
        _greenOn = greenOn,
        super();

  bool? get getRedOn => _redOn;
  bool? _redOn;
  set setRedOn(bool? redOn) {
    if (_redOn == redOn) return;
    _redOn = redOn;
    markNeedsPaint();
  }

  bool? get getYellowOn => _yellowOn;
  bool? _yellowOn;
  set setYellowOn(bool? yellowOn) {
    if (_yellowOn == yellowOn) return;
    _yellowOn = yellowOn;
    markNeedsPaint();
  }

  bool? get getGreenOn => _greenOn;
  bool? _greenOn;
  set setGreenOn(bool? greenOn) {
    if (_greenOn == greenOn) return;
    _greenOn = greenOn;
    markNeedsPaint();
  }

  @override
  bool hitTestSelf(Offset position) {
    Offset calulatedPosition = localToGlobal(position);
    if (trafficLightPath.contains(calulatedPosition)) {
      return true;
    } else if (trafficLightPath.contains(position)) {
      return true;
    } else {
      return false;
    }
    // Return false if the position is outside the traffic light widget
  }

  @override
  void performLayout() {
    double prefHeight = constraints.maxWidth < constraints.maxHeight * 0.352517 ? constraints.maxWidth * 2.836734 : constraints.maxHeight;
    double imageWidth = prefHeight * 0.352517;
    double imageHeight = prefHeight;
    size = Size(imageWidth, imageHeight);
  }

  late Path trafficLightPath;

  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;

    trafficLightPath = Path();
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    trafficLightPath.addRect(rect);
    trafficLightPath.close();

    canvas.save();
    canvas.translate(offset.dx, offset.dy);

    drawTrafficlight(
      canvas,
      size,
      Parameters(
        redOn: _redOn,
        yellowOn: _yellowOn,
        greenOn: _greenOn,
      ),
    );
    canvas.translate(-offset.dx, -offset.dy);
    canvas.restore();
  }
}
