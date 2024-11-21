// ignore_for_file: non_constant_identifier_names, constant_identifier_names
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'tools.dart';

class ColorDef {
  final Color veryDark;
  final Color dark;
  final Color medium;
  final Color light;
  final Color lighter;
  final Color veryLight;

  ColorDef(this.veryDark, this.dark, this.medium, this.light, this.lighter, this.veryLight);
}

enum BackgroundColorEnum {
  DARK_GRAY(
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(51, 51, 51, 1),
    Color.fromRGBO(153, 153, 153, 1),
    Color.fromRGBO(255, 255, 255, 1),
    Color.fromRGBO(180, 180, 180, 1),
    'DARK_GRAY',
  ),
  SATIN_GRAY(
    Color.fromRGBO(45, 57, 57, 1),
    Color.fromRGBO(45, 57, 57, 1),
    Color.fromRGBO(45, 57, 57, 1),
    Color.fromRGBO(167, 184, 180, 1),
    Color.fromRGBO(137, 154, 150, 1),
    'SATIN_GRAY',
  ),
  LIGHT_GRAY(
    Color.fromRGBO(130, 130, 130, 1),
    Color.fromRGBO(181, 181, 181, 1),
    Color.fromRGBO(253, 253, 253, 1),
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(80, 80, 80, 1),
    'LIGHT_GRAY',
  ),
  WHITE(
    Color.fromRGBO(255, 255, 255, 1),
    Color.fromRGBO(255, 255, 255, 1),
    Color.fromRGBO(255, 255, 255, 1),
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(80, 80, 80, 1),
    'WHITE',
  ),
  BLACK(
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(255, 255, 255, 1),
    Color.fromRGBO(150, 150, 150, 1),
    'BLACK',
  ),
  BEIGE(
    Color.fromRGBO(178, 172, 150, 1),
    Color.fromRGBO(204, 205, 184, 1),
    Color.fromRGBO(231, 231, 214, 1),
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(80, 80, 80, 1),
    'BEIGE',
  ),
  BROWN(
    Color.fromRGBO(245, 225, 193, 1),
    Color.fromRGBO(245, 225, 193, 1),
    Color.fromRGBO(255, 250, 240, 1),
    Color.fromRGBO(109, 73, 47, 1),
    Color.fromRGBO(89, 53, 27, 1),
    'BROWN',
  ),
  RED(
    Color.fromRGBO(198, 93, 95, 1),
    Color.fromRGBO(212, 132, 134, 1),
    Color.fromRGBO(242, 218, 218, 1),
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(90, 0, 0, 1),
    'RED',
  ),
  GREEN(
    Color.fromRGBO(65, 120, 40, 1),
    Color.fromRGBO(129, 171, 95, 1),
    Color.fromRGBO(218, 237, 202, 1),
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(0, 90, 0, 1),
    'GREEN',
  ),
  BLUE(
    Color.fromRGBO(45, 83, 122, 1),
    Color.fromRGBO(115, 144, 170, 1),
    Color.fromRGBO(227, 234, 238, 1),
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(0, 0, 90, 1),
    'BLUE',
  ),
  ANTHRACITE(
    Color.fromRGBO(50, 50, 54, 1),
    Color.fromRGBO(47, 47, 51, 1),
    Color.fromRGBO(69, 69, 74, 1),
    Color.fromRGBO(250, 250, 250, 1),
    Color.fromRGBO(180, 180, 180, 1),
    'ANTHRACITE',
  ),
  MUD(
    Color.fromRGBO(80, 86, 82, 1),
    Color.fromRGBO(70, 76, 72, 1),
    Color.fromRGBO(57, 62, 58, 1),
    Color.fromRGBO(255, 255, 240, 1),
    Color.fromRGBO(225, 225, 210, 1),
    'MUD',
  ),
  PUNCHED_SHEET(
    Color.fromRGBO(50, 50, 54, 1),
    Color.fromRGBO(47, 47, 51, 1),
    Color.fromRGBO(69, 69, 74, 1),
    Color.fromRGBO(255, 255, 255, 1),
    Color.fromRGBO(180, 180, 180, 1),
    'PUNCHED_SHEET',
  ),
  CARBON(
    Color.fromRGBO(50, 50, 54, 1),
    Color.fromRGBO(47, 47, 51, 1),
    Color.fromRGBO(69, 69, 74, 1),
    Color.fromRGBO(255, 255, 255, 1),
    Color.fromRGBO(180, 180, 180, 1),
    'CARBON',
  ),
  STAINLESS(
    Color.fromRGBO(130, 130, 130, 1),
    Color.fromRGBO(181, 181, 181, 1),
    Color.fromRGBO(253, 253, 253, 1),
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(80, 80, 80, 1),
    'STAINLESS',
  ),
  BRUSHED_METAL(
    Color.fromRGBO(50, 50, 54, 1),
    Color.fromRGBO(47, 47, 51, 1),
    Color.fromRGBO(69, 69, 74, 1),
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(80, 80, 80, 1),
    'BRUSHED_METAL',
  ),
  BRUSHED_STAINLESS(
    Color.fromRGBO(50, 50, 54, 1),
    Color.fromRGBO(47, 47, 51, 1),
    Color.fromRGBO(110, 110, 112, 1),
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(80, 80, 80, 1),
    'BRUSHED_STAINLESS',
  ),
  TURNED(
    Color.fromRGBO(130, 130, 130, 1),
    Color.fromRGBO(181, 181, 181, 1),
    Color.fromRGBO(253, 253, 253, 1),
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(80, 80, 80, 1),
    'TURNED',
  );

  const BackgroundColorEnum(this.gradientStart, this.gradientFraction, this.gradientStop, this.labelColor, this.symbolColor, this.name);

