import 'dart:math';

import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

class LEDWidgetPage extends StatefulWidget {
  const LEDWidgetPage({super.key});

  @override
  State<LEDWidgetPage> createState() => _LEDWidgetPageState();
}

class _LEDWidgetPageState extends State<LEDWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('LED Widgets'),
          actions: [
            IconButton(
              icon: const Icon(Icons.code_outlined),
              onPressed: () async {
                //await launch('https://github.com/JulianAssmann/flutter_gauges/tree/master/example/lib/pages/segments_page.dart');
              },
            ),
          ],
        ),
        body: ListView(
          children: const [
            ListTile(
              leading: LEDWidget(ledOn: true),
              title: Text('Tile With Leading Red LED On'),
            ),
            ListTile(
              leading: LEDWidget(ledOn: false),
              title: Text('Tile With Leading Red LED Off'),
            ),
            ListTile(
              leading: LEDWidget(ledOn: true, ledColor: LedColorEnum.GREEN_LED),
              title: Text('Tile With Leading Green LED On'),
            ),
            ListTile(
              leading: LEDWidget(ledOn: false, ledColor: LedColorEnum.GREEN_LED),
              title: Text('Tile With Leading Green LED Off'),
            ),
            ListTile(
              leading: LEDWidget(ledOn: true, ledColor: LedColorEnum.BLUE_LED),
              title: Text('Tile With Leading Blue LED On'),
            ),
            ListTile(
              leading: LEDWidget(ledOn: false, ledColor: LedColorEnum.BLUE_LED),
              title: Text('Tile With Leading Blue LED Off'),
            ),
            ListTile(
              leading: LEDWidget(ledOn: true, ledColor: LedColorEnum.YELLOW_LED),
              title: Text('Tile With Leading Yellow LED On'),
            ),
            ListTile(
              leading: LEDWidget(ledOn: false, ledColor: LedColorEnum.YELLOW_LED),
              title: Text('Tile With Leading Yellow LED Off'),
            ),
            ListTile(
              trailing: LEDWidget(ledOn: true, ledColor: LedColorEnum.CYAN_LED),
              title: Text('Tile With Trailing Cyan LED On'),
            ),
            ListTile(
              trailing: LEDWidget(ledOn: false, ledColor: LedColorEnum.CYAN_LED),
              title: Text('Tile With Trailing Cyan LED Off'),
            ),
            ListTile(
              trailing: LEDWidget(ledOn: true, ledColor: LedColorEnum.MAGENTA_LED),
              title: Text('Tile With Trailing Magenta LED On'),
            ),
            ListTile(
              trailing: LEDWidget(ledOn: false, ledColor: LedColorEnum.MAGENTA_LED),
              title: Text('Tile With Trailing Magenta LED Off'),
            ),
            ListTile(
              trailing: LEDWidget(ledOn: true, ledColor: LedColorEnum.ORANGE_LED),
              title: Text('Tile With Leading Orange LED On'),
            ),
            ListTile(
              trailing: LEDWidget(ledOn: false, ledColor: LedColorEnum.ORANGE_LED),
              title: Text('Tile With Leading Orange LED Off'),
            )
          ],
        ));
  }
}
