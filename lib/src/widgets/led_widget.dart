import 'package:flutter/material.dart';

import 'package:steelseries_flutter/src/draw/definitions.dart';

import 'led_widget_painter.dart';

///
/// Creates a LEDWidget.
///
///```dart
/// ```
class LEDWidget extends StatefulWidget {
  /// Creates a RadialGauge.
  ///
  ///```dart
  /// ```
  const LEDWidget({
    super.key,
    this.ledColor = LedColorEnum.RED_LED,
    this.ledOn = false,
  });

  ///
  /// `ledColor` Sets the led color of the [LEDWidget]
  ///
  /// ```dart
  /// const LEDWidget(
  ///   ledColor : LedColorEnum.RED_LED
  /// ),
  /// ```
  ///
  final LedColorEnum? ledColor;

  ///
  /// `ledOn` Sets the on state of the led of the [LEDWidget]
  ///
  /// ```dart
  /// const LEDWidget(
  ///   ledOn : false
  /// ),
  /// ```
  ///
  final bool? ledOn;

  @override
  State<LEDWidget> createState() => _LEDWidgetState();
}

class _LEDWidgetState extends State<LEDWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return _LeafLEDWidget(
      ledColor: widget.ledColor,
      ledOn: widget.ledOn,
    );
  }
}

class _LeafLEDWidget extends LeafRenderObjectWidget {
  const _LeafLEDWidget({
    this.ledColor,
    this.ledOn,
  });

  final LedColorEnum? ledColor;
  final bool? ledOn;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderLEDWidget(
      ledColor: ledColor,
      ledOn: ledOn,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, covariant RenderLEDWidget renderObject) {
    renderObject
      ..setLedColor = ledColor
      ..setLedOn = ledOn;
  }
}
