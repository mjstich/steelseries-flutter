import 'package:flutter/material.dart';

import 'traffic_light_widget_painter.dart';

///
/// Creates a TrafficLightWidget.
///
///```dart
/// ```
class TrafficLightWidget extends StatefulWidget {
  /// Creates a RadialGauge.
  ///
  ///```dart
  /// ```
  const TrafficLightWidget({
    super.key,
    this.redOn = false,
    this.yellowOn = false,
    this.greenOn = false,
  });

  ///
  /// `redOn` Sets the red light on of the [TrafficLightWidget]
  ///
  /// ```dart
  /// const TrafficLightWidget(
  ///   redOn : false
  /// ),
  /// ```
  ///
  final bool? redOn;

  ///
  /// `yellowOn` Sets the yellow light on of the [TrafficLightWidget]
  ///
  /// ```dart
  /// const TrafficLightWidget(
  ///   yellowOn : false
  /// ),
  /// ```
  ///
  final bool? yellowOn;

  ///
  /// `greenOn` Sets the green light on of the [TrafficLightWidget]
  ///
  /// ```dart
  /// const TrafficLightWidget(
  ///   greenOn : false
  /// ),
  /// ```
  ///
  final bool? greenOn;

  @override
  State<TrafficLightWidget> createState() => _TrafficLightWidgetState();
}

class _TrafficLightWidgetState extends State<TrafficLightWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return _LeafTrafficLightWidget(
      redOn: widget.redOn,
      yellowOn: widget.yellowOn,
      greenOn: widget.greenOn,
    );
  }
}

class _LeafTrafficLightWidget extends LeafRenderObjectWidget {
  const _LeafTrafficLightWidget({
    this.redOn,
    this.yellowOn,
    this.greenOn,
  });

  final bool? redOn;
  final bool? yellowOn;
  final bool? greenOn;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderTrafficLightWidget(
      redOn: redOn,
      yellowOn: yellowOn,
      greenOn: greenOn,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderTrafficLightWidget renderObject) {
    renderObject
      ..setRedOn = redOn
      ..setYellowOn = yellowOn
      ..setGreenOn = greenOn;
  }
}
