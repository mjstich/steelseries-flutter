import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleLCDGaugePage extends StatefulWidget {
  const SingleLCDGaugePage({super.key});

  @override
  State<SingleLCDGaugePage> createState() => _SingleLCDGaugePageState();
}

class _SingleLCDGaugePageState extends State<SingleLCDGaugePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single LCD Gauges'),
        actions: [
          IconButton(
            icon: const Icon(Icons.code_outlined),
            onPressed: () async {
              await launchUrl(Uri.parse('https://github.com/mjstich/steelseries-flutter/blob/main/example/lib/pages/single_lcd_gauge_page.dart'));
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: SingleLCDGauge(
                      unitString: '\u00B0c',
                      unitStringVisible: true,
                      headerString: 'Temperature 1',
                      headerStringVisible: true,
                      value: 80.2,
                      fontType: FontTypeEnum.LCDMono,
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 40,
                    child: SingleLCDGauge(
                      unitString: '\u00B0c',
                      unitStringVisible: true,
                      headerString: 'Temperature 2',
                      headerStringVisible: true,
                      value: 81.2,
                      fontType: FontTypeEnum.LCDMono,
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 40,
                    child: SingleLCDGauge(
                      unitString: '\u00B0c',
                      unitStringVisible: true,
                      headerString: 'Temperature 3',
                      headerStringVisible: true,
                      value: 79.2,
                      fontType: FontTypeEnum.LCDMono,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                    child: SingleLCDGauge(
                      stringValue: 'NORMAL',
                      fontType: FontTypeEnum.LCDMono,
                      lcdColor: LcdColorEnum.STANDARD_GREEN,
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 40,
                    child: SingleLCDGauge(
                      stringValue: 'OFFLINE',
                      fontType: FontTypeEnum.LCDMono,
                      lcdColor: LcdColorEnum.AMBER,
                    ),
                  ),
                  Divider(),
                  SizedBox(
                    height: 40,
                    child: SingleLCDGauge(
                      stringValue: 'ERROR!',
                      fontType: FontTypeEnum.LCDMono,
                      lcdColor: LcdColorEnum.BLACKRED,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 40,
              child: SingleLCDGauge(
                value: 12.2,
                fontType: FontTypeEnum.LCDMono,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              height: 40,
              child: SingleLCDGauge(
                value: 35.2,
                unitString: 'mmHg',
                unitStringVisible: true,
                fontType: FontTypeEnum.LCDMono,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
