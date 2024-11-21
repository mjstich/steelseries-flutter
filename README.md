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


````dart
initBuffers();
````

The gauges and widgets support a wide array of visualization options with default values for each supported option.  The user is free to provide only the overrides they want to differ from the default values.

### Radial Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/radial_gauges.png" />
</div>

### Radial Bargraph Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/radial_bargraph_gauges.png" />
</div>

### Radial Vertical Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/radial_vertical_gauges.png" />
</div>

### Horizontal Linear Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/horizontal_linear_gauges.png" />
</div>

### Horizontal Linear Bargraph Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/horizontal_linear_bargraph_gauges.png" />
</div>


### Vertical Linear Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/vertical_linear_gauges.png" />
</div>

### Vertical Linear Bargraph Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/vertical_linear_bargraph_gauges.png" />
</div>

### Vertical Clock Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/clock_gauges.png" />
</div>

### Odometer Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/odometer_gauges.png" />
</div>

### Horizon Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/horizon_gauges.png" />
</div>

### Altimeter Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/altimeter_gauges.png" />
</div>

### Stopwatch Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/stopwatch_gauges.png" />
</div>

### Level Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/level_gauges.png" />
</div>

### Wind Direction Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/winddirection_gauges.png" />
</div>

### Single LCD Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/single_lcd_gauges.png" />
</div>

### LED Widgets

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/led_widgets.png" />
</div>

### Traffic Light Widgets

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/trafficlight_widgets.png" />
</div>

### Light Bulb Widgets

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/lightbulb_widgets.png" />  
</div>

### Battery Gauges

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/battery_gauges.png" />
</div>

### Code

````dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Gauges'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          RadialGauge(
            value: 60.2,
            titleString: 'Pressure',
            unitString: 'mmHg',
            frameVisible: true,
            end: 100,
            threshold: 60,
            thresholdVisible: false,
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
          RadialGauge(
            value: 20,
            frameVisible: true,
            end: 100,
            threshold: 60,
            thresholdVisible: false,
            gaugeType: GaugeTypeEnum.TYPE3,
            knobType: KnobTypeEnum.METAL_KNOB,
            knobStyle: KnobStyleEnum.BRASS,
            frameDesign: FrameDesignEnum.ANTHRACITE,
            backgroundColor: BackgroundColorEnum.BEIGE,
            pointerType: PointerTypeEnum.TYPE2,
            pointerColor: ColorEnum.ORANGE,
            lcdDecimals: 0,
            lcdColor: LcdColorEnum.BLUE2,
            ledVisible: true,
            ledOn: true,
            userLedVisible: false,
            userLedOn: true,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.RobotoMono,
            area: [
              Section(0, 60, Colors.green.shade600),
              Section(60, 85, Colors.yellow.shade600),
              Section(85, 100, Colors.red.shade900),
            ],
            tickLabelOrientation: TickLabelOrientationEnum.NORMAL,
          ),
          const RadialGauge(
            value: 200,
            frameVisible: true,
            end: 1000,
            threshold: 60,
            thresholdVisible: false,
            gaugeType: GaugeTypeEnum.TYPE3,
            knobType: KnobTypeEnum.METAL_KNOB,
            knobStyle: KnobStyleEnum.BRASS,
            frameDesign: FrameDesignEnum.GLOSSY_METAL,
            backgroundColor: BackgroundColorEnum.BEIGE,
            pointerType: PointerTypeEnum.TYPE13,
            pointerColor: ColorEnum.GREEN,
            lcdDecimals: 0,
            lcdColor: LcdColorEnum.AMBER,
            ledVisible: true,
            ledOn: true,
            userLedVisible: false,
            userLedOn: true,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.LCDMono,
            tickLabelOrientation: TickLabelOrientationEnum.HORIZONTAL,
          ),
          const RadialGauge(
            value: 200,
            frameVisible: true,
            end: 200,
            threshold: 60,
            thresholdVisible: false,
            titleString: 'Flow',
            unitString: 'cfm',
            gaugeType: GaugeTypeEnum.TYPE2,
            knobType: KnobTypeEnum.METAL_KNOB,
            knobStyle: KnobStyleEnum.BRASS,
            frameDesign: FrameDesignEnum.BRASS,
            backgroundColor: BackgroundColorEnum.BEIGE,
            pointerType: PointerTypeEnum.TYPE5,
            pointerColor: ColorEnum.BLUE,
            lcdDecimals: 0,
            lcdColor: LcdColorEnum.STANDARD_GREEN,
            ledVisible: false,
            ledOn: true,
            userLedVisible: true,
            userLedOn: true,
            userLedColor: LedColorEnum.RED_LED,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.RobotoMono,
            tickLabelOrientation: TickLabelOrientationEnum.HORIZONTAL,
          ),
        ],
      ),
    );
  }
````
### Output

<div align="center">
  <img src="https://raw.githubusercontent.com/mjstich/steelseries-flutter/main/readme/radial_gauges.png" />
</div>