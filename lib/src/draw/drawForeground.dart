// ignore_for_file: file_names
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'createKnobImage.dart';
import 'definitions.dart';
import 'tools.dart';

Map<String, ui.Picture> foregroundCache = {};

ui.Picture drawForeground(ForegroundTypeEnum foregroundType, double imageWidth, double imageHeight, bool withCenterKnob, KnobTypeEnum knob, KnobStyleEnum style, GaugeTypeEnum gaugeType, OrientationEnum orientation) {
  double knobSize = (imageHeight * 0.084112).ceilToDouble();
  double knobX = imageWidth * 0.5 - knobSize / 2;
  double knobY = imageHeight * 0.5 - knobSize / 2;
  double shadowOffset = imageWidth * 0.008;
  //String cacheKey = foregroundType.toString() + imageWidth.toString() + imageHeight.toString() + withCenterKnob.toString() + knob.toString() + style.toString() + orientation.toString();

  // check if we have already created and cached this buffer, if so return it and exit
  //if (!foregroundCache.containsKey(cacheKey)) {
  // Setup buffer
  var pictureRecorder = ui.PictureRecorder();
  var canvas = Canvas(pictureRecorder);
  Paint gradHighlight = Paint()..style = ui.PaintingStyle.fill;
  Paint gradHighlight2 = Paint()..style = ui.PaintingStyle.fill;

  // center post
  if (withCenterKnob) {
    // Set the pointer shadow params
    // radFgCtx.shadowColor = 'rgba(0, 0, 0, 0.8)'
    // radFgCtx.shadowOffsetX = radFgCtx.shadowOffsetY = shadowOffset
    // radFgCtx.shadowBlur = shadowOffset * 2

    if (gaugeType == GaugeTypeEnum.TYPE5) {
      if (OrientationEnum.WEST == orientation) {
        knobX = imageWidth * 0.733644 - knobSize / 2;
        canvas.save();
        canvas.translate(knobX, knobY);
        canvas.drawPicture(createKnobImage(knobSize, knob, style));
        canvas.translate(-knobX, -knobY);
        canvas.restore();
      } else if (OrientationEnum.EAST == orientation) {
        knobX = imageWidth * (1 - 0.733644) - knobSize / 2;
        canvas.save();
        canvas.translate(knobX, knobY);
        canvas.drawPicture(createKnobImage(knobSize, knob, style));
        canvas.translate(-knobX, -knobY);
        canvas.restore();
      } else if (OrientationEnum.NORTH == orientation) {
        canvas.save();
        canvas.translate(knobX, knobY);
        canvas.drawPicture(createKnobImage(knobSize, knob, style));
        canvas.translate(-knobX, -knobY);
        canvas.restore();
      } else {
        knobY = imageHeight * 0.733644 - knobSize / 2;
        canvas.save();
        canvas.translate(knobX, knobY);
        canvas.drawPicture(createKnobImage(knobSize, knob, style));
        canvas.translate(-knobX, -knobY);
        canvas.restore();
      }
    } else {
      canvas.save();
      canvas.translate(knobX, knobY);
      canvas.drawPicture(createKnobImage(knobSize, knob, style));
      canvas.translate(-knobX, -knobY);
      canvas.restore();
    }
    // // Undo shadow drawing
    // radFgCtx.shadowOffsetX = radFgCtx.shadowOffsetY = 0
    // radFgCtx.shadowBlur = 0
  }

  // highlight
  switch (foregroundType) {
    case ForegroundTypeEnum.TYPE2:
      Path path = Path();
      path.moveTo(imageWidth * 0.135514, imageHeight * 0.696261);
      path.cubicTo(
        imageWidth * 0.214953,
        imageHeight * 0.588785,
        imageWidth * 0.317757,
        imageHeight * 0.5,
        imageWidth * 0.462616,
        imageHeight * 0.425233,
      );
      path.cubicTo(
        imageWidth * 0.612149,
        imageHeight * 0.345794,
        imageWidth * 0.733644,
        imageHeight * 0.317757,
        imageWidth * 0.873831,
        imageHeight * 0.322429,
      );
      path.cubicTo(
        imageWidth * 0.766355,
        imageHeight * 0.112149,
        imageWidth * 0.528037,
        imageHeight * 0.023364,
        imageWidth * 0.313084,
        imageHeight * 0.130841,
      );
      path.cubicTo(
        imageWidth * 0.09813,
        imageHeight * 0.238317,
        imageWidth * 0.028037,
        imageHeight * 0.485981,
        imageWidth * 0.135514,
        imageHeight * 0.696261,
      );
      path.close();
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0.313084 * imageWidth, 0.135514 * imageHeight),
        Offset(0.495528 * imageWidth, 0.493582 * imageHeight),
        [
          const Color.fromRGBO(255, 255, 255, 0.275),
          const Color.fromRGBO(255, 255, 255, 0.015),
        ],
        [0, 1],
      );
      gradHighlight.shader = grad;
      canvas.drawPath(path, gradHighlight);
      break;

    case ForegroundTypeEnum.TYPE3:
      Path path = Path();
      path.moveTo(imageWidth * 0.084112, imageHeight * 0.509345);
      path.cubicTo(
        imageWidth * 0.21028,
        imageHeight * 0.556074,
        imageWidth * 0.462616,
        imageHeight * 0.560747,
        imageWidth * 0.5,
        imageHeight * 0.560747,
      );
      path.cubicTo(
        imageWidth * 0.537383,
        imageHeight * 0.560747,
        imageWidth * 0.794392,
        imageHeight * 0.560747,
        imageWidth * 0.915887,
        imageHeight * 0.509345,
      );
      path.cubicTo(
        imageWidth * 0.915887,
        imageHeight * 0.2757,
        imageWidth * 0.738317,
        imageHeight * 0.084112,
        imageWidth * 0.5,
        imageHeight * 0.084112,
      );
      path.cubicTo(
        imageWidth * 0.261682,
        imageHeight * 0.084112,
        imageWidth * 0.084112,
        imageHeight * 0.2757,
        imageWidth * 0.084112,
        imageHeight * 0.509345,
      );
      path.close();
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, 0.093457 * imageHeight),
        Offset(0, 0.556073 * imageHeight),
        [
          const Color.fromRGBO(255, 255, 255, 0.275),
          const Color.fromRGBO(255, 255, 255, 0.015),
        ],
        [0, 1],
      );
      gradHighlight.shader = grad;
      canvas.drawPath(path, gradHighlight);
      break;

    case ForegroundTypeEnum.TYPE4:
      Path path = Path();
      path.moveTo(imageWidth * 0.67757, imageHeight * 0.24299);
      path.cubicTo(
        imageWidth * 0.771028,
        imageHeight * 0.308411,
        imageWidth * 0.822429,
        imageHeight * 0.411214,
        imageWidth * 0.813084,
        imageHeight * 0.528037,
      );
      path.cubicTo(
        imageWidth * 0.799065,
        imageHeight * 0.654205,
        imageWidth * 0.719626,
        imageHeight * 0.757009,
        imageWidth * 0.593457,
        imageHeight * 0.799065,
      );
      path.cubicTo(
        imageWidth * 0.485981,
        imageHeight * 0.831775,
        imageWidth * 0.369158,
        imageHeight * 0.808411,
        imageWidth * 0.285046,
        imageHeight * 0.728971,
      );
      path.cubicTo(
        imageWidth * 0.2757,
        imageHeight * 0.719626,
        imageWidth * 0.252336,
        imageHeight * 0.714953,
        imageWidth * 0.233644,
        imageHeight * 0.728971,
      );
      path.cubicTo(
        imageWidth * 0.214953,
        imageHeight * 0.747663,
        imageWidth * 0.219626,
        imageHeight * 0.771028,
        imageWidth * 0.228971,
        imageHeight * 0.7757,
      );
      path.cubicTo(
        imageWidth * 0.331775,
        imageHeight * 0.878504,
        imageWidth * 0.476635,
        imageHeight * 0.915887,
        imageWidth * 0.616822,
        imageHeight * 0.869158,
      );
      path.cubicTo(
        imageWidth * 0.771028,
        imageHeight * 0.822429,
        imageWidth * 0.873831,
        imageHeight * 0.691588,
        imageWidth * 0.88785,
        imageHeight * 0.53271,
      );
      path.cubicTo(
        imageWidth * 0.897196,
        imageHeight * 0.38785,
        imageWidth * 0.836448,
        imageHeight * 0.257009,
        imageWidth * 0.719626,
        imageHeight * 0.182242,
      );
      path.cubicTo(
        imageWidth * 0.705607,
        imageHeight * 0.172897,
        imageWidth * 0.682242,
        imageHeight * 0.163551,
        imageWidth * 0.663551,
        imageHeight * 0.186915,
      );
      path.cubicTo(
        imageWidth * 0.654205,
        imageHeight * 0.205607,
        imageWidth * 0.668224,
        imageHeight * 0.238317,
        imageWidth * 0.67757,
        imageHeight * 0.24299,
      );
      path.close();
      ui.Gradient grad = ui.Gradient.radial(
        Offset(0.5 * imageWidth, 0.5 * imageHeight),
        0,
        [
          const Color.fromRGBO(255, 255, 255, 0),
          const Color.fromRGBO(255, 255, 255, 0),
          const Color.fromRGBO(255, 255, 255, 0),
          const Color.fromRGBO(255, 255, 255, 0.15),
        ],
        <double>[0.0, 0.82, 0.83, 1],
        TileMode.clamp,
        null,
        Offset(0.5 * imageWidth, 0.5 * imageHeight),
        0.38785 * imageWidth,
      );
      gradHighlight.shader = grad;

      path = Path();
      path.moveTo(imageWidth * 0.261682, imageHeight * 0.224299);
      path.cubicTo(
        imageWidth * 0.285046,
        imageHeight * 0.238317,
        imageWidth * 0.252336,
        imageHeight * 0.285046,
        imageWidth * 0.24299,
        imageHeight * 0.317757,
      );
      path.cubicTo(
        imageWidth * 0.24299,
        imageHeight * 0.350467,
        imageWidth * 0.271028,
        imageHeight * 0.383177,
        imageWidth * 0.271028,
        imageHeight * 0.397196,
      );
      path.cubicTo(
        imageWidth * 0.2757,
        imageHeight * 0.415887,
        imageWidth * 0.261682,
        imageHeight * 0.457943,
        imageWidth * 0.238317,
        imageHeight * 0.509345,
      );
      path.cubicTo(
        imageWidth * 0.224299,
        imageHeight * 0.542056,
        imageWidth * 0.17757,
        imageHeight * 0.612149,
        imageWidth * 0.158878,
        imageHeight * 0.612149,
      );
      path.cubicTo(
        imageWidth * 0.144859,
        imageHeight * 0.612149,
        imageWidth * 0.088785,
        imageHeight * 0.546728,
        imageWidth * 0.130841,
        imageHeight * 0.369158,
      );
      path.cubicTo(
        imageWidth * 0.140186,
        imageHeight * 0.336448,
        imageWidth * 0.214953,
        imageHeight * 0.200934,
        imageWidth * 0.261682,
        imageHeight * 0.224299,
      );
      path.close();
      grad = ui.Gradient.linear(
        Offset(0.130841 * imageWidth, 0.369158 * imageHeight),
        Offset(0.273839 * imageWidth, 0.412877 * imageHeight),
        [
          const Color.fromRGBO(255, 255, 255, 0.275),
          const Color.fromRGBO(255, 255, 255, 0.015),
        ],
        [0, 1],
      );
      gradHighlight2.shader = grad;
      canvas.drawPath(path, gradHighlight2);
      break;

    case ForegroundTypeEnum.TYPE5:
      Path path = Path();
      path.moveTo(imageWidth * 0.084112, imageHeight * 0.5);
      path.cubicTo(
        imageWidth * 0.084112,
        imageHeight * 0.271028,
        imageWidth * 0.271028,
        imageHeight * 0.084112,
        imageWidth * 0.5,
        imageHeight * 0.084112,
      );
      path.cubicTo(
        imageWidth * 0.700934,
        imageHeight * 0.084112,
        imageWidth * 0.864485,
        imageHeight * 0.224299,
        imageWidth * 0.906542,
        imageHeight * 0.411214,
      );
      path.cubicTo(
        imageWidth * 0.911214,
        imageHeight * 0.439252,
        imageWidth * 0.911214,
        imageHeight * 0.518691,
        imageWidth * 0.845794,
        imageHeight * 0.537383,
      );
      path.cubicTo(
        imageWidth * 0.794392,
        imageHeight * 0.546728,
        imageWidth * 0.551401,
        imageHeight * 0.411214,
        imageWidth * 0.392523,
        imageHeight * 0.457943,
      );
      path.cubicTo(
        imageWidth * 0.168224,
        imageHeight * 0.509345,
        imageWidth * 0.135514,
        imageHeight * 0.7757,
        imageWidth * 0.093457,
        imageHeight * 0.593457,
      );
      path.cubicTo(
        imageWidth * 0.088785,
        imageHeight * 0.560747,
        imageWidth * 0.084112,
        imageHeight * 0.53271,
        imageWidth * 0.084112,
        imageHeight * 0.5,
      );
      path.close();
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, 0.084112 * imageHeight),
        Offset(0, 0.644859 * imageHeight),
        [
          const Color.fromRGBO(255, 255, 255, 0.275),
          const Color.fromRGBO(255, 255, 255, 0.015),
        ],
        [0, 1],
      );
      gradHighlight.shader = grad;
      canvas.drawPath(path, gradHighlight);
      break;

    case ForegroundTypeEnum.TYPE1:
    /* falls through */
    default:
      Path path = Path();

      path.moveTo(imageWidth * 0.084112, imageHeight * 0.509345);
      path.cubicTo(
        imageWidth * 0.205607,
        imageHeight * 0.448598,
        imageWidth * 0.336448,
        imageHeight * 0.415887,
        imageWidth * 0.5,
        imageHeight * 0.415887,
      );
      path.cubicTo(
        imageWidth * 0.672897,
        imageHeight * 0.415887,
        imageWidth * 0.789719,
        imageHeight * 0.443925,
        imageWidth * 0.915887,
        imageHeight * 0.509345,
      );
      path.cubicTo(
        imageWidth * 0.915887,
        imageHeight * 0.2757,
        imageWidth * 0.738317,
        imageHeight * 0.084112,
        imageWidth * 0.5,
        imageHeight * 0.084112,
      );
      path.cubicTo(
        imageWidth * 0.261682,
        imageHeight * 0.084112,
        imageWidth * 0.084112,
        imageHeight * 0.2757,
        imageWidth * 0.084112,
        imageHeight * 0.509345,
      );
      path.close();
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, 0.088785 * imageHeight),
        Offset(0, 0.490654 * imageHeight),
        [
          const Color.fromRGBO(255, 255, 255, 0.275),
          const Color.fromRGBO(255, 255, 255, 0.015),
        ],
        [0, 1],
      );
      gradHighlight.shader = grad;
      canvas.drawPath(path, gradHighlight);
      break;
  }

  // cache the buffer
  var pic = pictureRecorder.endRecording();
  return pic;
  //foregroundCache[cacheKey] = pic;
  // }
  // return foregroundCache[cacheKey]!;
}
