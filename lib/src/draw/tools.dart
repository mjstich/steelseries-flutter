// ignore_for_file: unused_element, prefer_conditional_assignment, constant_identifier_names, non_constant_identifier_names

import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'definitions.dart';

const double HALF_PI = math.pi * 0.5;
const double TWO_PI = math.pi * 2;
const double PI = math.pi;
const double RAD_FACTOR = math.pi / 180;
const double DEG_FACTOR = 180 / math.pi;

Color colorFromHex(String hexRGB, {double opacity = 1.0}) {
  return Color.fromRGBO(
    int.parse(hexRGB.substring(1, 3), radix: 16),
    int.parse(hexRGB.substring(3, 5), radix: 16),
    int.parse(hexRGB.substring(5, 7), radix: 16),
    opacity,
  );
}

// export const ConicalGradient = function (fractions, colors) {
//   const limit = fractions.length - 1
//   let i

//   // Pre-multipy fractions array into range -PI to PI
//   for (i = 0; i <= limit; i++) {
//     fractions[i] = TWO_PI * fractions[i] - PI
//   }

//   this.fillCircle = function (ctx, centerX, centerY, innerX, outerX) {
//     let angle
//     const radius = Math.ceil(outerX)
//     const diameter = radius * 2
//     let x
//     let y
//     let dx
//     let dy
//     let dy2
//     let distance
//     let indx
//     let pixColor

//     // Create pixel array
//     const pixels = ctx.createImageData(diameter, diameter)
//     const alpha = 255

//     for (y = 0; y < diameter; y++) {
//       dy = radius - y
//       dy2 = dy * dy
//       for (x = 0; x < diameter; x++) {
//         dx = x - radius
//         distance = Math.sqrt(dx * dx + dy2)
//         if (distance <= radius && distance >= innerX) {
//           // pixels are transparent by default, so only paint the ones we need
//           angle = Math.atan2(dx, dy)
//           for (i = 0; i < limit; i++) {
//             if (angle >= fractions[i] && angle < fractions[i + 1]) {
//               pixColor = getColorFromFraction(
//                 colors[i],
//                 colors[i + 1],
//                 fractions[i + 1] - fractions[i],
//                 angle - fractions[i],
//                 true
//               )
//             }
//           }
//           // The pixel array is addressed as 4 elements per pixel [r,g,b,a]
//           // plot is 180 rotated from orginal method, so apply a simple invert (diameter - y)
//           indx = (diameter - y) * diameter * 4 + x * 4
//           pixels.data[indx] = pixColor[0]
//           pixels.data[indx + 1] = pixColor[1]
//           pixels.data[indx + 2] = pixColor[2]
//           pixels.data[indx + 3] = alpha
//         }
//       }
//     }

//     // Create a new buffer to apply the raw data so we can rotate it
//     const buffer = createBuffer(diameter, diameter)
//     const bufferCtx = buffer.getContext('2d')
//     bufferCtx.putImageData(pixels, 0, 0)
//     // Apply the image buffer
//     ctx.drawImage(buffer, centerX - radius, centerY - radius)
//   }

//   this.fillRect = function (
//     ctx,
//     centerX,
//     centerY,
//     width,
//     height,
//     thicknessX,
//     thicknessY
//   ) {
//     let angle
//     let x
//     let y
//     let dx
//     let dy
//     let indx
//     let pixColor

//     width = Math.ceil(width)
//     height = Math.ceil(height)
//     const width2 = width / 2
//     const height2 = height / 2
//     thicknessX = Math.ceil(thicknessX)
//     thicknessY = Math.ceil(thicknessY)

//     // Create pixel array
//     const pixels = ctx.createImageData(width, height)
//     const alpha = 255

