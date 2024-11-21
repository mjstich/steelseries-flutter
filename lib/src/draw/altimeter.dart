// ignore_for_file: file_names, non_constant_identifier_names
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import 'createLcdBackgroundImage.dart';
import 'definitions.dart';
import 'drawBackground.dart';
import 'drawFrame.dart';
import 'drawForeground.dart';
import 'drawRadialCustomImage.dart';
import 'drawTitleImage.dart';
import 'tools.dart';

void drawAltimeter(Canvas canvas, Size canvasSize, Parameters parameters) {
  // parameters
  double size =
      parameters.sizeWithDefault(math.min(canvasSize.width, canvasSize.height));
  FrameDesignEnum frameDesign =
      parameters.frameDesignWithDefault(FrameDesignEnum.METAL);
  bool frameVisible = parameters.frameVisibleWithDefault(true);
  BackgroundColorEnum backgroundColor =
      parameters.backgroundColorWithDefault(BackgroundColorEnum.ANTHRACITE);
  bool backgroundVisible = parameters.backgroundVisibleWithDefault(true);
  String titleString = parameters.titleStringWithDefault('');
  String unitString = parameters.unitStringWithDefault('');
  //bool unitAltPos = parameters.unitAltPositionWithDefault(false);
  KnobTypeEnum knobType =
      parameters.knobTypeWithDefault(KnobTypeEnum.METAL_KNOB);
  KnobStyleEnum knobStyle =
      parameters.knobStyleWithDefault(KnobStyleEnum.SILVER);
  LcdColorEnum lcdColor = parameters.lcdColorWithDefault(LcdColorEnum.BLACK);
  bool lcdVisible = parameters.lcdVisibleWithDefault(true);
  FontTypeEnum fontType =
      parameters.fontTypeWithDefault(FontTypeEnum.RobotoMono);
  ForegroundTypeEnum foregroundType =
      parameters.foregroundTypeWithDefault(ForegroundTypeEnum.TYPE4);
  bool foregroundVisible = parameters.foregroundVisibleWithDefault(true);
  ui.Image? customLayer = parameters.customLayer;
  //
  double minValue = 0;
  double maxValue = 10;
  double value = parameters.value ?? minValue;
  double value100 = 0;
  double value1000 = 0;
  double value10000 = 0;
  double angleStep100ft = 0;
  double angleStep1000ft = 0;
  double angleStep10000ft = 0;
  //double tickLabelPeriod = 1; // Draw value at every 10th tickmark
  // Constants
  double TICKMARK_OFFSET = PI;
  //
  // let initialized = false
  // **************   Buffer creation  ********************
  // Buffer for the frame
  var frameContextRecorder = ui.PictureRecorder();
  var frameContext = Canvas(frameContextRecorder);

  // Buffer for the background
  var backgroundContextRecorder = ui.PictureRecorder();
  var backgroundContext = Canvas(backgroundContextRecorder);

  // let lcdBuffer

  // Buffer for 10000ft pointer image painting code
  var pointer10000ContextRecorder = ui.PictureRecorder();
  var pointer10000Context = Canvas(pointer10000ContextRecorder);

  // Buffer for 1000ft pointer image painting code
  var pointer1000ContextRecorder = ui.PictureRecorder();
  var pointer1000Context = Canvas(pointer1000ContextRecorder);

  // Buffer for 100ft pointer image painting code
  var pointer100ContextRecorder = ui.PictureRecorder();
  var pointer100Context = Canvas(pointer100ContextRecorder);

  // Buffer for static foreground painting code
  var foregroundContextRecorder = ui.PictureRecorder();
  var foregroundContext = Canvas(foregroundContextRecorder);
  // End of variables

  // Get the canvas context and clear it
  canvas.save();

  double imageWidth = size;
  double imageHeight = size;

  double centerX = imageWidth / 2;
  double centerY = imageHeight / 2;

  //const unitStringPosY = unitAltPos ? imageHeight * 0.68 : false'
  bool unitStringPosY = false;

  // const stdFont = Math.floor(imageWidth * 0.09) + 'px ' + stdFontName

  // **************   Image creation  ********************
  void drawLcdText(double value) {
    canvas.save();

    if (lcdColor == LcdColorEnum.STANDARD ||
        lcdColor == LcdColorEnum.STANDARD_GREEN) {
      // mainCtx.shadowColor = 'gray'
      // mainCtx.shadowOffsetX = imageWidth * 0.007
      // mainCtx.shadowOffsetY = imageWidth * 0.007
      // mainCtx.shadowBlur = imageWidth * 0.009
    }
    TextStyle stdFont = getFont(
        fontType == FontTypeEnum.LCDMono
            ? (0.1 * imageWidth).floorToDouble()
            : (0.075 * imageWidth).floorToDouble(),
        lcdColor.textColor,
        fontType: fontType);
    var textSpan = TextSpan(
      text: value.round().toString(),
      style: stdFont,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.end,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: imageWidth * 0.4,
    );

    //textPainter.paint(canvas, Offset((imageWidth + imageWidth * 0.4) / 2 - 4, imageWidth * 0.607));

    double lcdWidth = imageWidth * 0.4;
    double endX = centerX + lcdWidth / 2 - textPainter.size.width * 1.1;

    //textPainter.paint(canvas, Offset(endX - (0.048 * imageWidth).floorToDouble() * value.round().toString().length, imageWidth * 0.552));
    textPainter.paint(canvas, Offset(endX, imageWidth * 0.556));

    canvas.restore();
  }

  void drawTickmarksImage(Canvas ctx, double freeAreaAngle, double offset,
      double minVal, double maxVal, double angleStep) {
    double MEDIUM_STROKE = math.max(imageWidth * 0.012, 2);
    double THIN_STROKE = math.max(imageWidth * 0.007, 1.5);
    double TEXT_DISTANCE = imageWidth * 0.12;
    double MED_LENGTH = imageWidth * 0.05;
    double MAX_LENGTH = imageWidth * 0.07;
    double RADIUS = imageWidth * 0.4;
    int counter = 0;
    double sinValue = 0;
    double cosValue = 0;
    double alpha; // angle for tickmarks
    double valueCounter; // value for tickmarks
    double ALPHA_START = -offset - freeAreaAngle / 2;

    ctx.save();
    // ctx.textAlign = 'center'
    // ctx.textBaseline = 'middle'
    // ctx.font = stdFont
    // ctx.strokeStyle = backgroundColor.labelColor.getRgbaColor()
    // ctx.fillStyle = backgroundColor.labelColor.getRgbaColor()

    TextStyle stdFont =
        getFont((0.075 * imageWidth).floorToDouble(), lcdColor.textColor);

    alpha = ALPHA_START;
    valueCounter = 0;
    for (; valueCounter <= 10; alpha -= angleStep * 0.1, valueCounter += 0.1) {
      sinValue = math.sin(alpha);
      cosValue = math.cos(alpha);

      // tickmark every 2 units
      if (counter % 2 == 0) {
        // Draw ticks
        Path path = Path();
        path.moveTo(centerX + (RADIUS - MED_LENGTH) * sinValue,
            centerY + (RADIUS - MED_LENGTH) * cosValue);
        path.lineTo(centerX + RADIUS * sinValue, centerY + RADIUS * cosValue);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = backgroundColor.labelColor
              ..strokeWidth = THIN_STROKE
              ..style = ui.PaintingStyle.stroke);
      }

      // Different tickmark every 10 units
      if (counter == 10 || counter == 0) {
        // if gauge is full circle, avoid painting maxValue over minValue
        if (freeAreaAngle == 0) {
          if (valueCounter.round() != maxValue) {
            var textSpan = TextSpan(
              text: valueCounter.round().toString(),
              style: stdFont,
            );
            final textPainter = TextPainter(
              text: textSpan,
              textAlign: TextAlign.center,
              textDirection: TextDirection.ltr,
            );
            textPainter.layout(
              minWidth: 0,
            );
            textPainter.paint(
              ctx,
              Offset(
                centerX +
                    (RADIUS - TEXT_DISTANCE) * sinValue -
                    (0.020 * imageWidth),
                centerY +
                    (RADIUS - TEXT_DISTANCE) * cosValue -
                    (0.050 * imageWidth),
              ),
            );
          }
        }
        counter = 0;

        // Draw ticks
        Path path = Path();
        path.moveTo(centerX + (RADIUS - MAX_LENGTH) * sinValue,
            centerY + (RADIUS - MAX_LENGTH) * cosValue);
        path.lineTo(centerX + RADIUS * sinValue, centerY + RADIUS * cosValue);
        path.close();
        ctx.drawPath(
            path,
            Paint()
              ..color = backgroundColor.labelColor
              ..strokeWidth = MEDIUM_STROKE
              ..style = ui.PaintingStyle.stroke);
      }
      counter++;
    }
    ctx.restore();
  }

  void draw100ftPointer(Canvas ctx, bool shadow) {
    Paint paint = Paint()..style = ui.PaintingStyle.fill;
    if (shadow) {
      paint.color = const Color.fromRGBO(0, 0, 0, 0.5);
    } else {
      ui.Gradient grad = ui.Gradient.linear(
        Offset(0, imageHeight * 0.168224),
        Offset(0, imageHeight * 0.626168),
        [
          colorFromHex('#ffffff'),
          colorFromHex('#ffffff'),
          colorFromHex('#ffffff'),
          colorFromHex('#202020'),
          colorFromHex('#202020'),
        ],
        [0, 0.31, 0.3101, 0.32, 1],
      );
      paint.shader = grad;
    }

    ctx.save();
    Path path = Path();
    path.moveTo(imageWidth * 0.518691, imageHeight * 0.471962);
    path.cubicTo(
      imageWidth * 0.514018,
      imageHeight * 0.471962,
      imageWidth * 0.509345,
      imageHeight * 0.467289,
      imageWidth * 0.509345,
      imageHeight * 0.467289,
    );
    path.lineTo(imageWidth * 0.509345, imageHeight * 0.200934);
    path.lineTo(imageWidth * 0.5, imageHeight * 0.168224);
    path.lineTo(imageWidth * 0.490654, imageHeight * 0.200934);
    path.lineTo(imageWidth * 0.490654, imageHeight * 0.467289);
    path.cubicTo(
      imageWidth * 0.490654,
      imageHeight * 0.467289,
      imageWidth * 0.481308,
      imageHeight * 0.471962,
      imageWidth * 0.481308,
      imageHeight * 0.471962,
    );
    path.cubicTo(
      imageWidth * 0.471962,
      imageHeight * 0.481308,
      imageWidth * 0.467289,
      imageHeight * 0.490654,
      imageWidth * 0.467289,
      imageHeight * 0.5,
    );
    path.cubicTo(
      imageWidth * 0.467289,
      imageHeight * 0.514018,
      imageWidth * 0.476635,
      imageHeight * 0.528037,
      imageWidth * 0.490654,
      imageHeight * 0.53271,
    );
    path.cubicTo(
      imageWidth * 0.490654,
      imageHeight * 0.53271,
      imageWidth * 0.490654,
      imageHeight * 0.579439,
      imageWidth * 0.490654,
      imageHeight * 0.588785,
    );
    path.cubicTo(
      imageWidth * 0.485981,
      imageHeight * 0.593457,
      imageWidth * 0.481308,
      imageHeight * 0.59813,
      imageWidth * 0.481308,
      imageHeight * 0.607476,
    );
    path.cubicTo(
      imageWidth * 0.481308,
      imageHeight * 0.616822,
      imageWidth * 0.490654,
      imageHeight * 0.626168,
      imageWidth * 0.5,
      imageHeight * 0.626168,
    );
    path.cubicTo(
      imageWidth * 0.509345,
      imageHeight * 0.626168,
      imageWidth * 0.518691,
      imageHeight * 0.616822,
      imageWidth * 0.518691,
      imageHeight * 0.607476,
    );
    path.cubicTo(
      imageWidth * 0.518691,
      imageHeight * 0.59813,
      imageWidth * 0.514018,
      imageHeight * 0.593457,
      imageWidth * 0.504672,
      imageHeight * 0.588785,
    );
    path.cubicTo(
      imageWidth * 0.504672,
      imageHeight * 0.579439,
      imageWidth * 0.504672,
      imageHeight * 0.53271,
      imageWidth * 0.509345,
      imageHeight * 0.53271,
    );
    path.cubicTo(
      imageWidth * 0.523364,
      imageHeight * 0.528037,
      imageWidth * 0.53271,
      imageHeight * 0.514018,
      imageWidth * 0.53271,
      imageHeight * 0.5,
    );
    path.cubicTo(
      imageWidth * 0.53271,
      imageHeight * 0.490654,
      imageWidth * 0.528037,
      imageHeight * 0.481308,
      imageWidth * 0.518691,
      imageHeight * 0.471962,
    );
    path.close();
    ctx.drawPath(path, paint);
    ctx.restore();
  }

  void draw1000ftPointer(Canvas ctx) {
    ui.Gradient grad = ui.Gradient.linear(
      Offset(0, imageHeight * 0.401869),
      Offset(0, imageHeight * 0.616822),
      [
        colorFromHex('#ffffff'),
        colorFromHex('#ffffff'),
        colorFromHex('#ffffff'),
        colorFromHex('#202020'),
        colorFromHex('#202020'),
        colorFromHex('#202020'),
      ],
      [0, 0.51, 0.52, 0.5201, 0.53, 1],
    );

    Path path = Path();
    path.moveTo(imageWidth * 0.518691, imageHeight * 0.471962);
    path.cubicTo(
      imageWidth * 0.514018,
      imageHeight * 0.462616,
      imageWidth * 0.528037,
      imageHeight * 0.401869,
      imageWidth * 0.528037,
      imageHeight * 0.401869,
    );
    path.lineTo(imageWidth * 0.5, imageHeight * 0.331775);
    path.lineTo(imageWidth * 0.471962, imageHeight * 0.401869);
    path.cubicTo(
      imageWidth * 0.471962,
      imageHeight * 0.401869,
      imageWidth * 0.485981,
      imageHeight * 0.462616,
      imageWidth * 0.481308,
      imageHeight * 0.471962,
    );
    path.cubicTo(
      imageWidth * 0.471962,
      imageHeight * 0.481308,
      imageWidth * 0.467289,
      imageHeight * 0.490654,
      imageWidth * 0.467289,
      imageHeight * 0.5,
    );
    path.cubicTo(
      imageWidth * 0.467289,
      imageHeight * 0.514018,
      imageWidth * 0.476635,
      imageHeight * 0.528037,
      imageWidth * 0.490654,
      imageHeight * 0.53271,
    );
    path.cubicTo(
      imageWidth * 0.490654,
      imageHeight * 0.53271,
      imageWidth * 0.462616,
      imageHeight * 0.574766,
      imageWidth * 0.462616,
      imageHeight * 0.593457,
    );
    path.cubicTo(
      imageWidth * 0.467289,
      imageHeight * 0.616822,
      imageWidth * 0.5,
      imageHeight * 0.612149,
      imageWidth * 0.5,
      imageHeight * 0.612149,
    );
    path.cubicTo(
      imageWidth * 0.5,
      imageHeight * 0.612149,
      imageWidth * 0.53271,
      imageHeight * 0.616822,
      imageWidth * 0.537383,
      imageHeight * 0.593457,
    );
    path.cubicTo(
      imageWidth * 0.537383,
      imageHeight * 0.574766,
      imageWidth * 0.509345,
      imageHeight * 0.53271,
      imageWidth * 0.509345,
      imageHeight * 0.53271,
    );
    path.cubicTo(
      imageWidth * 0.523364,
      imageHeight * 0.528037,
      imageWidth * 0.53271,
      imageHeight * 0.514018,
      imageWidth * 0.53271,
      imageHeight * 0.5,
    );
    path.cubicTo(
      imageWidth * 0.53271,
      imageHeight * 0.490654,
      imageWidth * 0.528037,
      imageHeight * 0.481308,
      imageWidth * 0.518691,
      imageHeight * 0.471962,
    );
    path.close();
    ctx.drawPath(
        path,
        Paint()
          ..shader = grad
          ..style = ui.PaintingStyle.fill);
  }

  void draw10000ftPointer(Canvas ctx) {
    Path path = Path();
    path.moveTo(imageWidth * 0.518691, imageHeight * 0.471962);
    path.cubicTo(
      imageWidth * 0.514018,
      imageHeight * 0.471962,
      imageWidth * 0.514018,
      imageHeight * 0.467289,
      imageWidth * 0.514018,
      imageHeight * 0.467289,
    );
    path.lineTo(imageWidth * 0.514018, imageHeight * 0.317757);
    path.lineTo(imageWidth * 0.504672, imageHeight * 0.303738);
    path.lineTo(imageWidth * 0.504672, imageHeight * 0.182242);
    path.lineTo(imageWidth * 0.53271, imageHeight * 0.116822);
    path.lineTo(imageWidth * 0.462616, imageHeight * 0.116822);
    path.lineTo(imageWidth * 0.495327, imageHeight * 0.182242);
    path.lineTo(imageWidth * 0.495327, imageHeight * 0.299065);
    path.lineTo(imageWidth * 0.485981, imageHeight * 0.317757);
    path.lineTo(imageWidth * 0.485981, imageHeight * 0.467289);
    path.cubicTo(
      imageWidth * 0.485981,
      imageHeight * 0.467289,
      imageWidth * 0.485981,
      imageHeight * 0.471962,
      imageWidth * 0.481308,
      imageHeight * 0.471962,
    );
    path.cubicTo(
      imageWidth * 0.471962,
      imageHeight * 0.481308,
      imageWidth * 0.467289,
      imageHeight * 0.490654,
      imageWidth * 0.467289,
      imageHeight * 0.5,
    );
    path.cubicTo(
      imageWidth * 0.467289,
      imageHeight * 0.518691,
      imageWidth * 0.481308,
      imageHeight * 0.53271,
      imageWidth * 0.5,
      imageHeight * 0.53271,
    );
    path.cubicTo(
      imageWidth * 0.518691,
      imageHeight * 0.53271,
      imageWidth * 0.53271,
      imageHeight * 0.518691,
      imageWidth * 0.53271,
      imageHeight * 0.5,
    );
    path.cubicTo(
      imageWidth * 0.53271,
      imageHeight * 0.490654,
      imageWidth * 0.528037,
      imageHeight * 0.481308,
      imageWidth * 0.518691,
      imageHeight * 0.471962,
    );
    path.close();
    ctx.drawPath(
        path,
        Paint()
          ..color = colorFromHex('#ffffff')
          ..style = ui.PaintingStyle.fill);
  }

  void calcAngleStep() {
    angleStep100ft = TWO_PI / (maxValue - minValue);
    angleStep1000ft = angleStep100ft / 10;
    angleStep10000ft = angleStep1000ft / 10;
  }

  void calcValues() {
    value100 = (value % 1000) / 100;
    value1000 = (value % 10000) / 100;
    value10000 = (value % 100000) / 100;
  }

  // **************   Initialization  ********************
  // Draw all static painting code to background
  void init(Parameters parameters) {
    bool drawFrame2 = true;
    bool drawBackground2 = true;
    bool drawPointers = true;
    bool drawForeground2 = true;

    calcAngleStep();

    // Create frame in frame buffer (backgroundBuffer)
    if (drawFrame2 && frameVisible) {
      var framePicture = drawFrame(
        frameDesign,
        centerX,
        centerY,
        imageWidth,
        imageHeight,
      );
      frameContext.drawPicture(framePicture);
    }

    if (drawBackground2 && backgroundVisible) {
      // Create background in background buffer (backgroundBuffer)
      var backgroundPicture = drawBackground(
          backgroundColor, centerX, centerY, imageWidth, imageHeight);
      backgroundContext.drawPicture(backgroundPicture);

      // Create custom layer in background buffer (backgroundBuffer)
      drawRadialCustomImage(backgroundContext, customLayer, centerX, centerY,
          imageWidth, imageHeight);

      // Create tickmarks in background buffer (backgroundBuffer)
      drawTickmarksImage(
        backgroundContext,
        0,
        TICKMARK_OFFSET,
        0,
        10,
        angleStep100ft,
        //tickLabelPeriod,
        // 0,
        // true,
        // true,
        // null
      );

      // Create title in background buffer (backgroundBuffer)
      drawTitleImage(
        backgroundContext,
        imageWidth,
        imageHeight,
        titleString,
        unitString,
        backgroundColor,
        true,
        true,
        unitStringPosY,
        null,
      );
    }

    // Create lcd background if selected in background buffer (backgroundBuffer)
    if (drawBackground2 && lcdVisible) {
      ui.Picture lcdBuffer = createLcdBackgroundImage(
          imageWidth * 0.4, imageHeight * 0.09, lcdColor);
      backgroundContext.save();
      backgroundContext.translate(
          (imageWidth - imageWidth * 0.4) / 2, imageHeight * 0.56);
      backgroundContext.drawPicture(
        lcdBuffer,
      );
      backgroundContext.translate(
          -(imageWidth - imageWidth * 0.4) / 2, -imageHeight * 0.56);
      backgroundContext.restore();
    }

    if (drawPointers) {
      // Create 100ft pointer in buffer
      draw100ftPointer(pointer100Context, false);
      // Create 1000ft pointer in buffer
      draw1000ftPointer(pointer1000Context);
      // Create 10000ft pointer in buffer
      draw10000ftPointer(pointer10000Context);
    }

    if (drawForeground2 && foregroundVisible) {
      ui.Picture foregroundPicture = drawForeground(
        foregroundType,
        imageWidth,
        imageHeight,
        true,
        knobType,
        knobStyle,
        GaugeTypeEnum.TYPE1,
        OrientationEnum.NORTH,
      );
      foregroundContext.drawPicture(foregroundPicture);
    }
  }

  void repaint() {
    init(parameters);
    //   if (!initialized) {
    //     init({
    //       frame: true,
    //       background: true,
    //       led: true,
    //       pointers: true,
    //       foreground: true
    //     })
    //   }

    //canvas.save();
    //   mainCtx.clearRect(0, 0, mainCtx.canvas.width, mainCtx.canvas.height)

    // Draw frame
    if (frameVisible) {
      ui.Picture framePicture = frameContextRecorder.endRecording();
      canvas.drawPicture(framePicture);
    }

    // Draw buffered image to visible canvas
    ui.Picture backgroundPicture = backgroundContextRecorder.endRecording();
    canvas.drawPicture(backgroundPicture);

    // Draw lcd display
    if (lcdVisible) {
      drawLcdText(value);
    }

    // re-calculate the spearate pointer values
    calcValues();

    //ßdouble shadowOffset = imageWidth * 0.006 * 0.5;

    canvas.save();
    // Draw 10000ft pointer
    // Define rotation center
    canvas.translate(centerX, centerY);
    canvas.rotate((value10000 - minValue) * angleStep10000ft);
    canvas.translate(-centerX, -centerY);
    //   // Set the pointer shadow params
    //   mainCtx.shadowColor = 'rgba(0, 0, 0, 0.8)'
    //   mainCtx.shadowOffsetX = mainCtx.shadowOffsetY = shadowOffset
    //   mainCtx.shadowBlur = shadowOffset * 2
    // Draw the pointer
    ui.Picture pointer10000Picture = pointer10000ContextRecorder.endRecording();
    canvas.drawPicture(pointer10000Picture);

    //   shadowOffset = imageWidth * 0.006 * 0.75
    //   mainCtx.shadowOffsetX = mainCtx.shadowOffsetY = shadowOffset

    // Draw 1000ft pointer
    canvas.translate(centerX, centerY);
    canvas.rotate((value1000 - minValue) * angleStep1000ft -
        (value10000 - minValue) * angleStep10000ft);
    canvas.translate(-centerX, -centerY);
    ui.Picture pointer1000Picture = pointer1000ContextRecorder.endRecording();
    canvas.drawPicture(pointer1000Picture);

    //   shadowOffset = imageWidth * 0.006
    //   mainCtx.shadowOffsetX = mainCtx.shadowOffsetY = shadowOffset

    // Draw 100ft pointer
    canvas.translate(centerX, centerY);
    canvas.rotate((value100 - minValue) * angleStep100ft -
        (value1000 - minValue) * angleStep1000ft);
    canvas.translate(-centerX, -centerY);
    ui.Picture pointer100Picture = pointer100ContextRecorder.endRecording();
    canvas.drawPicture(pointer100Picture);
    canvas.restore();

    // Draw the foregound
    if (foregroundVisible) {
      ui.Picture foregroundPicture = foregroundContextRecorder.endRecording();
      canvas.drawPicture(foregroundPicture);
    }
  }

  // Visualize the component
  repaint();

  canvas.restore();
}
