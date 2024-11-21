import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

class VerticalLinearBargraphGaugePage extends StatefulWidget {
  const VerticalLinearBargraphGaugePage({super.key});

  @override
  State<VerticalLinearBargraphGaugePage> createState() => _VerticalLinearBargraphGaugePageState();
}

class _VerticalLinearBargraphGaugePageState extends State<VerticalLinearBargraphGaugePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vertical Linear Bargraph Gauges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.code_outlined),
            onPressed: () async {
              //await launch('https://github.com/JulianAssmann/flutter_gauges/tree/master/example/lib/pages/segments_page.dart');
            },
          ),
        ],
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: LinearBargraphGauge(
              value: 60.2,
              titleString: 'Pressure',
              unitString: 'mmHg',
              frameVisible: true,
              end: 500,
              threshold: 260,
              thresholdVisible: false,
              frameDesign: FrameDesignEnum.METAL,
              ledVisible: true,
              ledOn: true,
              foregroundVisible: true,
              foregroundType: ForegroundTypeEnum.TYPE3,
              fontType: FontTypeEnum.LCDMono,
              useSectionColors: true,
              section: [
                Section(0, 60, Colors.green.shade600),
                Section(60, 85, Colors.yellow.shade600),
                Section(85, 100, Colors.red.shade900),
              ],
            ),
          ),
          Expanded(
            child: LinearBargraphGauge(
              value: 20,
              frameVisible: true,
              end: 100,
              threshold: 60,
              thresholdVisible: false,
              frameDesign: FrameDesignEnum.ANTHRACITE,
              backgroundColor: BackgroundColorEnum.BROWN,
              lcdDecimals: 0,
              lcdColor: LcdColorEnum.BLUE2,
              ledVisible: true,
              ledColor: LedColorEnum.GREEN_LED,
              ledOn: true,
              foregroundVisible: true,
              foregroundType: ForegroundTypeEnum.TYPE3,
              fontType: FontTypeEnum.RobotoMono,
            ),
          ),
          Expanded(
            child: const LinearBargraphGauge(
              value: 180,
              frameVisible: true,
              end: 200,
              threshold: 60,
              thresholdVisible: false,
              titleString: 'Flow',
              unitString: 'cfm',
              frameDesign: FrameDesignEnum.BRASS,
              backgroundColor: BackgroundColorEnum.BEIGE,
              lcdDecimals: 0,
              lcdColor: LcdColorEnum.DARKBLUE,
              ledVisible: false,
              ledOn: true,
              foregroundVisible: true,
              foregroundType: ForegroundTypeEnum.TYPE3,
              fontType: FontTypeEnum.RobotoMono,
            ),
          ),
        ],
      ),
    );
  }
}
