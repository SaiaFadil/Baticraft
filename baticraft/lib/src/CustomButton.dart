import 'package:flutter/material.dart';

class CustomButton {
  static ButtonStyle DefaultButton(Color backgroundColor){
    return ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(10),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.fromLTRB(50, 12, 50, 12)),
          backgroundColor:
              MaterialStateProperty.all<Color>(backgroundColor),
        );
   
   
}
  static ButtonStyle NewModel(Color backgroundColor){
    return ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(10),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.fromLTRB(20, 10, 20, 10)),
          backgroundColor:
              MaterialStateProperty.all<Color>(backgroundColor),
        );
   
   
}
}