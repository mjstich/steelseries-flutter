import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';

class LightBulbWidgetPage extends StatefulWidget {
  const LightBulbWidgetPage({super.key});

  @override
  State<LightBulbWidgetPage> createState() => _LightBulbWidgetPageState();
}

class _LightBulbWidgetPageState extends State<LightBulbWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Light Bulb Widgets'),
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
          children: [
            const ListTile(
              leading: LightBulbWidget(lightOn: true),
              title: Text('Tile With Leading Light Bulb On'),
            ),
            const ListTile(
              leading: LightBulbWidget(lightOn: false),
              title: Text('Tile With Leading Light Bulb Off'),
            ),
            ListTile(
              trailing: LightBulbWidget(lightOn: true, glowColor: Colors.purple.shade900),
              title: const Text('Tile With Trailing Light Bulb On'),
            ),
            ListTile(
              trailing: LightBulbWidget(lightOn: false, glowColor: Colors.purple.shade900),
              title: const Text('Tile With Trailing Light Bulb Off'),
            ),
          ],
        ));
  }
}
