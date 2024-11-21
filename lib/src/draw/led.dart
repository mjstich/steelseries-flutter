import 'package:flutter/material.dart';

import 'createLedImage.dart';
import 'definitions.dart';

void drawLed(Canvas canvas, Size size, int state, Parameters parameters) async {
  LedColorEnum ledColor = parameters.ledColorWithDefault(LedColorEnum.RED_LED);

  canvas.save();
  var ledImage = createLedImage(size.width, state, ledColor);
  canvas.drawPicture(ledImage);
  canvas.restore();
}
