import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

//Color declarations
Color fleshColor = HexColor('DCD6B9');
Color blueColor = HexColor('283344');
Color blackColor = HexColor('000000');
Color greyColor = HexColor('c7c7c7');