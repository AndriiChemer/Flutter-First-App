import 'dart:ui';

class ColorTool {
  static Color fromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    return Color(int.parse('FF' + hexColor, radix: 16));
  }
}