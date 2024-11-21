import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class WindDirectionGaugePage extends StatefulWidget {
  const WindDirectionGaugePage({super.key});

  @override
  State<WindDirectionGaugePage> createState() => _WindDirectionGaugePageState();
}

class _WindDirectionGaugePageState extends State<WindDirectionGaugePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wind Direction Gauges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.code_outlined),
            onPressed: () async {
              await launchUrl(Uri.parse('https://github.com/mjstich/steelseries-flutter/blob/main/example/lib/pages/wind_direction_gauge_page.dart'));
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          WindDirectionGauge(
            value: 20,
            valueAverage: 10,
            titleString: '',
            frameVisible: true,
            degreeScale: false,
            degreeScaleHalf: false,
            knobType: KnobTypeEnum.METAL_KNOB,
            knobStyle: KnobStyleEnum.BLACK,
            frameDesign: FrameDesignEnum.METAL,
            lcdColor: LcdColorEnum.STANDARD_GREEN,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.LCDMono,
            pointerType: PointerTypeEnum.TYPE2,
            pointerTypeAverage: PointerTypeEnum.TYPE3,
            section: [
              Section(0, 90, Colors.lightBlue.shade300),
              Section(90, 180, Colors.lightGreen.shade300),
              Section(180, 270, Colors.lightBlue.shade300),
              Section(270, 360, Colors.lightGreen.shade300),
            ],
            useColorLabels: true,
          ),
          const WindDirectionGauge(
            value: 20,
            valueAverage: 40,
            frameVisible: true,
            knobType: KnobTypeEnum.METAL_KNOB,
            knobStyle: KnobStyleEnum.BRASS,
            frameDesign: FrameDesignEnum.ANTHRACITE,
            backgroundColor: BackgroundColorEnum.BLUE,
            lcdColor: LcdColorEnum.BLUE2,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.RobotoMono,
          ),
          const WindDirectionGauge(
            value: 200,
            valueAverage: 225,
            frameVisible: true,
            knobType: KnobTypeEnum.METAL_KNOB,
            knobStyle: KnobStyleEnum.BRASS,
            frameDesign: FrameDesignEnum.GLOSSY_METAL,
            backgroundColor: BackgroundColorEnum.BEIGE,
            lcdColor: LcdColorEnum.AMBER,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.LCDMono,
          ),
          const WindDirectionGauge(
            value: 50,
            valueAverage: 90,
            frameVisible: true,
            knobType: KnobTypeEnum.METAL_KNOB,
            knobStyle: KnobStyleEnum.BRASS,
            frameDesign: FrameDesignEnum.BRASS,
            backgroundColor: BackgroundColorEnum.GREEN,
            lcdColor: LcdColorEnum.STANDARD_GREEN,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.RobotoMono,
            pointSymbols: ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw'],
            roseVisible: false,
          ),
        ],
      ),
    );
  }
}
