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

  static TextStyle TextChewyItalic(double fontSize,Color colors) {
    return TextStyle(
      fontSize: fontSize,
      fontStyle: FontStyle.italic,
      fontFamily: 'Chewy',
      color: colors,
    );
  }
}