  final Color gradientStart;
  final Color gradientFraction;
  final Color gradientStop;
  final Color labelColor;
  final Color symbolColor;
  final String name;
}

enum LcdColorEnum {
  BEIGE(
    Color.fromRGBO(0xc8, 0xc8, 0xb1, 1),
    Color.fromRGBO(241, 237, 207, 1),
    Color.fromRGBO(234, 230, 194, 1),
    Color.fromRGBO(225, 220, 183, 1),
    Color.fromRGBO(237, 232, 191, 1),
    Color.fromRGBO(0x0, 0x00, 0x00, 1),
  ),
  BLUE(
    Color.fromRGBO(0xff, 0xff, 0xff, 1),
    Color.fromRGBO(231, 246, 255, 1),
    Color.fromRGBO(170, 224, 255, 1),
    Color.fromRGBO(136, 212, 255, 1),
    Color.fromRGBO(192, 232, 255, 1),
    Color.fromRGBO(0x12, 0x45, 0x64, 1),
  ),
  ORANGE(
    Color.fromRGBO(0xff, 0xff, 0xff, 1),
    Color.fromRGBO(255, 245, 225, 1),
    Color.fromRGBO(255, 217, 147, 1),
    Color.fromRGBO(255, 201, 104, 1),
    Color.fromRGBO(255, 227, 173, 1),
    Color.fromRGBO(0x50, 0x37, 0x00, 1),
  ),
  RED(
    Color.fromRGBO(0xff, 0xff, 0xff, 1),
    Color.fromRGBO(255, 225, 225, 1),
    Color.fromRGBO(253, 152, 152, 1),
    Color.fromRGBO(252, 114, 115, 1),
    Color.fromRGBO(254, 178, 178, 1),
    Color.fromRGBO(0x4f, 0x0c, 0x0e, 1),
  ),
  YELLOW(
    Color.fromRGBO(0xff, 0xff, 0xff, 1),
    Color.fromRGBO(245, 255, 186, 1),
    Color.fromRGBO(210, 255, 0, 1),
    Color.fromRGBO(158, 205, 0, 1),
    Color.fromRGBO(210, 255, 0, 1),
    Color.fromRGBO(0x40, 0x53, 0x00, 1),
  ),
  WHITE(
    Color.fromRGBO(0xff, 0xff, 0xff, 1),
    Color.fromRGBO(0xff, 0xff, 0xff, 1),
    Color.fromRGBO(241, 246, 242, 1),
    Color.fromRGBO(229, 239, 244, 1),
    Color.fromRGBO(0xff, 0xff, 0xff, 1),
    Color.fromRGBO(0x00, 0x00, 0x00, 1),
  ),
  GRAY(
    Color.fromRGBO(0x41, 0x41, 0x41, 1),
    Color.fromRGBO(117, 117, 117, 1),
    Color.fromRGBO(87, 87, 87, 1),
    Color.fromRGBO(0x41, 0x41, 0x41, 1),
    Color.fromRGBO(81, 81, 81, 1),
    Color.fromRGBO(0xff, 0xff, 0xff, 1),
  ),
  BLACK(
    Color.fromRGBO(0x41, 0x41, 0x41, 1),
    Color.fromRGBO(0x66, 0x66, 0x66, 1),
    Color.fromRGBO(0x33, 0x33, 0x33, 1),
    Color.fromRGBO(0x00, 0x00, 0x00, 1),
    Color.fromRGBO(0x33, 0x33, 0x33, 1),
    Color.fromRGBO(0xcc, 0xcc, 0xcc, 1),
  ),
  GREEN(
    Color.fromRGBO(33, 67, 67, 1),
    Color.fromRGBO(33, 67, 67, 1),
    Color.fromRGBO(29, 58, 58, 1),
    Color.fromRGBO(28, 57, 57, 1),
    Color.fromRGBO(23, 46, 46, 1),
    Color.fromRGBO(185, 165, 255, 1),
  ),
  BLUE2(
    Color.fromRGBO(0, 68, 103, 1),
    Color.fromRGBO(8, 109, 165, 1),
    Color.fromRGBO(0, 72, 117, 1),
    Color.fromRGBO(0, 72, 117, 1),
    Color.fromRGBO(0, 68, 103, 1),
    Color.fromRGBO(111, 182, 228, 1),
  ),
  BLUE_BLACK(
    Color.fromRGBO(22, 125, 212, 1),
    Color.fromRGBO(3, 162, 254, 1),
    Color.fromRGBO(3, 162, 254, 1),
    Color.fromRGBO(3, 162, 254, 1),
    Color.fromRGBO(11, 172, 244, 1),
    Color.fromRGBO(0x00, 0x00, 0x00, 1),
  ),
  BLUE_DARKBLUE(
    Color.fromRGBO(18, 33, 88, 1),
    Color.fromRGBO(18, 33, 88, 1),
    Color.fromRGBO(19, 30, 90, 1),
    Color.fromRGBO(17, 31, 94, 1),
    Color.fromRGBO(21, 25, 90, 1),
    Color.fromRGBO(23, 99, 221, 1),
  ),
  BLUE_GRAY(
    Color.fromRGBO(135, 174, 255, 1),
    Color.fromRGBO(101, 159, 255, 1),
    Color.fromRGBO(44, 93, 255, 1),
    Color.fromRGBO(27, 65, 254, 1),
    Color.fromRGBO(12, 50, 255, 1),
    Color.fromRGBO(0xb2, 0xb4, 0xed, 1),
  ),
  STANDARD(
    Color.fromRGBO(131, 133, 119, 1),
    Color.fromRGBO(176, 183, 167, 1),
    Color.fromRGBO(165, 174, 153, 1),
    Color.fromRGBO(166, 175, 156, 1),
    Color.fromRGBO(175, 184, 165, 1),
    Color.fromRGBO(35, 42, 52, 1),
  ),
  STANDARD_GREEN(
    Color.fromRGBO(0xff, 0xff, 0xff, 1),
    Color.fromRGBO(219, 230, 220, 1),
    Color.fromRGBO(179, 194, 178, 1),
    Color.fromRGBO(153, 176, 151, 1),
    Color.fromRGBO(114, 138, 109, 1),
    Color.fromRGBO(0x08, 0x0C, 0x06, 1),
  ),
  BLUE_BLUE(
    Color.fromRGBO(100, 168, 253, 1),
    Color.fromRGBO(100, 168, 253, 1),
    Color.fromRGBO(95, 160, 250, 1),
    Color.fromRGBO(80, 144, 252, 1),
    Color.fromRGBO(74, 134, 255, 1),
    Color.fromRGBO(0x00, 0x2c, 0xbb, 1),
  ),
  RED_DARKRED(
    Color.fromRGBO(72, 36, 50, 1),
    Color.fromRGBO(185, 111, 110, 1),
    Color.fromRGBO(148, 66, 72, 1),
    Color.fromRGBO(83, 19, 20, 1),
    Color.fromRGBO(7, 6, 14, 1),
    Color.fromRGBO(0xFE, 0x8B, 0x92, 1),
  ),
  DARKBLUE(
    Color.fromRGBO(14, 24, 31, 1),
    Color.fromRGBO(46, 105, 144, 1),
    Color.fromRGBO(19, 64, 96, 1),
    Color.fromRGBO(6, 20, 29, 1),
    Color.fromRGBO(8, 9, 10, 1),
    Color.fromRGBO(0x3D, 0xB3, 0xFF, 1),
  ),
  LILA(
    Color.fromRGBO(175, 164, 255, 1),
    Color.fromRGBO(188, 168, 253, 1),
    Color.fromRGBO(176, 159, 255, 1),
    Color.fromRGBO(174, 147, 252, 1),
    Color.fromRGBO(168, 136, 233, 1),
    Color.fromRGBO(0x07, 0x61, 0x48, 1),
  ),
  BLACKRED(
    Color.fromRGBO(8, 12, 11, 1),
    Color.fromRGBO(10, 11, 13, 1),
    Color.fromRGBO(11, 10, 15, 1),
    Color.fromRGBO(7, 13, 9, 1),
    Color.fromRGBO(9, 13, 14, 1),
    Color.fromRGBO(0xB5, 0x00, 0x26, 1),
  ),
  DARKGREEN(
    Color.fromRGBO(25, 85, 0, 1),
    Color.fromRGBO(47, 154, 0, 1),
    Color.fromRGBO(30, 101, 0, 1),
    Color.fromRGBO(30, 101, 0, 1),
    Color.fromRGBO(25, 85, 0, 1),
    Color.fromRGBO(0x23, 0x31, 0x23, 1),
  ),
  AMBER(
    Color.fromRGBO(182, 71, 0, 1),
    Color.fromRGBO(236, 155, 25, 1),
    Color.fromRGBO(212, 93, 5, 1),
    Color.fromRGBO(212, 93, 5, 1),
    Color.fromRGBO(182, 71, 0, 1),
    Color.fromRGBO(0x59, 0x3A, 0x0A, 1),
  ),
  LIGHTBLUE(
    Color.fromRGBO(125, 146, 184, 1),
    Color.fromRGBO(197, 212, 231, 1),
    Color.fromRGBO(138, 155, 194, 1),
    Color.fromRGBO(138, 155, 194, 1),
    Color.fromRGBO(125, 146, 184, 1),
    Color.fromRGBO(0x09, 0x00, 0x51, 1),
  ),
  SECTIONS(
    Color.fromRGBO(0xb2, 0xb2, 0xb2, 1),
    Color.fromRGBO(0xff, 0xff, 0xff, 1),
    Color.fromRGBO(0xc4, 0xc4, 0xc4, 1),
    Color.fromRGBO(0xc4, 0xc4, 0xc4, 1),
    Color.fromRGBO(0xb2, 0xb2, 0xb2, 1),
    Color.fromRGBO(0x00, 0x00, 0x00, 1),
  );

