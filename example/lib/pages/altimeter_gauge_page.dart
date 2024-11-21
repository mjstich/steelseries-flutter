import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AltimeterGaugePage extends StatefulWidget {
  const AltimeterGaugePage({super.key});

  @override
  State<AltimeterGaugePage> createState() => _AltimeterGaugePageState();
}

class _AltimeterGaugePageState extends State<AltimeterGaugePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Altimeter Gauges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.code_outlined),
            onPressed: () async {
              await launchUrl(Uri.parse('https://github.com/mjstich/steelseries-flutter/blob/main/example/lib/pages/altimeter_gauge_page.dart'));
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: const <Widget>[
          AltimeterGauge(
            value: 20060.2,
            titleString: '',
            unitString: 'feet',
            frameVisible: true,
            knobType: KnobTypeEnum.METAL_KNOB,
            knobStyle: KnobStyleEnum.BLACK,
            frameDesign: FrameDesignEnum.METAL,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.LCDMono,
          ),
          AltimeterGauge(
            value: 20,
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
          AltimeterGauge(
            value: 200,
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
          AltimeterGauge(
            value: 5000,
            frameVisible: true,
            unitString: 'feet',
            knobType: KnobTypeEnum.METAL_KNOB,
            knobStyle: KnobStyleEnum.BRASS,
            frameDesign: FrameDesignEnum.BRASS,
            backgroundColor: BackgroundColorEnum.GREEN,
            lcdColor: LcdColorEnum.STANDARD_GREEN,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.RobotoMono,
          ),
        ],
      ),
    );
  }
}
