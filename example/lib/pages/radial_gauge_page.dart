import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RadialGaugePage extends StatefulWidget {
  const RadialGaugePage({super.key});

  @override
  State<RadialGaugePage> createState() => _RadialGaugePageState();
}

class _RadialGaugePageState extends State<RadialGaugePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Gauges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.code_outlined),
            onPressed: () async {
              await launchUrl(Uri.parse('https://github.com/mjstich/steelseries-flutter/blob/main/example/lib/pages/radial_gauge_page.dart'));
            },
          ),
        ],
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
}