  const LcdColorEnum(this.gradientStartColor, this.gradientFraction1Color, this.gradientFraction2Color, this.gradientFraction3Color, this.gradientStopColor, this.textColor);

  final Color gradientStartColor;
  final Color gradientFraction1Color;
  final Color gradientFraction2Color;
  final Color gradientFraction3Color;
  final Color gradientStopColor;
  final Color textColor;

  @override
  String toString() {
    return gradientStartColor.toString() + gradientFraction1Color.toString() + gradientFraction2Color.toString() + gradientFraction3Color.toString() + gradientStopColor.toString() + textColor.toString();
  }
}

enum ColorEnum {
  RED(
    Color.fromRGBO(82, 0, 0, 1),
    Color.fromRGBO(158, 0, 19, 1),
    Color.fromRGBO(213, 0, 25, 1),
    Color.fromRGBO(240, 82, 88, 1),
    Color.fromRGBO(255, 171, 173, 1),
    Color.fromRGBO(255, 217, 218, 1),
  ),
  GREEN(
    Color.fromRGBO(8, 54, 4, 1),
    Color.fromRGBO(0, 107, 14, 1),
    Color.fromRGBO(15, 148, 0, 1),
    Color.fromRGBO(121, 186, 37, 1),
    Color.fromRGBO(190, 231, 141, 1),
    Color.fromRGBO(234, 247, 218, 1),
  ),
  BLUE(
    Color.fromRGBO(0, 11, 68, 1),
    Color.fromRGBO(0, 73, 135, 1),
    Color.fromRGBO(0, 108, 201, 1),
    Color.fromRGBO(0, 141, 242, 1),
    Color.fromRGBO(122, 200, 255, 1),
    Color.fromRGBO(204, 236, 255, 1),
  ),
  ORANGE(
    Color.fromRGBO(118, 83, 30, 1),
    Color.fromRGBO(215, 67, 0, 1),
    Color.fromRGBO(240, 117, 0, 1),
    Color.fromRGBO(255, 166, 0, 1),
    Color.fromRGBO(255, 255, 128, 1),
    Color.fromRGBO(255, 247, 194, 1),
  ),
  YELLOW(
    Color.fromRGBO(41, 41, 0, 1),
    Color.fromRGBO(102, 102, 0, 1),
    Color.fromRGBO(177, 165, 0, 1),
    Color.fromRGBO(255, 242, 0, 1),
    Color.fromRGBO(255, 250, 153, 1),
    Color.fromRGBO(255, 252, 204, 1),
  ),
  CYAN(
    Color.fromRGBO(15, 109, 109, 1),
    Color.fromRGBO(0, 109, 144, 1),
    Color.fromRGBO(0, 144, 191, 1),
    Color.fromRGBO(0, 174, 239, 1),
    Color.fromRGBO(153, 223, 249, 1),
    Color.fromRGBO(204, 239, 252, 1),
  ),
  MAGENTA(
    Color.fromRGBO(98, 0, 114, 1),
    Color.fromRGBO(128, 24, 72, 1),
    Color.fromRGBO(191, 36, 107, 1),
    Color.fromRGBO(255, 48, 143, 1),
    Color.fromRGBO(255, 172, 210, 1),
    Color.fromRGBO(255, 214, 23, 1),
  ),
  WHITE(
    Color.fromRGBO(210, 210, 210, 1),
    Color.fromRGBO(220, 220, 220, 1),
    Color.fromRGBO(235, 235, 235, 1),
    Color.fromRGBO(255, 255, 255, 1),
    Color.fromRGBO(255, 255, 255, 1),
    Color.fromRGBO(255, 255, 255, 1),
  ),
  GRAY(
    Color.fromRGBO(25, 25, 25, 1),
    Color.fromRGBO(51, 51, 51, 1),
    Color.fromRGBO(76, 76, 76, 1),
    Color.fromRGBO(128, 128, 128, 1),
    Color.fromRGBO(204, 204, 204, 1),
    Color.fromRGBO(243, 243, 243, 1),
  ),
  BLACK(
    Color.fromRGBO(0, 0, 0, 1),
    Color.fromRGBO(5, 5, 5, 1),
    Color.fromRGBO(10, 10, 10, 1),
    Color.fromRGBO(15, 15, 15, 1),
    Color.fromRGBO(20, 20, 20, 1),
    Color.fromRGBO(25, 25, 25, 1),
  ),
  RAITH(
    Color.fromRGBO(0, 32, 65, 1),
    Color.fromRGBO(0, 65, 125, 1),
    Color.fromRGBO(0, 106, 172, 1),
    Color.fromRGBO(130, 180, 214, 1),
    Color.fromRGBO(148, 203, 242, 1),
    Color.fromRGBO(191, 229, 255, 1),
  ),
  GREEN_LCD(
    Color.fromRGBO(0, 55, 45, 1),
    Color.fromRGBO(15, 109, 93, 1),
    Color.fromRGBO(0, 185, 165, 1),
    Color.fromRGBO(48, 255, 204, 1),
    Color.fromRGBO(153, 255, 227, 1),
    Color.fromRGBO(204, 255, 241, 1),
  ),
  JUG_GREEN(
    Color.fromRGBO(0, 56, 0, 1),
    Color.fromRGBO(32, 69, 36, 1),
    Color.fromRGBO(50, 161, 0, 1),
    Color.fromRGBO(129, 206, 0, 1),
    Color.fromRGBO(190, 231, 141, 1),
    Color.fromRGBO(234, 247, 218, 1),
  );