//     for (y = 0; y < height; y++) {
//       dy = height2 - y
//       for (x = 0; x < width; x++) {
//         if (y > thicknessY && y <= height - thicknessY) {
//           // we are in the range where we only draw the sides
//           if (x > thicknessX && x < width - thicknessX) {
//             // we are in the empty 'middle', jump to the next edge
//             x = width - thicknessX
//           }
//         }
//         dx = x - width2
//         angle = Math.atan2(dx, dy)
//         for (i = 0; i < limit; i++) {
//           if (angle >= fractions[i] && angle < fractions[i + 1]) {
//             pixColor = getColorFromFraction(
//               colors[i],
//               colors[i + 1],
//               fractions[i + 1] - fractions[i],
//               angle - fractions[i],
//               true
//             )
//           }
//         }
//         // The pixel array is addressed as 4 elements per pixel [r,g,b,a]
//         // plot is 180 rotated from orginal method, so apply a simple invert (height - y)
//         indx = (height - y) * width * 4 + x * 4
//         pixels.data[indx] = pixColor[0]
//         pixels.data[indx + 1] = pixColor[0]
//         pixels.data[indx + 2] = pixColor[0]
//         pixels.data[indx + 3] = alpha
//       }
//     }
//     // Create a new buffer to apply the raw data so we can clip it when drawing to canvas
//     const buffer = createBuffer(width, height)
//     const bufferCtx = buffer.getContext('2d')
//     bufferCtx.putImageData(pixels, 0, 0)

//     // draw the buffer back to the canvas
//     ctx.drawImage(buffer, centerX - width2, centerY - height2)
//   }
// }

class GradientWrapper {
  final double start;
  final double end;
  final List<double> fractions;
  final List<Color> colors;

  GradientWrapper(this.start, this.end, this.fractions, this.colors);

  Color getColorAt(double fraction) {
    double lowerLimit = 0;
    int lowerIndex = 0;
    double upperLimit = 1;
    int upperIndex = 1;
    int i;

    fraction = fraction < 0
        ? 0
        : fraction > 1
            ? 1
            : fraction;

    for (i = 0; i < fractions.length; i++) {
      if (fractions[i] < fraction && lowerLimit < fractions[i]) {
        lowerLimit = fractions[i];
        lowerIndex = i;
      }
      if (fractions[i] == fraction) {
        return colors[i];
      }
      if (fractions[i] > fraction && upperLimit >= fractions[i]) {
        upperLimit = fractions[i];
        upperIndex = i;
      }
    }
    var interpolationFraction =
        (fraction - lowerLimit) / (upperLimit - lowerLimit);
    return getColorFromFraction(
      colors[lowerIndex],
      colors[upperIndex],
      1,
      interpolationFraction,
      false,
    );
  }

  Color getColorFromFraction(Color sourceColor, Color destinationColor,
      double range, double fraction, bool returnRawData) {
    double INT_TO_FLOAT = 1 / 255;
    int sourceRed = sourceColor.red;
    int sourceGreen = sourceColor.green;
    int sourceBlue = sourceColor.blue;
    double sourceAlpha = sourceColor.opacity;

    int deltaRed = destinationColor.red - sourceRed;
    int deltaGreen = destinationColor.green - sourceGreen;
    int deltaBlue = destinationColor.blue - sourceBlue;
    double deltaAlpha =
        destinationColor.opacity * INT_TO_FLOAT - sourceAlpha * INT_TO_FLOAT;

    double fractionRed = (deltaRed / range) * fraction;
    double fractionGreen = (deltaGreen / range) * fraction;
    double fractionBlue = (deltaBlue / range) * fraction;
    double fractionAlpha = (deltaAlpha / range) * fraction;

    returnRawData = returnRawData || false;
    // if (returnRawData) {
    //   // return [
    //   //   (sourceRed + fractionRed).toFixed(0),
    //   //   (sourceGreen + fractionGreen).toFixed(0),
    //   //   (sourceBlue + fractionBlue).toFixed(0),
    //   //   sourceAlpha + fractionAlpha
    //   // ]
    // } else {
    return Color.fromRGBO(
        (sourceRed + fractionRed).toInt(),
        (sourceGreen + fractionGreen).toInt(),
        (sourceBlue + fractionBlue).toInt(),
        sourceAlpha + fractionAlpha);
    //}
  }

