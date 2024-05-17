import 'package:baticraft/src/CustomColors.dart';
import 'package:flutter/material.dart';

class CustomText {
  static TextStyle TextArvo(double fontSize,Color colors) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      fontFamily: 'Arvo',
      color: colors,
    );
  }

  static TextStyle TextChewy(double fontSize,Color colors) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.normal,
      fontFamily: 'Chewy',
      color: colors,
    );
  }

  static TextStyle TextArvoBold(double fontSize,Color colors) {
    return TextStyle(
      
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      fontFamily: 'Arvo',
      color: colors,
      
    );
  }
  static TextStyle TextArvoBoldShadow(double fontSize,Color colors) {
    return TextStyle(
      
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      fontFamily: 'Arvo',
      color: colors,
      shadows: [ Shadow(
        offset: Offset(3.0, 3.0),
        blurRadius: 10.0,
        color: Colors.black.withOpacity(0.5),
        
      ),]
    );
  }

  static TextStyle TextChewyBold(double fontSize,Color colors) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      fontFamily: 'Chewy',
      color: colors,
    );
  }

  static TextStyle TextArvoItalic(double fontSize,Color colors) {
    return TextStyle(
      fontSize: fontSize,
      fontStyle: FontStyle.italic,
      fontFamily: 'Arvo',
      color: colors,
    );
  }
  static TextStyle TextArvoBoldItalic(double fontSize,Color colors) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.italic,
      fontFamily: 'Arvo',
      color: colors,
    );
  }

  static TextStyle TextChewyItalic(double fontSize,Color colors) {
    return TextStyle(
      fontSize: fontSize,
      fontStyle: FontStyle.italic,
      fontFamily: 'Chewy',
      color: colors,
    );
  }


  static TextStyle TextRoboto(double fontSize,Color colors) {
    return TextStyle(
      fontSize: fontSize,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      fontFamily: 'Roboto',
      color: colors,
      letterSpacing: 15.0
    );
  }
}
