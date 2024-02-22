import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:flutter/material.dart';

class HomeRiwayat extends StatefulWidget {
  const HomeRiwayat({super.key});

  @override
  State<HomeRiwayat> createState() => _HomeRiwayatState();
}

class _HomeRiwayatState extends State<HomeRiwayat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Riwayat",
        style: CustomText.TextArvoBold(40, CustomColors.blackColor),
      )),
    );
  }
}
