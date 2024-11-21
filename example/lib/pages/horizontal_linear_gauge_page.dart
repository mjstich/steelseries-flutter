import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

class HorizontalLinearGaugePage extends StatefulWidget {
  const HorizontalLinearGaugePage({super.key});

  @override
  State<HorizontalLinearGaugePage> createState() => _HorizontalLinearGaugePageState();
}

class _HorizontalLinearGaugePageState extends State<HorizontalLinearGaugePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizontal Linear Gauges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.code_outlined),
            onPressed: () async {
              //await launch('https://github.com/JulianAssmann/flutter_gauges/tree/master/example/lib/pages/segments_page.dart');
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: LinearGauge(
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
            ),
          ),
          Expanded(
            child: LinearGauge(
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
            child: const LinearGauge(
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
              lcdColor: LcdColorEnum.BEIGE,
              ledVisible: false,
              ledOn: true,
              foregroundVisible: true,
              foregroundType: ForegroundTypeEnum.TYPE3,
              fontType: FontTypeEnum.RobotoMono,
              valueColor: ColorEnum.JUG_GREEN,
            ),
          ),
        ],
      ),
    );
  }
}
