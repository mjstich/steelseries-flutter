import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class OdometerGaugePage extends StatefulWidget {
  const OdometerGaugePage({super.key});

  @override
  State<OdometerGaugePage> createState() => _OdometerGaugePageState();
}

class _OdometerGaugePageState extends State<OdometerGaugePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Odometer Gauges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.code_outlined),
            onPressed: () async {
              await launchUrl(Uri.parse('https://github.com/mjstich/steelseries-flutter/blob/main/example/lib/pages/odometer_gauge_page.dart'));
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          const Center(
            child: SizedBox(
              height: 40,
              child: OdometerGauge(
                value: 20060.2,
              ),
            ),
          ),
          const Center(
            child: SizedBox(
              height: 40,
              child: OdometerGauge(
                value: 42247.21,
                decimals: 2,
                digits: 5,
                decimalBackColor: Colors.red,
                decimalForeColor: Colors.black,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 55,
              child: OdometerGauge(
                digits: 4,
                value: 1060.2,
                digitForeColor: Colors.blue.shade900,
                digitBackColor: Colors.white,
                decimalForeColor: Colors.red.shade800,
              ),
            ),
          ),
          const Center(
            child: SizedBox(
              height: 30,
              child: OdometerGauge(
                value: 20060,
                decimals: 0,
                digitBackColor: Colors.amber,
                decimalBackColor: Colors.amber,
                digitForeColor: Colors.black,
                decimalForeColor: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
