import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

class LevelGaugePage extends StatefulWidget {
  const LevelGaugePage({super.key});

  @override
  State<LevelGaugePage> createState() => _LevelGaugePageState();
}

class _LevelGaugePageState extends State<LevelGaugePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Level Gauges'),
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
          LevelGauge(
            frameVisible: true,
            frameDesign: FrameDesignEnum.METAL,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
          ),
          LevelGauge(
            value: 45.1,
            frameVisible: true,
            decimalsVisible: true,
            frameDesign: FrameDesignEnum.ANTHRACITE,
            pointerColor: ColorEnum.ORANGE,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
          ),
          LevelGauge(
            value: 45,
            rotateFace: true,
            frameVisible: true,
            frameDesign: FrameDesignEnum.GLOSSY_METAL,
            pointerColor: ColorEnum.GREEN,
            foregroundVisible: true,
            foregroundType: ForegroundTypeEnum.TYPE3,
          ),
          LevelGauge(
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
