import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

class StopwatchGaugePage extends StatefulWidget {
  const StopwatchGaugePage({super.key});

  @override
  State<StopwatchGaugePage> createState() => _StopwatchGaugePageState();
}

class _StopwatchGaugePageState extends State<StopwatchGaugePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stopwatch Gauges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.code_outlined),
            onPressed: () async {
              //await launch('https://github.com/JulianAssmann/flutter_gauges/tree/master/example/lib/pages/segments_page.dart');
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: const <Widget>[
          StopwatchGauge(
            seconds: 30,
            frameVisible: true,
            frameDesign: FrameDesignEnum.METAL,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
          ),
          StopwatchGauge(
            seconds: 325,
            frameVisible: true,
            frameDesign: FrameDesignEnum.ANTHRACITE,
            backgroundColor: BackgroundColorEnum.RED,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            pointerColor: ColorEnum.BLACK,
          ),
          StopwatchGauge(
            seconds: 5020,
            frameVisible: true,
            frameDesign: FrameDesignEnum.GLOSSY_METAL,
            backgroundColor: BackgroundColorEnum.BEIGE,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
          ),
          StopwatchGauge(
            seconds: 10,
            frameVisible: true,
            frameDesign: FrameDesignEnum.BRASS,
            backgroundColor: BackgroundColorEnum.LIGHT_GRAY,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
            pointerColor: ColorEnum.BLUE,
          ),
        ],
      ),
    );
  }
}
