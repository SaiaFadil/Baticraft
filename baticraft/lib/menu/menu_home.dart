import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:flutter/material.dart';

class menu_home extends StatefulWidget {
  const menu_home({Key? key}) : super(key: key);
  static String kategori = "";
  static String id_produk = "";
  @override
  State<menu_home> createState() => _MenuHomeState();
}

class _MenuHomeState extends State<menu_home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            "Home",
            style: CustomText.TextArvoBold(40, CustomColors.blackColor),
          ),
        ),
      ),
    );
  }
}