  double getStart() {
    return start;
  }

  double getEnd() {
    return end;
  }
}

// Color Function(double fraction) gradientWrapper(int start, int end, List<double> fractions, List<Color> colors) {
//   Color getColorAt(double fraction) {
//     double lowerLimit = 0;
//     int lowerIndex = 0;
//     double upperLimit = 1;
//     int upperIndex = 1;
//     int i;

//     fraction = fraction < 0
//         ? 0
//         : fraction > 1
//             ? 1
//             : fraction;

//     for (i = 0; i < fractions.length; i++) {
//       if (fractions[i] < fraction && lowerLimit < fractions[i]) {
//         lowerLimit = fractions[i];
//         lowerIndex = i;
//       }
//       if (fractions[i] == fraction) {
//         return colors[i];
//       }
//       if (fractions[i] > fraction && upperLimit >= fractions[i]) {
//         upperLimit = fractions[i];
//         upperIndex = i;
//       }
//     }
//     var interpolationFraction = (fraction - lowerLimit) / (upperLimit - lowerLimit);
//     return getColorFromFraction(
//       colors[lowerIndex],
//       colors[upperIndex],
//       1,
//       interpolationFraction,
//       false,
//     );
//   }

//   int getStart() {
//     return start;
//   }

//   int getEnd() {
//     return end;
//   }

//   return getColorAt;
// }

Color getColorFromFraction(Color sourceColor, Color destinationColor,
    double range, double fraction, bool returnRawData) {
  double INT_TO_FLOAT = 1 / 255;
  int sourceRed = sourceColor.red;
  int sourceGreen = sourceColor.green;
  int sourceBlue = sourceColor.blue;
  double sourceAlpha = sourceColor.opacity;

  int deltaRed = destinationColor.red - sourceRed;
  int deltaGreen = destinationColor.green - sourceGreen;
  int deltaBlue = destinationColor.blue - sourceBlue;
  double deltaAlpha =
      destinationColor.opacity * INT_TO_FLOAT - sourceAlpha * INT_TO_FLOAT;

  double fractionRed = (deltaRed / range) * fraction;
  double fractionGreen = (deltaGreen / range) * fraction;
  double fractionBlue = (deltaBlue / range) * fraction;
  double fractionAlpha = (deltaAlpha / range) * fraction;

  returnRawData = returnRawData || false;
  // if (returnRawData) {
  //   // return [
  //   //   (sourceRed + fractionRed).toFixed(0),
  //   //   (sourceGreen + fractionGreen).toFixed(0),
  //   //   (sourceBlue + fractionBlue).toFixed(0),
  //   //   sourceAlpha + fractionAlpha
  //   // ]
  // } else {
  return Color.fromRGBO(
      (sourceRed + fractionRed).toInt(),
      (sourceGreen + fractionGreen).toInt(),
      (sourceBlue + fractionBlue).toInt(),
      sourceAlpha + fractionAlpha);
  //}
}

List<double> getColorFromFractionRaw(Color sourceColor, Color destinationColor,
    double range, double fraction, bool returnRawData) {
  double INT_TO_FLOAT = 1 / 255;
  int sourceRed = sourceColor.red;
  int sourceGreen = sourceColor.green;
  int sourceBlue = sourceColor.blue;
  double sourceAlpha = sourceColor.opacity;

  int deltaRed = destinationColor.red - sourceRed;
  int deltaGreen = destinationColor.green - sourceGreen;
  int deltaBlue = destinationColor.blue - sourceBlue;
  double deltaAlpha =
      destinationColor.opacity * INT_TO_FLOAT - sourceAlpha * INT_TO_FLOAT;

  double fractionRed = (deltaRed / range) * fraction;
  double fractionGreen = (deltaGreen / range) * fraction;
  double fractionBlue = (deltaBlue / range) * fraction;
  double fractionAlpha = (deltaAlpha / range) * fraction;

  returnRawData = returnRawData || false;

  return [
    (sourceRed + fractionRed).toDouble(),
    (sourceGreen + fractionGreen).toDouble(),
    (sourceBlue + fractionBlue).toDouble(),
    sourceAlpha + fractionAlpha
  ];
}