  const ColorEnum(this.veryDark, this.dark, this.medium, this.light, this.lighter, this.veryLight);

  final Color veryDark;
  final Color dark;
  final Color medium;
  final Color light;
  final Color lighter;
  final Color veryLight;

  ColorDef toColorDef() => ColorDef(veryDark, dark, medium, light, lighter, veryLight);
}

enum LedColorEnum {
  RED_LED(
    Color.fromRGBO(0xFF, 0x9A, 0x89, 1),
    Color.fromRGBO(0xFF, 0x9A, 0x89, 1),
    Color.fromRGBO(0xFF, 0x33, 0x00, 1),
    Color.fromRGBO(0xFF, 0x8D, 0x70, 1),
    Color.fromRGBO(0x7E, 0x1C, 0x00, 1),
    Color.fromRGBO(0x7E, 0x1C, 0x00, 1),
    Color.fromRGBO(0x64, 0x1B, 0x00, 1),
  ),
  GREEN_LED(
    Color.fromRGBO(0x9A, 0xFF, 0x89, 1),
    Color.fromRGBO(0x9A, 0xFF, 0x89, 1),
    Color.fromRGBO(0x59, 0xFF, 0x2A, 1),
    Color.fromRGBO(0xA5, 0xFF, 0x00, 1),
    Color.fromRGBO(0x1C, 0x7E, 0x00, 1),
    Color.fromRGBO(0x1C, 0x7E, 0x00, 1),
    Color.fromRGBO(0x1B, 0x64, 0x00, 1),
  ),
  BLUE_LED(
    Color.fromRGBO(0x89, 0x9A, 0xFF, 1),
    Color.fromRGBO(0x89, 0x9A, 0xFF, 1),
    Color.fromRGBO(0x00, 0x33, 0xFF, 1),
    Color.fromRGBO(0x70, 0x8D, 0xFF, 1),
    Color.fromRGBO(0x00, 0x1C, 0x7E, 1),
    Color.fromRGBO(0x00, 0x1C, 0x7E, 1),
    Color.fromRGBO(0x00, 0x1B, 0x64, 1),
  ),
  ORANGE_LED(
    Color.fromRGBO(0xFE, 0xA2, 0x3F, 1),
    Color.fromRGBO(0xFE, 0xA2, 0x3F, 1),
    Color.fromRGBO(0xFD, 0x6C, 0x00, 1),
    Color.fromRGBO(0xFD, 0x6C, 0x00, 1),
    Color.fromRGBO(0x59, 0x28, 0x00, 1),
    Color.fromRGBO(0x59, 0x28, 0x00, 1),
    Color.fromRGBO(0x42, 0x1F, 0x00, 1),
  ),
  YELLOW_LED(
    Color.fromRGBO(0xFF, 0xFF, 0x62, 1),
    Color.fromRGBO(0xFF, 0xFF, 0x62, 1),
    Color.fromRGBO(0xFF, 0xFF, 0x00, 1),
    Color.fromRGBO(0xFF, 0xFF, 0x00, 1),
    Color.fromRGBO(0x6B, 0x6D, 0x00, 1),
    Color.fromRGBO(0x6B, 0x6D, 0x00, 1),
    Color.fromRGBO(0x51, 0x53, 0x00, 1),
  ),
  CYAN_LED(
    Color.fromRGBO(0x00, 0xFF, 0xFF, 1),
    Color.fromRGBO(0x00, 0xFF, 0xFF, 1),
    Color.fromRGBO(0x1B, 0xC3, 0xC3, 1),
    Color.fromRGBO(0x00, 0xFF, 0xFF, 1),
    Color.fromRGBO(0x08, 0x3B, 0x3B, 1),
    Color.fromRGBO(0x08, 0x3B, 0x3B, 1),
    Color.fromRGBO(0x05, 0x27, 0x27, 1),
  ),
  MAGENTA_LED(
    Color.fromRGBO(0xD3, 0x00, 0xFF, 1),
    Color.fromRGBO(0xD3, 0x00, 0xFF, 1),
    Color.fromRGBO(0x86, 0x00, 0xCB, 1),
    Color.fromRGBO(0xC3, 0x00, 0xFF, 1),
    Color.fromRGBO(0x38, 0x00, 0x4B, 1),
    Color.fromRGBO(0x38, 0x00, 0x4B, 1),
    Color.fromRGBO(0x28, 0x00, 0x35, 1),
  );

