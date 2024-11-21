import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RadialBargraphGaugePage extends StatefulWidget {
  const RadialBargraphGaugePage({super.key});

  @override
  State<RadialBargraphGaugePage> createState() => _RadialBargraphGaugePageState();
}

class _RadialBargraphGaugePageState extends State<RadialBargraphGaugePage> {
  final List<Color> greenYellowRed = [
    Colors.green,
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.red,
  ];
  final List<double> greenYellowRedFractions = [0, 0.2, 0.5, 0.8, 1];
  late final GradientWrapper greenYellowRedGradient;

  @override
  void initState() {
    initBuffers();
    super.initState();
    greenYellowRedGradient = GradientWrapper(0, 100, greenYellowRedFractions, greenYellowRed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radial Bargraph Gauges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.code_outlined),
            onPressed: () async {
              await launchUrl(Uri.parse('https://github.com/mjstich/steelseries-flutter/blob/main/example/lib/pages/radial_bargraph_gauge_page.dart'));
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          RadialBargraphGauge(
            value: 68.2,
            titleString: 'Pressure',
            unitString: 'mmHg',
            frameVisible: true,
            end: 100,
            threshold: 60,
            thresholdVisible: false,
            gaugeType: GaugeTypeEnum.TYPE4,
            frameDesign: FrameDesignEnum.METAL,
            ledVisible: true,
            ledOn: true,
            userLedVisible: true,
            userLedOn: true,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.LCDMono,
            useSectionColors: true,
            section: [
              Section(0, 60, Colors.green.shade600),
              Section(60, 85, Colors.yellow.shade600),
              Section(85, 100, Colors.red.shade900),
            ],
            tickLabelOrientation: TickLabelOrientationEnum.NORMAL,
          ),
          RadialBargraphGauge(
            value: 95,
            frameVisible: true,
            end: 100,
            threshold: 60,
            thresholdVisible: false,
            gaugeType: GaugeTypeEnum.TYPE3,
            frameDesign: FrameDesignEnum.ANTHRACITE,
            backgroundColor: BackgroundColorEnum.BEIGE,
            lcdDecimals: 0,
            lcdColor: LcdColorEnum.BLUE2,
            ledVisible: true,
            ledOn: true,
            userLedVisible: false,
            userLedOn: true,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            fontType: FontTypeEnum.RobotoMono,
            tickLabelOrientation: TickLabelOrientationEnum.NORMAL,
            useValueGradient: true,
            valueGradient: greenYellowRedGradient,
          ),
          const RadialBargraphGauge(
            value: 200,
            frameVisible: true,
            end: 1000,
            threshold: 60,
            thresholdVisible: false,
            gaugeType: GaugeTypeEnum.TYPE3,
            frameDesign: FrameDesignEnum.GLOSSY_METAL,
            backgroundColor: BackgroundColorEnum.BEIGE,
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
          const RadialBargraphGauge(
            value: 200,
            frameVisible: true,
            end: 200,
            threshold: 60,
            thresholdVisible: false,
            titleString: 'Flow',
            unitString: 'cfm',
            gaugeType: GaugeTypeEnum.TYPE2,
            frameDesign: FrameDesignEnum.BRASS,
            backgroundColor: BackgroundColorEnum.BEIGE,
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