double log10(double value) {
  return math.log(value) / math.ln10;
}

double calcNiceNumber(double range, bool round) {
  int exponent = log10(range).floor(); // exponent of range
  var fraction = range / math.pow(10, exponent); // fractional part of range
  late double niceFraction; // nice, rounded fraction

  if (round) {
    if (fraction < 1.5) {
      niceFraction = 1;
    } else if (fraction < 3) {
      niceFraction = 2;
    } else if (fraction < 7) {
      niceFraction = 5;
    } else {
      niceFraction = 10;
    }
  } else {
    if (fraction <= 1) {
      niceFraction = 1;
    } else if (fraction <= 2) {
      niceFraction = 2;
    } else if (fraction <= 5) {
      niceFraction = 5;
    } else {
      niceFraction = 10;
    }
  }
  return niceFraction * math.pow(10, exponent);
}

Path roundedRectangle(double x, double y, double w, double h, double radius) {
  Path path = Path();
  double r = x + w;
  double b = y + h;

  path.moveTo(x + radius, y);
  path.lineTo(r - radius, y);
  path.quadraticBezierTo(r, y, r, y + radius);
  path.lineTo(r, y + h - radius);
  path.quadraticBezierTo(r, b, r - radius, b);
  path.lineTo(x + radius, b);
  path.quadraticBezierTo(x, b, x, b - radius);
  path.lineTo(x, y + radius);
  path.quadraticBezierTo(x, y, x + radius, y);
  path.close();
  return path;
}

// export function getColorValues (color) {
//   const lookupBuffer = drawToBuffer(1, 1, function (ctx) {
//     ctx.fillStyle = color
//     ctx.beginPath()
//     ctx.rect(0, 0, 1, 1)
//     ctx.fill()
//   })
//   const colorData = lookupBuffer.getContext('2d').getImageData(0, 0, 2, 2).data

//   return [colorData[0], colorData[1], colorData[2], colorData[3]]
// }

ColorDef customColorDef(Color color) {
  //const values = getColorValues(color)
  Color rgbaCol =
      Color.fromRGBO(color.red, color.green, color.blue, color.opacity);

  Color VERY_DARK = darker(rgbaCol, 0.32);
  Color DARK = darker(rgbaCol, 0.62);
  Color LIGHT = lighter(rgbaCol, 0.84);
  Color LIGHTER = lighter(rgbaCol, 0.94);
  Color VERY_LIGHT = lighter(rgbaCol, 1);

  return ColorDef(VERY_DARK, DARK, rgbaCol, LIGHT, LIGHTER, VERY_LIGHT);
}

List<double> rgbToHsl(double red, double green, double blue) {
  double hue;
  double saturation;
  double delta;

  red /= 255;
  green /= 255;
  blue /= 255;

  double max = math.max(math.max(red, green), blue);
  double min = math.min(math.min(red, green), blue);
  double lightness = (max + min) / 2;

  if (max == min) {
    hue = saturation = 0; // achromatic
  } else {
    delta = max - min;
    saturation =
        lightness > 0.5 ? delta / (2 - max - min) : delta / (max + min);
    if (max == red) {
      hue = (green - blue) / delta + (green < blue ? 6 : 0);
    } else if (max == green) {
      hue = (blue - red) / delta + 2;
    } else {
      hue = (red - green) / delta + 4;
    }
    hue /= 6;
  }
  return [hue, saturation, lightness];
}

