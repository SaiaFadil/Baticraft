import 'package:flutter/material.dart';
import 'package:baticraft/src/CustomColors.dart';

class CustomShadow {
  static Shadow TextShadow =
      Shadow(color: CustomColors.blackColor, blurRadius: 10);

      static List Allshadow = [
      Shadow(
        offset: Offset(2.0, 2.0),
        blurRadius: 3.0,
        color: Colors.black.withOpacity(0.5),
        
      ),
    ];

      
}
