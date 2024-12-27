import 'package:flutter/painting.dart';

extension IntColorComponents on Color {
  int get intAlpha => _floatToInt8(a);
  int get intRed => _floatToInt8(r);
  int get intGreen => _floatToInt8(g);
  int get intBlue => _floatToInt8(b);

  int get intValue => intAlpha << 24 | intRed << 16 | intGreen << 8 | intBlue;

  int _floatToInt8(double x) {
    return (x * 255.0).round() & 0xff;
  }
}
