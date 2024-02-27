import 'package:flutter/material.dart';

class CS {
  static double Text(BuildContext context) {
      late MediaQueryData mediaQuery= MediaQuery.of(context);
    return mediaQuery.textScaleFactor;
  }
  static MediaQueryData Size(BuildContext context) {
      late MediaQueryData mediaQuery= MediaQuery.of(context);
    return mediaQuery;
  }
}