  final Color innerColor1_ON;
  final Color innerColor2_ON;
  final Color outerColor_ON;
  final Color coronaColor;
  final Color innerColor1_OFF;
  final Color innerColor2_OFF;
  final Color outerColor_OFF;

  const LedColorEnum(this.innerColor1_ON, this.innerColor2_ON, this.outerColor_ON, this.coronaColor, this.innerColor1_OFF, this.innerColor2_OFF, this.outerColor_OFF);

  @override
  String toString() {
    return innerColor1_ON.toString() + innerColor2_ON.toString() + outerColor_ON.toString() + coronaColor.toString() + innerColor1_OFF.toString() + innerColor2_OFF.toString() + outerColor_OFF.toString();
  }
}

enum FontTypeEnum {
  LCDMono,
  RobotoMono,
}

enum GaugeTypeEnum {
  TYPE1,
  TYPE2,
  TYPE3,
  TYPE4,
  TYPE5;
}

enum OrientationEnum {
  NORTH,
  SOUTH,
  EAST,
  WEST;
}

enum KnobTypeEnum {
  STANDARD_KNOB,
  METAL_KNOB,
}

enum KnobStyleEnum {
  BLACK,
  BRASS,
  SILVER,
}

enum FrameDesignEnum {
  BLACK_METAL,
  METAL,
  SHINY_METAL,
  BRASS,
  STEEL,
  CHROME,
  GOLD,
  ANTHRACITE,
  TILTED_GRAY,
  TILTED_BLACK,
  GLOSSY_METAL,
}

enum PointerTypeEnum {
  TYPE1,
  TYPE2,
  TYPE3,
  TYPE4,
  TYPE5,
  TYPE6,
  TYPE7,
  TYPE8,
  TYPE9,
  TYPE10,
  TYPE11,
  TYPE12,
  TYPE13,
  TYPE14,
  TYPE15,
  TYPE16,
}

enum ForegroundTypeEnum {
  TYPE1,
  TYPE2,
  TYPE3,
  TYPE4,
  TYPE5,
}

enum LabelNumberFormatEnum {
  STANDARD,
  FRACTIONAL,
  SCIENTIFIC,
}

enum TickLabelOrientationEnum {
  NORMAL,
  HORIZONTAL,
  TANGENT,
}

enum TrendStateEnum {
  UP,
  STEADY,
  DOWN,
  OFF,
}

class Section {
  final double start;
  final double stop;
  final Color color;

  Section(this.start, this.stop, this.color);
}

