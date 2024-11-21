import 'package:flutter/material.dart';

import 'light_bulb_widget_painter.dart';

///
/// Creates a LightBulbWidget.
///
///```dart
/// ```
class LightBulbWidget extends StatefulWidget {
  /// Creates a LightBulbWidget.
  ///
  ///```dart
  /// ```
  const LightBulbWidget({
    super.key,
    this.glowColor = const Color.fromRGBO(0xff, 0xff, 0, 1),
    this.lightOn = true,
  });

  ///
  /// `glowColor` Sets the color of the [LightBulbWidget]
  ///
  /// ```dart
  /// const LightBulbWidget(
  ///   glowColor : const Color.fromRGBO(0xff, 0xff, 0, 1)
  /// ),
  /// ```
  ///
  final Color? glowColor;

  ///
  /// `lightOn` Sets the on state of the led of the [LightBulbWidget]
  ///
  /// ```dart
  /// const LightBulbWidget(
  ///   lightOn : true
  /// ),
  /// ```
  ///
  final bool? lightOn;

  @override
  State<LightBulbWidget> createState() => _LightBulbWidgetState();
}

class _LightBulbWidgetState extends State<LightBulbWidget> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return _LeafLightBulbWidget(
      glowColor: widget.glowColor,
      lightOn: widget.lightOn,
    );
  }
}

class _LeafLightBulbWidget extends LeafRenderObjectWidget {
  const _LeafLightBulbWidget({
    this.glowColor,
    this.lightOn,
  });

  final Color? glowColor;
  final bool? lightOn;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderLightBulbWidget(
      glowColor: glowColor,
      lightOn: lightOn,
    );
  }

  @override
  void updateRenderObject(BuildContext context, covariant RenderLightBulbWidget renderObject) {
    renderObject
      ..setGlowColor = glowColor
      ..setLightOn = lightOn;
  }
}
