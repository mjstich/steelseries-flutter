import 'dart:math';

import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

class BatteryGaugePage extends StatefulWidget {
  const BatteryGaugePage({super.key});

  @override
  State<BatteryGaugePage> createState() => _BatteryGaugePageState();
}

class _BatteryGaugePageState extends State<BatteryGaugePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Battery Gauges'),
        actions: [
          IconButton(
            icon: Icon(Icons.code_outlined),
            onPressed: () async {
              //await launch('https://github.com/JulianAssmann/flutter_gauges/tree/master/example/lib/pages/segments_page.dart');
            },
          ),
        ],
      ),
      body: const SizedBox(
        width: 70,
        height: 120,
        child: Column(
          children: [
            Expanded(
              child: BatteryGauge(
                value: 10,
              ),
            ),
            Expanded(
              child: BatteryGauge(
                value: 20,
              ),
            ),
            Expanded(
              child: BatteryGauge(
                value: 40,
              ),
            ),
            Expanded(
              child: BatteryGauge(
                value: 60,
              ),
            ),
            Expanded(
              child: BatteryGauge(
                value: 80,
              ),
            ),
            Expanded(
              child: BatteryGauge(
                value: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}