class Parameters {
  double? size;
  double? value;
  double? valueAverage;
  double? averageValue;
  double? seconds;
  double? minValue;
  double? minMeasuredValue;
  double? maxValue;
  double? maxMeasuredValue;
  double? threshold;
  double? pitch;
  double? roll;
  String? stringValue;
  LedColorEnum? ledColor;
  LcdColorEnum? lcdColor;
  LedColorEnum? userLedColor;
  FrameDesignEnum? frameDesign;
  BackgroundColorEnum? backgroundColor;
  ForegroundTypeEnum? foregroundType;
  PointerTypeEnum? pointerType;
  PointerTypeEnum? pointerTypeAverage;
  GaugeTypeEnum? gaugeType;
  KnobTypeEnum? knobType;
  KnobStyleEnum? knobStyle;
  ColorEnum? color;
  ColorEnum? valueColor;
  ColorEnum? pointerColor;
  ColorEnum? pointerColorAverage;
  FontTypeEnum? fontType;
  bool? frameVisible;
  bool? backgroundVisible;
  bool? foregroundVisible;
  bool? roseVisible;
  bool? rotateFace;
  bool? degreeScale;
  bool? degreeScaleHalf;
  bool? pointSymbolsVisible;
  bool? unitAltPos;
  bool? lcdVisible;
  bool? ledVisible;
  bool? ledOn;
  bool? userLedVisible;
  bool? userLedOn;
  bool? niceScale;
  bool? thresholdVisible;
  bool? minMeasuredValueVisible;
  bool? maxMeasuredValueVisible;
  bool? trendVisible;
  bool? useOdometer;
  bool? useSectionColors;
  bool? useValueGradient;
  bool? lightOn;
  bool? decimalsVisible;
  bool? textOrientationFixed;
  bool? unitStringVisible;
  bool? headerStringVisible;
  bool? redOn;
  bool? yellowOn;
  bool? greenOn;
  bool? useColorLabels;
  bool? secondPointerVisible;
  List<String>? pointerSymbols;
  ui.Image? customLayer;
  Color? degreeFontColor;
  Color? glowColor;
  String? titleString;
  String? unitString;
  String? headerString;
  List<Section>? section;
  List<Section>? area;
  int? lcdDecimals;
  int? fractionalScaleDecimals;
  LabelNumberFormatEnum? labelNumberFormat;
  OrientationEnum? orientation;
  TickLabelOrientationEnum? tickLabelOrientation;
  List<LedColorEnum>? trendColors;
  TrendStateEnum? trendState;
  OdometerParameters? odometerParameters;
  GradientWrapper? valueGradient;
  ClockParameters? clockTime;
  List<String>? lcdTitleStrings;

  Parameters({
    this.ledColor,
    this.lcdColor,
    this.size,
    this.value,
    this.valueAverage,
    this.seconds,
    this.minValue,
    this.minMeasuredValue,
    this.maxValue,
    this.maxMeasuredValue,
    this.threshold,
    this.pitch,
    this.roll,
    this.stringValue,
    this.frameDesign,
    this.frameVisible,
    this.backgroundVisible,
    this.backgroundColor,
    this.foregroundType,
    this.pointerType,
    this.pointerTypeAverage,
    this.gaugeType,
    this.knobType,
    this.knobStyle,
    this.color,
    this.valueColor,
    this.pointerColor,
    this.pointerColorAverage,
    this.fontType,
    this.foregroundVisible,
    this.lcdVisible,
    this.ledVisible,
    this.ledOn,
    this.userLedVisible,
    this.userLedOn,
    this.roseVisible,
    this.thresholdVisible,
    this.degreeScale,
    this.degreeScaleHalf,
    this.pointSymbolsVisible,
    this.pointerSymbols,
    this.rotateFace,
    this.customLayer,
    this.degreeFontColor,
    this.glowColor,
    this.titleString,
    this.unitString,
    this.headerString,
    this.unitAltPos,
    this.niceScale,
    this.section,
    this.useSectionColors,
    this.useValueGradient,
    this.lightOn,
    this.decimalsVisible,
    this.textOrientationFixed,
    this.unitStringVisible,
    this.headerStringVisible,
    this.redOn,
    this.yellowOn,
    this.greenOn,
    this.useColorLabels,
    this.secondPointerVisible,
    this.area,
    this.lcdDecimals,
    this.fractionalScaleDecimals,
    this.userLedColor,
    this.minMeasuredValueVisible,
    this.maxMeasuredValueVisible,
    this.labelNumberFormat,
    this.orientation,
    this.tickLabelOrientation,
    this.trendVisible,
    this.trendColors,
    this.useOdometer,
    this.trendState,
    this.odometerParameters,
    this.valueGradient,
    this.clockTime,
    this.lcdTitleStrings,
  });

  LedColorEnum ledColorWithDefault(LedColorEnum defaultLedColorEnum) {
    return ledColor ?? defaultLedColorEnum;
  }

  LedColorEnum userLedColorWithDefault(LedColorEnum defaultUserLedColorEnum) {
    return userLedColor ?? defaultUserLedColorEnum;
  }

  LcdColorEnum lcdColorWithDefault(LcdColorEnum defaultLcdColorEnum) {
    return lcdColor ?? defaultLcdColorEnum;
  }

  double sizeWithDefault(double defaultSize) {
    return size ?? defaultSize;
  }

  double valueWithDefault(double defaultValue) {
    return value ?? defaultValue;
  }

  double valueAverageWithDefault(double defaultValueAverage) {
    return valueAverage ?? defaultValueAverage;
  }

  double seccondsWithDefault(double defaultSeconds) {
    return seconds ?? defaultSeconds;
  }

  double minValueWithDefault(double defaultMinValue) {
    return minValue ?? defaultMinValue;
  }

  double minMeasuredValueWithDefault(double defaultMinMeasuredValue) {
    return minMeasuredValue ?? defaultMinMeasuredValue;
  }

  double maxValueWithDefault(double defaultMaxValue) {
    return maxValue ?? defaultMaxValue;
  }

  double maxMeasuredValueWithDefault(double defaultMaxMeasuredValue) {
    return maxMeasuredValue ?? defaultMaxMeasuredValue;
  }

  double thresholdWithDefault(double defaultThreshold) {
    return threshold ?? defaultThreshold;
  }

  double pitchWithDefault(double defaultPitch) {
    return pitch ?? defaultPitch;
  }

