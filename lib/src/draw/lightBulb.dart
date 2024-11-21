// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'definitions.dart';
import 'tools.dart';

void drawLightbulb(Canvas canvas, Size canvasSize, Parameters parameters) {
  // parameters
  double width = canvasSize.width;
  double height = canvasSize.height;
  Color glowColor = parameters.glowColorWithDefault(colorFromHex('#ffff00'));
  bool lightOn = parameters.lightOnWithDefault(false);

  var offContextRecorder = ui.PictureRecorder();
  var offCxt = Canvas(offContextRecorder);

  var onContextRecorder = ui.PictureRecorder();
  var onCxt = Canvas(onContextRecorder);

  var bulbContextRecorder = ui.PictureRecorder();
  var bulbCxt = Canvas(bulbContextRecorder);

  // End of variables

  double size = width < height ? width : height;
  double imageWidth = size;
  double imageHeight = size;

  List<int> getColorValues(Color color) {
    return [color.red, color.green, color.blue];
  }

  void drawOff(Canvas ctx) {
    ctx.save();
    Path path = Path();
    path.moveTo(0.289473 * imageWidth, 0.438596 * imageHeight);
    path.cubicTo(
      0.289473 * imageWidth,
      0.561403 * imageHeight,
      0.385964 * imageWidth,
      0.605263 * imageHeight,
      0.385964 * imageWidth,
      0.745614 * imageHeight,
    );
    path.cubicTo(
      0.385964 * imageWidth,
      0.745614 * imageHeight,
      0.587719 * imageWidth,
      0.745614 * imageHeight,
      0.587719 * imageWidth,
      0.745614 * imageHeight,
    );
    path.cubicTo(
      0.587719 * imageWidth,
      0.605263 * imageHeight,
      0.692982 * imageWidth,
      0.561403 * imageHeight,
      0.692982 * imageWidth,
      0.438596 * imageHeight,
    );
    path.cubicTo(
      0.692982 * imageWidth,
      0.324561 * imageHeight,
      0.605263 * imageWidth,
      0.22807 * imageHeight,
      0.5 * imageWidth,
      0.22807 * imageHeight,
    );
    path.cubicTo(
      0.385964 * imageWidth,
      0.22807 * imageHeight,
      0.289473 * imageWidth,
      0.324561 * imageHeight,
      0.289473 * imageWidth,
      0.438596 * imageHeight,
    );
    path.close();

    ui.Gradient glassOffFill = ui.Gradient.linear(
      Offset(0, 0.289473 * imageHeight),
      Offset(0, 0.701754 * imageHeight),
      [
        colorFromHex('#eeeeee'),
        colorFromHex('#999999'),
        colorFromHex('#999999'),
      ],
      [0, 0.99, 1],
    );

    ctx.drawPath(
        path,
        Paint()
          ..shader = glassOffFill
          ..style = ui.PaintingStyle.fill);
    ctx.drawPath(
        path,
        Paint()
          ..color = colorFromHex('#cccccc')
          ..strokeWidth = 0.008771 * imageWidth
          ..strokeCap = ui.StrokeCap.butt
          ..strokeJoin = ui.StrokeJoin.round
          ..style = ui.PaintingStyle.stroke);
    ctx.restore();
  }

  void drawOn(Canvas ctx) {
    List<int> data = getColorValues(glowColor);
    int red = data[0];
    int green = data[1];
    int blue = data[2];
    List<double> hsl = rgbToHsl(red.toDouble(), green.toDouble(), blue.toDouble());

    ctx.save();
    Path path = Path();
    path.moveTo(0.289473 * imageWidth, 0.438596 * imageHeight);
    path.cubicTo(
      0.289473 * imageWidth,
      0.561403 * imageHeight,
      0.385964 * imageWidth,
      0.605263 * imageHeight,
      0.385964 * imageWidth,
      0.745614 * imageHeight,
    );
    path.cubicTo(
      0.385964 * imageWidth,
      0.745614 * imageHeight,
      0.587719 * imageWidth,
      0.745614 * imageHeight,
      0.587719 * imageWidth,
      0.745614 * imageHeight,
    );
    path.cubicTo(
      0.587719 * imageWidth,
      0.605263 * imageHeight,
      0.692982 * imageWidth,
      0.561403 * imageHeight,
      0.692982 * imageWidth,
      0.438596 * imageHeight,
    );
    path.cubicTo(
      0.692982 * imageWidth,
      0.324561 * imageHeight,
      0.605263 * imageWidth,
      0.22807 * imageHeight,
      0.5 * imageWidth,
      0.22807 * imageHeight,
    );
    path.cubicTo(
      0.385964 * imageWidth,
      0.22807 * imageHeight,
      0.289473 * imageWidth,
      0.324561 * imageHeight,
      0.289473 * imageWidth,
      0.438596 * imageHeight,
    );
    path.close();

    late ui.Gradient glassOnFill;

    if (red == green && green == blue) {
      glassOnFill = ui.Gradient.linear(
        Offset(0, 0.289473 * imageHeight),
        Offset(0, 0.701754 * imageHeight),
        [
          const HSLColor.fromAHSL(1, 0, 0.6, 0).toColor(),
          const HSLColor.fromAHSL(1, 0, 0.4, 0).toColor(),
        ],
        [0, 1],
      );
    } else {
      glassOnFill = ui.Gradient.linear(
        Offset(0, 0.289473 * imageHeight),
        Offset(0, 0.701754 * imageHeight),
        [
          HSLColor.fromAHSL(1, hsl[0] * 255, hsl[1], 0.7).toColor(),
          HSLColor.fromAHSL(1, hsl[0] * 255, hsl[1], 0.8).toColor(),
        ],
        [0, 1],
      );
    }

    ctx.drawPath(
        path,
        Paint()
          ..shader = glassOnFill
          ..style = ui.PaintingStyle.fill);
    ctx.drawPath(
        path,
        Paint()
          ..color = colorFromHex('#cccccc')
          ..strokeWidth = 0.008771 * imageWidth
          ..strokeCap = ui.StrokeCap.butt
          ..strokeJoin = ui.StrokeJoin.round
          ..style = ui.PaintingStyle.stroke);

    // // sets shadow properties
    // ctx.shadowOffsetX = 0
    // ctx.shadowOffsetY = 0
    // ctx.shadowBlur = 30
    // ctx.shadowColor = glowColor

    ctx.restore();
  }

  void drawBulb(Canvas ctx) {
    ctx.save();
    Path path = Path();
    path.moveTo(0.350877 * imageWidth, 0.333333 * imageHeight);
    path.cubicTo(
      0.350877 * imageWidth,
      0.280701 * imageHeight,
      0.41228 * imageWidth,
      0.236842 * imageHeight,
      0.5 * imageWidth,
      0.236842 * imageHeight,
    );
    path.cubicTo(
      0.578947 * imageWidth,
      0.236842 * imageHeight,
      0.64035 * imageWidth,
      0.280701 * imageHeight,
      0.64035 * imageWidth,
      0.333333 * imageHeight,
    );
    path.cubicTo(
      0.64035 * imageWidth,
      0.385964 * imageHeight,
      0.578947 * imageWidth,
      0.429824 * imageHeight,
      0.5 * imageWidth,
      0.429824 * imageHeight,
    );
    path.cubicTo(
      0.41228 * imageWidth,
      0.429824 * imageHeight,
      0.350877 * imageWidth,
      0.385964 * imageHeight,
      0.350877 * imageWidth,
      0.333333 * imageHeight,
    );
    path.close();

    ui.Gradient highlight = ui.Gradient.linear(
      Offset(0, 0.245614 * imageHeight),
      Offset(0, 0.429824 * imageHeight),
      [
        colorFromHex('#ffffff'),
        const Color.fromRGBO(255, 255, 255, 0),
        const Color.fromRGBO(255, 255, 255, 0),
      ],
      [0, 0.99, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = highlight
          ..style = ui.PaintingStyle.fill);

    ctx.restore();

    // winding
    ctx.save();
    path = Path();
    path.moveTo(0.377192 * imageWidth, 0.745614 * imageHeight);
    path.cubicTo(
      0.377192 * imageWidth,
      0.745614 * imageHeight,
      0.429824 * imageWidth,
      0.72807 * imageHeight,
      0.491228 * imageWidth,
      0.72807 * imageHeight,
    );
    path.cubicTo(
      0.561403 * imageWidth,
      0.72807 * imageHeight,
      0.605263 * imageWidth,
      0.736842 * imageHeight,
      0.605263 * imageWidth,
      0.736842 * imageHeight,
    );
    path.lineTo(0.605263 * imageWidth, 0.763157 * imageHeight);
    path.lineTo(0.596491 * imageWidth, 0.780701 * imageHeight);
    path.lineTo(0.605263 * imageWidth, 0.798245 * imageHeight);
    path.lineTo(0.596491 * imageWidth, 0.815789 * imageHeight);
    path.lineTo(0.605263 * imageWidth, 0.833333 * imageHeight);
    path.lineTo(0.596491 * imageWidth, 0.850877 * imageHeight);
    path.lineTo(0.605263 * imageWidth, 0.868421 * imageHeight);
    path.lineTo(0.596491 * imageWidth, 0.885964 * imageHeight);
    path.lineTo(0.605263 * imageWidth, 0.894736 * imageHeight);
    path.cubicTo(
      0.605263 * imageWidth,
      0.894736 * imageHeight,
      0.570175 * imageWidth,
      0.95614 * imageHeight,
      0.535087 * imageWidth,
      0.991228 * imageHeight,
    );
    path.cubicTo(
      0.526315 * imageWidth,
      0.991228 * imageHeight,
      0.517543 * imageWidth,
      imageHeight,
      0.5 * imageWidth,
      imageHeight,
    );
    path.cubicTo(
      0.482456 * imageWidth,
      imageHeight,
      0.473684 * imageWidth,
      imageHeight,
      0.464912 * imageWidth,
      0.991228 * imageHeight,
    );
    path.cubicTo(
      0.421052 * imageWidth,
      0.947368 * imageHeight,
      0.394736 * imageWidth,
      0.903508 * imageHeight,
      0.394736 * imageWidth,
      0.903508 * imageHeight,
    );
    path.lineTo(0.394736 * imageWidth, 0.894736 * imageHeight);
    path.lineTo(0.385964 * imageWidth, 0.885964 * imageHeight);
    path.lineTo(0.394736 * imageWidth, 0.868421 * imageHeight);
    path.lineTo(0.385964 * imageWidth, 0.850877 * imageHeight);
    path.lineTo(0.394736 * imageWidth, 0.833333 * imageHeight);
    path.lineTo(0.385964 * imageWidth, 0.815789 * imageHeight);
    path.lineTo(0.394736 * imageWidth, 0.798245 * imageHeight);
    path.lineTo(0.377192 * imageWidth, 0.789473 * imageHeight);
    path.lineTo(0.394736 * imageWidth, 0.771929 * imageHeight);
    path.lineTo(0.377192 * imageWidth, 0.763157 * imageHeight);
    path.lineTo(0.377192 * imageWidth, 0.745614 * imageHeight);
    path.close();

    ui.Gradient winding = ui.Gradient.linear(
      Offset(0.473684 * imageWidth, 0.72807 * imageHeight),
      Offset(0.484702 * imageWidth, 0.938307 * imageHeight),
      [
        colorFromHex('#333333'),
        colorFromHex('#d9dad6'),
        colorFromHex('#e4e5e0'),
        colorFromHex('#979996'),
        colorFromHex('#fbffff'),
        colorFromHex('#818584'),
        colorFromHex('#f5f7f4'),
        colorFromHex('#959794'),
        colorFromHex('#f2f2f0'),
        colorFromHex('#828783'),
        colorFromHex('#fcfcfc'),
        colorFromHex('#666666'),
      ],
      [0, 0.04, 0.19, 0.24, 0.31, 0.4, 0.48, 0.56, 0.64, 0.7, 0.78, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = winding
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    // winding
    ctx.save();
    path = Path();
    path.moveTo(0.377192 * imageWidth, 0.745614 * imageHeight);
    path.cubicTo(
      0.377192 * imageWidth,
      0.745614 * imageHeight,
      0.429824 * imageWidth,
      0.72807 * imageHeight,
      0.491228 * imageWidth,
      0.72807 * imageHeight,
    );
    path.cubicTo(
      0.561403 * imageWidth,
      0.72807 * imageHeight,
      0.605263 * imageWidth,
      0.736842 * imageHeight,
      0.605263 * imageWidth,
      0.736842 * imageHeight,
    );
    path.lineTo(0.605263 * imageWidth, 0.763157 * imageHeight);
    path.lineTo(0.596491 * imageWidth, 0.780701 * imageHeight);
    path.lineTo(0.605263 * imageWidth, 0.798245 * imageHeight);
    path.lineTo(0.596491 * imageWidth, 0.815789 * imageHeight);
    path.lineTo(0.605263 * imageWidth, 0.833333 * imageHeight);
    path.lineTo(0.596491 * imageWidth, 0.850877 * imageHeight);
    path.lineTo(0.605263 * imageWidth, 0.868421 * imageHeight);
    path.lineTo(0.596491 * imageWidth, 0.885964 * imageHeight);
    path.lineTo(0.605263 * imageWidth, 0.894736 * imageHeight);
    path.cubicTo(
      0.605263 * imageWidth,
      0.894736 * imageHeight,
      0.570175 * imageWidth,
      0.95614 * imageHeight,
      0.535087 * imageWidth,
      0.991228 * imageHeight,
    );
    path.cubicTo(
      0.526315 * imageWidth,
      0.991228 * imageHeight,
      0.517543 * imageWidth,
      imageHeight,
      0.5 * imageWidth,
      imageHeight,
    );
    path.cubicTo(
      0.482456 * imageWidth,
      imageHeight,
      0.473684 * imageWidth,
      imageHeight,
      0.464912 * imageWidth,
      0.991228 * imageHeight,
    );
    path.cubicTo(
      0.421052 * imageWidth,
      0.947368 * imageHeight,
      0.394736 * imageWidth,
      0.903508 * imageHeight,
      0.394736 * imageWidth,
      0.903508 * imageHeight,
    );
    path.lineTo(0.394736 * imageWidth, 0.894736 * imageHeight);
    path.lineTo(0.385964 * imageWidth, 0.885964 * imageHeight);
    path.lineTo(0.394736 * imageWidth, 0.868421 * imageHeight);
    path.lineTo(0.385964 * imageWidth, 0.850877 * imageHeight);
    path.lineTo(0.394736 * imageWidth, 0.833333 * imageHeight);
    path.lineTo(0.385964 * imageWidth, 0.815789 * imageHeight);
    path.lineTo(0.394736 * imageWidth, 0.798245 * imageHeight);
    path.lineTo(0.377192 * imageWidth, 0.789473 * imageHeight);
    path.lineTo(0.394736 * imageWidth, 0.771929 * imageHeight);
    path.lineTo(0.377192 * imageWidth, 0.763157 * imageHeight);
    path.lineTo(0.377192 * imageWidth, 0.745614 * imageHeight);
    path.close();

    ui.Gradient winding1 = ui.Gradient.linear(
      Offset(0.377192 * imageWidth, 0.789473 * imageHeight),
      Offset(0.605263 * imageWidth, 0.789473 * imageHeight),
      [
        const Color.fromRGBO(0, 0, 0, 0.4),
        const Color.fromRGBO(0, 0, 0, 0.32),
        const Color.fromRGBO(0, 0, 0, 0.33),
        const Color.fromRGBO(0, 0, 0, 0.4),
      ],
      [0, 0.15, 0.85, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = winding1
          ..style = ui.PaintingStyle.fill);
    ctx.restore();

    // contact plate
    ctx.save();
    path = Path();
    path.moveTo(0.421052 * imageWidth, 0.947368 * imageHeight);
    path.cubicTo(
      0.438596 * imageWidth,
      0.95614 * imageHeight,
      0.447368 * imageWidth,
      0.973684 * imageHeight,
      0.464912 * imageWidth,
      0.991228 * imageHeight,
    );
    path.cubicTo(
      0.473684 * imageWidth,
      imageHeight,
      0.482456 * imageWidth,
      imageHeight,
      0.5 * imageWidth,
      imageHeight,
    );
    path.cubicTo(
      0.517543 * imageWidth,
      imageHeight,
      0.526315 * imageWidth,
      0.991228 * imageHeight,
      0.535087 * imageWidth,
      0.991228 * imageHeight,
    );
    path.cubicTo(
      0.543859 * imageWidth,
      0.982456 * imageHeight,
      0.561403 * imageWidth,
      0.95614 * imageHeight,
      0.578947 * imageWidth,
      0.947368 * imageHeight,
    );
    path.cubicTo(
      0.552631 * imageWidth,
      0.938596 * imageHeight,
      0.526315 * imageWidth,
      0.938596 * imageHeight,
      0.5 * imageWidth,
      0.938596 * imageHeight,
    );
    path.cubicTo(
      0.473684 * imageWidth,
      0.938596 * imageHeight,
      0.447368 * imageWidth,
      0.938596 * imageHeight,
      0.421052 * imageWidth,
      0.947368 * imageHeight,
    );
    path.close();

    ui.Gradient contactPlate = ui.Gradient.linear(
      Offset(0, 0.938596 * imageHeight),
      Offset(0, imageHeight),
      [
        colorFromHex('#050a06'),
        colorFromHex('#070602'),
        colorFromHex('#999288'),
        colorFromHex('#010101'),
        colorFromHex('#000000'),
      ],
      [0, 0.61, 0.71, 0.83, 1],
    );
    ctx.drawPath(
        path,
        Paint()
          ..shader = contactPlate
          ..style = ui.PaintingStyle.fill);
    ctx.restore();
  }

  // const clearCanvas = function (ctx) {
  //   // Store the current transformation matrix
  //   ctx.save()

  //   // Use the identity matrix while clearing the canvas
  //   ctx.setTransform(1, 0, 0, 1, 0, 0)
  //   ctx.clearRect(0, 0, ctx.canvas.width, ctx.canvas.height)

  //   // Restore the transform
  //   ctx.restore()
  // }

  void init() {
    drawOff(offCxt);
    drawOn(onCxt);
    drawBulb(bulbCxt);
  }

  // Component visualization
  void repaint() {
    init();

    //clearCanvas(mainCtx)

    canvas.save();

    canvas.drawPicture(offContextRecorder.endRecording());

    //mainCtx.globalAlpha = alpha
    if (lightOn) {
      canvas.drawPicture(onContextRecorder.endRecording());
    }
    //mainCtx.globalAlpha = 1
    canvas.drawPicture(bulbContextRecorder.endRecording());
    canvas.restore();
  }

  repaint();
}
