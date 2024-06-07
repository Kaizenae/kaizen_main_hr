import 'package:flutter/material.dart';

import 'font_manager.dart';

TextStyle _getTextStyle(double fontSize, FontWeight fontWeight, Color color) {
  return TextStyle(
      fontFamily: FontConstants.fontFamily,
      fontWeight: fontWeight,
      color: color,
      fontSize: fontSize);
}

// regular style

TextStyle getRegularStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.regular, color);
}

// medium style

TextStyle getMediumStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.medium, color);
}

// medium style

TextStyle getHeavyStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.heavy, color);
}

// bold style

TextStyle getBoldStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.bold, color);
}

// semiBold style

TextStyle getExtraBoldStyle({double fontSize = 12, required Color color}) {
  return _getTextStyle(fontSize, FontWeightManager.extraBold, color);
}