  double rollWithDefault(double defaultRoll) {
    return roll ?? defaultRoll;
  }

  FrameDesignEnum frameDesignWithDefault(FrameDesignEnum defaultFrameDesign) {
    return frameDesign ?? defaultFrameDesign;
  }

  bool frameVisibleWithDefault(bool defaultFrameVisible) {
    return frameVisible ?? defaultFrameVisible;
  }

  bool backgroundVisibleWithDefault(bool defaultBackgroundVisible) {
    return backgroundVisible ?? defaultBackgroundVisible;
  }

  BackgroundColorEnum backgroundColorWithDefault(BackgroundColorEnum defaultBackgroundColor) {
    return backgroundColor ?? defaultBackgroundColor;
  }

  bool foregroundVisibleWithDefault(bool defaultForegroundVisible) {
    return foregroundVisible ?? defaultForegroundVisible;
  }

  bool lcdVisibleWithDefault(bool defaultLcdVisible) {
    return lcdVisible ?? defaultLcdVisible;
  }

  bool ledVisibleWithDefault(bool defaultLedVisible) {
    return ledVisible ?? defaultLedVisible;
  }

  bool ledOnWithDefault(bool defaultLedOn) {
    return ledOn ?? defaultLedOn;
  }

  bool userLedVisibleWithDefault(bool defaultUserLedVisible) {
    return userLedVisible ?? defaultUserLedVisible;
  }

  bool userLedOnWithDefault(bool defaultUserLedOn) {
    return userLedOn ?? defaultUserLedOn;
  }

  bool lightOnWithDefault(bool defaultLightOn) {
    return lightOn ?? defaultLightOn;
  }

  bool decimalsVisibleWithDefault(bool defaultDecimalsVisible) {
    return decimalsVisible ?? defaultDecimalsVisible;
  }

  bool textOrientationFixedWithDefault(bool defaultTextOrientationFixed) {
    return textOrientationFixed ?? defaultTextOrientationFixed;
  }

  bool unitStringVisibleWithDefault(bool defaultUnitStringVisible) {
    return unitStringVisible ?? defaultUnitStringVisible;
  }

  bool headerStringVisibleWithDefault(bool defaultHeaderStringVisible) {
    return headerStringVisible ?? defaultHeaderStringVisible;
  }

  bool redOnWithDefault(bool defaultRedOn) {
    return redOn ?? defaultRedOn;
  }

  bool yellowOnWithDefault(bool defaultYellowOn) {
    return yellowOn ?? defaultYellowOn;
  }

  bool greenOnWithDefault(bool defaultGreenOn) {
    return greenOn ?? defaultGreenOn;
  }

  bool useColorLabelsWithDefault(bool defaultUseColorLabels) {
    return useColorLabels ?? defaultUseColorLabels;
  }

  ForegroundTypeEnum foregroundTypeWithDefault(ForegroundTypeEnum defaultForegroundType) {
    return foregroundType ?? defaultForegroundType;
  }

  PointerTypeEnum pointerTypeWithDefault(PointerTypeEnum defaultPointerType) {
    return pointerType ?? defaultPointerType;
  }

  PointerTypeEnum pointerTypeAverageWithDefault(PointerTypeEnum defaultPointerTypeAverage) {
    return pointerTypeAverage ?? defaultPointerTypeAverage;
  }

  GaugeTypeEnum gaugeTypeWithDefault(GaugeTypeEnum defaultGaugeType) {
    return gaugeType ?? defaultGaugeType;
  }

  KnobTypeEnum knobTypeWithDefault(KnobTypeEnum defaultKnobType) {
    return knobType ?? defaultKnobType;
  }

  KnobStyleEnum knobStyleWithDefault(KnobStyleEnum defaultKnobStyle) {
    return knobStyle ?? defaultKnobStyle;
  }

  FontTypeEnum fontTypeWithDefault(FontTypeEnum defaultFontType) {
    return fontType ?? defaultFontType;
  }

  ColorEnum colorWithDefault(ColorEnum defaultColor) {
    return color ?? defaultColor;
  }

  ColorEnum valueColorWithDefault(ColorEnum defaultValueColor) {
    return valueColor ?? defaultValueColor;
  }

  ColorEnum pointerColorWithDefault(ColorEnum defaultPointerColor) {
    return pointerColor ?? defaultPointerColor;
  }

  ColorEnum pointerColorAverageWithDefault(ColorEnum defaultPointerColorAverage) {
    return pointerColorAverage ?? defaultPointerColorAverage;
  }

  bool roseVisibleWithDefault(bool defaultRoseVisible) {
    return roseVisible ?? defaultRoseVisible;
  }

  bool degreeScaleWithDefault(bool defaultDegreeScale) {
    return degreeScale ?? defaultDegreeScale;
  }

  bool degreeScaleHalfWithDefault(bool defaultDegreeScaleHalf) {
    return degreeScaleHalf ?? defaultDegreeScaleHalf;
  }

  bool pointSymbolsVisibleWithDefault(bool defaultPointSymbolsVisible) {
    return pointSymbolsVisible ?? defaultPointSymbolsVisible;
  }

  List<String> pointerSymbolsWithDefault(List<String> defaultPointerSymbols) {
    return pointerSymbols ?? defaultPointerSymbols;
  }

  bool rotateFaceWithDefault(bool defaultRotateFace) {
    return rotateFace ?? defaultRotateFace;
  }

  ui.Image? customLayerImage() {
    return customLayer;
  }

  Color degreeFontColorWithDefault(Color defaultDegreeFontColor) {
    return degreeFontColor ?? defaultDegreeFontColor;
  }

  Color glowColorWithDefault(Color defaultGlowColor) {
    return glowColor ?? defaultGlowColor;
  }

