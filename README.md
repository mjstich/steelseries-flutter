<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

A port of the Steel Series Java gauges to Flutter.

## Features

Several fully animated highly configurable gauges and widgets.

## Usage

An initalization function should be invoked at the start of your application to create several images used to support several background rendering options.


```dart
initBuffers();
```

The gauges and widgets support a wide array of visualization options with default values for each supported option.  The user is free to provide only the overrides they want to differ from the default values.

### Radial Gauges

### Code

```dart
RadialGauge(
  value: 60.2,
  titleString: 'Pressure',
  unitString: 'mmHg',
  frameVisible: true,
  end: 100,
  threshold: 60,
  thresholdVisible: true,
  gaugeType: GaugeTypeEnum.TYPE4,
  knobType: KnobTypeEnum.METAL_KNOB,
  knobStyle: KnobStyleEnum.BLACK,
  frameDesign: FrameDesignEnum.METAL,
  ledVisible: true,
  ledOn: true,
  userLedVisible: true,
  userLedOn: true,
  foregroundVisible: true,
  foregroundType: ForegroundTypeEnum.TYPE3,
  fontType: FontTypeEnum.LCDMono,
  area: [
    Section(85, 100, Colors.red.shade900.withOpacity(0.4)),
  ],
  section: [
    Section(0, 60, Colors.green.shade600),
    Section(60, 85, Colors.yellow.shade600),
    Section(85, 100, Colors.red.shade900),
  ],
  tickLabelOrientation: TickLabelOrientationEnum.NORMAL,
),
```