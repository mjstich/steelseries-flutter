import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RadialVerticalGaugePage extends StatefulWidget {
  const RadialVerticalGaugePage({super.key});

  @override
  State<RadialVerticalGaugePage> createState() => _RadialVerticalGaugePageState();
}

class _RadialVerticalGaugePageState extends State<RadialVerticalGaugePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Vertical Gauges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.code_outlined),
            onPressed: () async {
              await launchUrl(Uri.parse('https://github.com/mjstich/steelseries-flutter/blob/main/example/lib/pages/radial_vertical_gauge_page.dart'));
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          RadialVerticalGauge(
            value: 60.2,
            titleString: 'Pressure',
            unitString: 'mmHg',
            frameVisible: true,
            end: 100,
            threshold: 60,
            thresholdVisible: false,
            knobType: KnobTypeEnum.METAL_KNOB,
            knobStyle: KnobStyleEnum.BLACK,
            frameDesign: FrameDesignEnum.METAL,
            ledVisible: true,
            ledOn: true,
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
          ),
          RadialVerticalGauge(
            value: 20,
            frameVisible: true,
            end: 100,
            threshold: 60,
            thresholdVisible: false,
            knobType: KnobTypeEnum.METAL_KNOB,
            knobStyle: KnobStyleEnum.BRASS,
            frameDesign: FrameDesignEnum.ANTHRACITE,
            backgroundColor: BackgroundColorEnum.BEIGE,
            pointerType: PointerTypeEnum.TYPE2,
            pointerColor: ColorEnum.ORANGE,
            ledVisible: true,
            ledOn: true,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.RobotoMono,
            area: [
              Section(0, 60, Colors.green.shade600),
              Section(60, 85, Colors.yellow.shade600),
              Section(85, 100, Colors.red.shade900),
            ],
          ),
          const RadialVerticalGauge(
            value: 200,
            frameVisible: true,
            end: 1000,
            threshold: 60,
            thresholdVisible: false,
            knobType: KnobTypeEnum.METAL_KNOB,
            knobStyle: KnobStyleEnum.BRASS,
            frameDesign: FrameDesignEnum.GLOSSY_METAL,
            backgroundColor: BackgroundColorEnum.BEIGE,
            pointerType: PointerTypeEnum.TYPE13,
            pointerColor: ColorEnum.GREEN,
            ledVisible: true,
            ledOn: true,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.LCDMono,
          ),
          const RadialVerticalGauge(
            value: 200,
            frameVisible: true,
            end: 200,
            threshold: 60,
            thresholdVisible: false,
            titleString: 'Flow',
            unitString: 'cfm',
            knobType: KnobTypeEnum.METAL_KNOB,
            knobStyle: KnobStyleEnum.BRASS,
            frameDesign: FrameDesignEnum.BRASS,
            backgroundColor: BackgroundColorEnum.BEIGE,
            pointerType: PointerTypeEnum.TYPE5,
            pointerColor: ColorEnum.BLUE,
            ledVisible: false,
            ledOn: true,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.RobotoMono,
          ),
        ],
      ),
    );
  }
}
