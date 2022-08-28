
import 'package:clean_architecture_app/presentation/resources/font_manager.dart';
import 'package:flutter/cupertino.dart';

TextStyle _getTextStyle(double fontSize, String fontFamily, Color color, FontWeight fontWeight){
  return TextStyle(fontSize: fontSize, fontFamily: fontFamily, color: color, fontWeight: fontWeight);
}

/// Regular Style
TextStyle getRegularStyle({double fontSize = FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, color, FontWeightManager.regular);
}

/// Light Style
TextStyle getLightStyle({double fontSize = FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, color, FontWeightManager.light);
}

/// Bold Style
TextStyle getBoldStyle({double fontSize = FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, color, FontWeightManager.bold);
}

/// semiBold Style
TextStyle getSemiBoldStyle({double fontSize = FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, color, FontWeightManager.semiBold);
}

/// medium Style
TextStyle getMediumStyle({double fontSize = FontSize.s12, required Color color}){
  return _getTextStyle(fontSize, FontConstants.fontFamily, color, FontWeightManager.medium);
}