List<int> hsbToRgb(double hue, double saturation, double brightness) {
  double r = 0;
  double g = 0;
  double b = 0;
  int i = (hue * 6).floor();
  double f = hue * 6 - i;
  double p = brightness * (1 - saturation);
  double q = brightness * (1 - f * saturation);
  double t = brightness * (1 - (1 - f) * saturation);

  switch (i % 6) {
    case 0:
      r = brightness;
      g = t;
      b = p;
      break;
    case 1:
      r = q;
      g = brightness;
      b = p;
      break;
    case 2:
      r = p;
      g = brightness;
      b = t;
      break;
    case 3:
      r = p;
      g = q;
      b = brightness;
      break;
    case 4:
      r = t;
      g = p;
      b = brightness;
      break;
    case 5:
      r = brightness;
      g = p;
      b = q;
      break;
  }

  return [(r * 255).floor(), (g * 255).floor(), (b * 255).floor()];
}

List<double> rgbToHsb(double r, double g, double b) {
  double hue = 0;

  r = r / 255;
  g = g / 255;
  b = b / 255;
  double max = math.max(math.max(r, g), b);
  double min = math.min(math.min(r, g), b);
  double brightness = max;
  double delta = max - min;
  double saturation = max == 0 ? 0 : delta / max;

  if (max == min) {
    hue = 0; // achromatic
  } else {
    if (max == r) {
      hue = (g - b) / delta + (g < b ? 6 : 0);
    } else if (max == g) {
      hue = (b - r) / delta + 2;
    } else if (max == b) {
      hue = (r - g) / delta + 4;
    }
    hue /= 6;

    // switch (max) {
    //   case r:
    //     hue = (g - b) / delta + (g < b ? 6 : 0)
    //     break
    //   case g:
    //     hue = (b - r) / delta + 2
    //     break
    //   case b:
    //     hue = (r - g) / delta + 4
    //     break
    // }
    // hue /= 6
  }
  return [hue, saturation, brightness];
}

int range(int value, int limit) {
  return value < 0
      ? 0
      : value > limit
          ? limit
          : value;
}

double rangeDouble(double value, double limit) {
  return value < 0
      ? 0
      : value > limit
          ? limit
          : value;
}

Color darker(Color color, double fraction) {
  int red = (color.red * (1 - fraction)).floor();
  int green = (color.green * (1 - fraction)).floor();
  int blue = (color.blue * (1 - fraction)).floor();

  red = range(red, 255);
  green = range(green, 255);
  blue = range(blue, 255);

  return Color.fromRGBO(red, green, blue, color.opacity);
}

Color lighter(Color color, double fraction) {
  int red = (color.red * (1 + fraction)).round();
  int green = (color.green * (1 + fraction)).round();
  int blue = (color.blue * (1 + fraction)).round();

  red = range(red, 255);
  green = range(green, 255);
  blue = range(blue, 255);

  return Color.fromRGBO(red, green, blue, color.opacity);
}

double wrap(double value, double lower, double upper) {
  if (upper <= lower) {
    throw Exception('Rotary bounds are of negative or zero size');
  }

  double distance = upper - lower;
  var times = ((value - lower) / distance).floor();

  return value - times * distance;
}

double getShortestAngle(double from, double to) {
  return wrap(to - from, -180, 180);
}

TextStyle getFont(double fontHeight, Color color,
    {FontTypeEnum fontType = FontTypeEnum.RobotoMono, FontWeight? fontWeight}) {
  if (fontType == FontTypeEnum.LCDMono) {
    return TextStyle(
      fontSize: fontHeight,
      fontStyle: FontStyle.normal,
      fontFeatures: const [FontFeature.tabularFigures()],
      fontFamily: 'LCDMono',
      color: color,
      fontWeight: fontWeight,
      //backgroundColor: lcdColor.gradientStopColor,
    );
  } else {
    return TextStyle(
      fontSize: fontHeight,
      fontStyle: FontStyle.normal,
      fontFeatures: const [FontFeature.tabularFigures()],
      fontFamily: 'RobotoMono',
      color: color,
      fontWeight: fontWeight,
      //backgroundColor: lcdColor.gradientStopColor,
    );
  }
}
