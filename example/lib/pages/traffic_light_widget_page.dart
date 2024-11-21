import 'package:flutter/material.dart';
import 'package:steelseries_flutter/steelseries_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TrafficLightWidgetPage extends StatefulWidget {
  const TrafficLightWidgetPage({super.key});

  @override
  State<TrafficLightWidgetPage> createState() => _TrafficLightWidgetPageState();
}

class _TrafficLightWidgetPageState extends State<TrafficLightWidgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Traffic Light Widgets'),
          actions: [
            IconButton(
              icon: const Icon(Icons.code_outlined),
              onPressed: () async {
                await launchUrl(Uri.parse('https://github.com/mjstich/steelseries-flutter/blob/main/example/lib/pages/traffic_light_widget_page.dart'));
              },
            ),
          ],
        ),
        body: ListView(
          children: const [
            ListTile(
              leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: TrafficLightWidget(redOn: true),
              ),
              title: Text('Stop! Do not go!'),
            ),
            ListTile(
              leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: TrafficLightWidget(yellowOn: true),
              ),
              title: Text('Slow down.  Prepare to stop.'),
            ),
            ListTile(
              leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: TrafficLightWidget(greenOn: true),
              ),
              title: Text('GO! GO! GO!'),
            ),
            ListTile(
              leading: Padding(
                padding: EdgeInsets.all(8.0),
                child: TrafficLightWidget(redOn: true, yellowOn: true, greenOn: true),
              ),
              title: Text('Confused!'),
            ),
          ],
        ));
  }
}
