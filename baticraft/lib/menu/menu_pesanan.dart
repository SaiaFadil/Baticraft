import 'package:flutter/material.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';

class menu_pesanan extends StatefulWidget {
  const menu_pesanan({super.key});

  @override
  State<menu_pesanan> createState() => _menu_pesananState();
}

class _menu_pesananState extends State<menu_pesanan> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            "Pesanan",
            style: CustomText.TextArvoBold(40, CustomColors.blackColor),
          ),
        ),
      ),
    );
  }
}