  String titleStringWithDefault(String defaultTitleString) {
    return titleString ?? defaultTitleString;
  }

  String unitStringWithDefault(String defaultUnitString) {
    return unitString ?? defaultUnitString;
  }

  String headerStringWithDefault(String defaultHeaderString) {
    return headerString ?? defaultHeaderString;
  }

  String stringValueWithDefault(String defaultStringValue) {
    return stringValue ?? defaultStringValue;
  }

  bool unitAltPositionWithDefault(bool defaultUnitAltPos) {
    return unitAltPos ?? defaultUnitAltPos;
  }

  bool niceScaleWithDefault(bool defaultNiceScale) {
    return niceScale ?? defaultNiceScale;
  }

  int lcdDecimalsWithDefault(int defaultLcdDecimals) {
    return lcdDecimals ?? defaultLcdDecimals;
  }

  int fractionalScaleDecimalsWithDefault(int defaultFractionalScaleDecimals) {
    return fractionalScaleDecimals ?? defaultFractionalScaleDecimals;
  }

  bool thresholdVisibleWithDefault(bool defaultThresholdVisible) {
    return thresholdVisible ?? defaultThresholdVisible;
  }

  bool minMeasuredValueVisibleWithDefault(bool defaultMinMeasuredValueVisible) {
    return minMeasuredValueVisible ?? defaultMinMeasuredValueVisible;
  }

  bool maxMeasuredValueVisibleWithDefault(bool defaultMaxMeasuredValueVisible) {
    return maxMeasuredValueVisible ?? defaultMaxMeasuredValueVisible;
  }

  LabelNumberFormatEnum labelNumberFormatWithDefault(LabelNumberFormatEnum defaultLabelNumberFormat) {
    return labelNumberFormat ?? defaultLabelNumberFormat;
  }

  OrientationEnum orientationWithDefault(OrientationEnum defaultOrientation) {
    return orientation ?? defaultOrientation;
  }

  TickLabelOrientationEnum tickLabelOrientationWithDefault(TickLabelOrientationEnum defaultTickLabelOrientation) {
    return tickLabelOrientation ?? defaultTickLabelOrientation;
  }

  bool trendVisibleWithDefault(bool defaultTrendVisible) {
    return trendVisible ?? defaultTrendVisible;
  }

  List<LedColorEnum> trendColorsWithDefault(List<LedColorEnum> defaultTrendColors) {
    return trendColors ?? defaultTrendColors;
  }

  bool useOdometerWithDefault(bool defaultUseOdometer) {
    return useOdometer ?? defaultUseOdometer;
  }

  OdometerParameters odometerParametersWithDefault(OdometerParameters defaultOdomoterParams) {
    return odometerParameters ?? defaultOdomoterParams;
  }

  TrendStateEnum trendStateWithDefault(TrendStateEnum defaultTrendState) {
    return trendState ?? defaultTrendState;
  }

  bool useSectionColorsWithDefault(bool defaultUseSectionColors) {
    return useSectionColors ?? defaultUseSectionColors;
  }

  bool useValueGradientWithDefault(bool defaultUseValueGradient) {
    return useValueGradient ?? defaultUseValueGradient;
  }

  ClockParameters clockTimeWithDefault(ClockParameters defaultClockTime) {
    return clockTime ?? defaultClockTime;
  }

  List<String> lcdTitleStringsWithDefault(List<String> defaultLcdTitleStrings) {
    return lcdTitleStrings ?? defaultLcdTitleStrings;
  }

  bool secondPointerVisibleWithDefault(bool defaultSecondPointerVisible) {
    return secondPointerVisible ?? defaultSecondPointerVisible;
  }
}

class OdometerParameters {
  double? value;
  double? height;
  int? digits;
  int? decimals;
  Color? decimalBackColor;
  Color? decimalForeColor;
  Color? valueBackColor;
  Color? valueForeColor;
  double? wobbleFactor;

  OdometerParameters({
    this.value,
    this.height,
    this.digits,
    this.decimals,
    this.decimalBackColor,
    this.decimalForeColor,
    this.valueBackColor,
    this.valueForeColor,
    this.wobbleFactor,
  });

  double valueWithDefault(double defaultValue) {
    return value ?? defaultValue;
  }

  double heightWithDefault(double defaultHeight) {
    return height ?? defaultHeight;
  }

  int digitsWithDefault(int defaultDigits) {
    return digits ?? defaultDigits;
  }

  int decimalsWithDefault(int defaultDecimals) {
    return decimals ?? defaultDecimals;
  }

  Color decimalBackColorDefault(Color defaultDecimalBackColor) {
    return decimalBackColor ?? defaultDecimalBackColor;
  }

  Color decimalForeColorDefault(Color defaultDecimalForeColor) {
    return decimalForeColor ?? defaultDecimalForeColor;
  }

  Color valueBackColorDefault(Color defaultValueBackColor) {
    return valueBackColor ?? defaultValueBackColor;
  }

  Color valueForeColorDefault(Color defaultValueForeColor) {
    return valueForeColor ?? defaultValueForeColor;
  }

  double wobbleFactorWithDefault(double defaultWobbleFactor) {
    return wobbleFactor ?? defaultWobbleFactor;
  }
}

class SectionRange {
  final double start;
  final double stop;
  final ColorDef color;

  const SectionRange({required this.start, required this.stop, required this.color});
}

class ClockParameters {
  final int hour;
  final int minute;
  final int second;
  final bool? secondPointerVisible;

  const ClockParameters(this.hour, this.minute, this.second, {this.secondPointerVisible});

  int toSeconds() {
    return hour * 3600 + minute * 60 + second;
  }

  bool secondPointerVisibleWithDefault(bool defaultSecondPointerVisible) {
    return secondPointerVisible ?? defaultSecondPointerVisible;
  }
}
