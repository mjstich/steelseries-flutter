import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ClockGaugePage extends StatefulWidget {
  const ClockGaugePage({super.key});

  @override
  State<ClockGaugePage> createState() => _ClockGaugePageState();
}

class _ClockGaugePageState extends State<ClockGaugePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clock Gauges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.code_outlined),
            onPressed: () async {
              await launchUrl(Uri.parse('https://github.com/mjstich/steelseries-flutter/blob/main/example/lib/pages/clock_gauge_page.dart'));
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: const <Widget>[
          ClockGauge(
            value: 56020,
            frameVisible: true,
            frameDesign: FrameDesignEnum.METAL,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
          ),
          ClockGauge(
            value: 21,
            frameVisible: true,
            frameDesign: FrameDesignEnum.ANTHRACITE,
            backgroundColor: BackgroundColorEnum.BEIGE,
            pointerType: PointerTypeEnum.TYPE2,
            pointerColor: ColorEnum.ORANGE,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
          ),
          ClockGauge(
            value: 11234,
            frameVisible: true,
            frameDesign: FrameDesignEnum.GLOSSY_METAL,
            backgroundColor: BackgroundColorEnum.CARBON,
            pointerType: PointerTypeEnum.TYPE13,
            pointerColor: ColorEnum.GREEN,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
          ),
          ClockGauge(
            value: 200,
            frameVisible: true,
            frameDesign: FrameDesignEnum.BRASS,
            backgroundColor: BackgroundColorEnum.PUNCHED_SHEET,
            pointerType: PointerTypeEnum.TYPE5,
            pointerColor: ColorEnum.BLUE,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
          ),
        ],
      ),
    );
  }
}
