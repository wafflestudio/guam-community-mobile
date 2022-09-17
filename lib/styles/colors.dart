import 'dart:ui';

import 'package:hexcolor/hexcolor.dart';

class HexColorToColor extends Color {
  static int _getColorFromHex(String hexColor) {
    return int.parse(hexColor, radix: 16);
  }
  HexColorToColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class GuamColorFamily {
  static HexColor grayscaleGray1 = HexColor('#1D1D1D');
  static HexColor grayscaleGray2 = HexColor('#4E4E4E');
  static HexColor grayscaleGray3 = HexColor('#767676');
  static HexColor grayscaleGray4 = HexColor('#A0A0A0');
  static HexColor grayscaleGray5 = HexColor('#C5C5C5');
  static HexColor grayscaleGray6 = HexColor('#E1E1E1');
  static HexColor grayscaleGray7 = HexColor('#F2F2F2');
  static HexColor grayscaleGray8 = HexColor('#FDFDFD');
  static HexColor grayscaleWhite = HexColor('#FFFFFF');

  static HexColor purpleCore = HexColor('#6951FF');
  static HexColor purpleDark1 = HexColor('#5038E3');
  static HexColor purpleLight1 = HexColor('#9F8FFF');
  static HexColor purpleLight2 = HexColor('#E5E1FF');
  static HexColor purpleLight3 = HexColor('#F9F8FF');

  static HexColor blueCore = HexColor('#5483F1');

  static HexColor pinkCore = HexColor('#E874F2');

  static HexColor greenCore = HexColor('#75D973');

  static HexColor orangeCore = HexColor('#F3B962');

  static HexColor redCore = HexColor('#F37462');

  static HexColor fuchsiaCore = HexColor('#EF5DA8');

  static HexColor kakaoYellow = HexColor('#FEE500');
}
