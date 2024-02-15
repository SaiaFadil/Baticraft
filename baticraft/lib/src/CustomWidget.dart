import 'package:flutter/material.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';

class CustomWidget {
 

  static InkWell KolomPencarian(OnTap){
return InkWell(
                onTap: OnTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                                "Cari",
                                style: CustomText.TextArvo(
                                    20, CustomColors.primaryColor),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Image.asset("assets/images/ic_cari.png")),
                    )
                  ],
                )
              );
}}
