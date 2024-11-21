import 'package:flutter/material.dart';

import 'package:example/pages/altimeter_gauge_page.dart';
import 'package:example/pages/battery_gauge_page.dart';
import 'package:example/pages/clock_gauge_page.dart';
import 'package:example/pages/horizon_gauge_page.dart';
import 'package:example/pages/horizontal_linear_gauge_page.dart';
import 'package:example/pages/horizontal_linear_bargraph_gauge_page.dart';
import 'package:example/pages/led_widget_page.dart';
import 'package:example/pages/level_gauge_page.dart';
import 'package:example/pages/light_bulb_widget_page.dart';
import 'package:example/pages/odometer_gauge_page.dart';
import 'package:example/pages/vertical_linear_gauge_page.dart';
import 'package:example/pages/vertical_linear_bargraph_gauge_page.dart';
import 'package:example/pages/radial_gauge_page.dart';
import 'package:example/pages/radial_bargraph_gauge_page.dart';
import 'package:example/pages/radial_vertical_gauge_page.dart';
import 'package:example/pages/stopwatch_gauge_page.dart';
import 'package:example/pages/traffic_light_widget_page.dart';
import 'package:example/pages/single_lcd_gauge_page.dart';
import 'package:example/pages/wind_direction_gauge_page.dart';

import 'home_page.dart';

class DemoPage {
  final String title;
  final String path;
  final String subtitle;
  final Widget widget;

  DemoPage(this.title, this.subtitle, this.path, this.widget);
}

List<DemoPage> demoPages = [
  DemoPage('Radial Gauges', 'Radial Gauges', '/radial', const RadialGaugePage()),
  DemoPage('Radial Bargraph Gauges', 'Radial Bargraph Gauges', '/radialBargraph', const RadialBargraphGaugePage()),
  DemoPage('Radial Vertical Gauges', 'Radial Vertical Gauges', '/radialVertical', const RadialVerticalGaugePage()),
  DemoPage('Horizontal Linear Gauges', 'Horizontal Linear Gauges', '/horizontalLinear', const HorizontalLinearGaugePage()),
  DemoPage('Horizontal Linear Bargraph Gauges', 'Horizontal Linear Bargraph Gauges', '/horizontalLinearBargraph', const HorizontalLinearBargraphGaugePage()),
  DemoPage('Vertical Linear Gauges', 'Vertical Linear Gauges', '/verticalLinear', const VerticalLinearGaugePage()),
  DemoPage('Vertical Linear Bargraph Gauges', 'Vertical Linear Bargraph Gauges', '/verticalLinearBargraph', const VerticalLinearBargraphGaugePage()),
  DemoPage('Clock Gauges', 'Clock Gauges', '/clock', const ClockGaugePage()),
  DemoPage('Odometer Gauges', 'Odometer Gauges', '/odometer', const OdometerGaugePage()),
  DemoPage('Horizon Gauges', 'Horizon Gauges', '/horizon', const HorizonGaugePage()),
  DemoPage('Altimeter Gauges', 'Altimeter Gauges', '/altimeter', const AltimeterGaugePage()),
  DemoPage('Stopwatch Gauges', 'Stopwatch Gauges', '/stopwatch', const StopwatchGaugePage()),
  DemoPage('Level Gauges', 'Level Gauges', '/level', const LevelGaugePage()),
  DemoPage('Wind Direction Gauges', 'Wind Direction Gauges', '/windDirection', const WindDirectionGaugePage()),
  DemoPage('Single LCD Gauges', 'Single LCD Gauges', '/singleLcd', const SingleLCDGaugePage()),
  DemoPage('LED Widget', 'LED Widget', '/led', const LEDWidgetPage()),
  DemoPage('Traffic Light Widget', 'Traffic Light Widget', '/trafficLight', const TrafficLightWidgetPage()),
  DemoPage('Light Bulb Widget', 'Light Bulb Widget', '/lightbulb', const LightBulbWidgetPage()),
  DemoPage('Battery Gauges', 'Radial Gauges', '/battery', const BatteryGaugePage()),
];

getRoutes(BuildContext context) {
  final Map<String, WidgetBuilder> map = <String, WidgetBuilder>{};
  for (var demoPage in demoPages) {
    map.putIfAbsent(demoPage.path, () {
      return (BuildContext context) => demoPage.widget;
    });
  }
  map.putIfAbsent('/', () {
    return (BuildContext context) => const HomePage();
  });
  return map;
}
