import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

class HorizonGaugePage extends StatefulWidget {
  const HorizonGaugePage({super.key});

  @override
  State<HorizonGaugePage> createState() => _HorizonGaugePageState();
}

class _HorizonGaugePageState extends State<HorizonGaugePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Horizon Gauges'),
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
          HorizonGauge(
            frameVisible: true,
            frameDesign: FrameDesignEnum.METAL,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
          ),
          HorizonGauge(
            roll: 30,
            frameVisible: true,
            frameDesign: FrameDesignEnum.ANTHRACITE,
            pointerColor: ColorEnum.ORANGE,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
          ),
          HorizonGauge(
            pitch: -20,
            roll: -20,
            frameVisible: true,
            frameDesign: FrameDesignEnum.GLOSSY_METAL,
            pointerColor: ColorEnum.GREEN,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
          ),
          HorizonGauge(
            pitch: 20,
            roll: 20,
            frameVisible: true,
            frameDesign: FrameDesignEnum.BRASS,
            pointerColor: ColorEnum.BLUE,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
          ),
        ],
      ),
    );
  }
}
