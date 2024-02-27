import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:flutter/material.dart';

class HomeTransaksi extends StatefulWidget {
  const HomeTransaksi({super.key});

  @override
  State<HomeTransaksi> createState() => _HomeTransaksiState();
}

class _HomeTransaksiState extends State<HomeTransaksi> {


  
  late MediaQueryData mediaQuery= MediaQuery.of(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1, color: CustomColors.HintColor),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  surfaceTintColor: CustomColors.whiteColor,
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                textAlign: TextAlign.center,
                                "Total Harga",
                                style: CustomText.TextArvo(
                                  20* mediaQuery.textScaleFactor,
                                  CustomColors.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 20),
                              child: Text(
                                textAlign: TextAlign.center,
                                "RP 430.000",
                                style: CustomText.TextArvoBold(
                                  40* mediaQuery.textScaleFactor,
                                  CustomColors.blackColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  surfaceTintColor: CustomColors.whiteColor,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "Kode Tr:",
                            style: CustomText.TextArvoBold(
                              16* mediaQuery.textScaleFactor,
                              CustomColors.blackColor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "0001",
                            style: CustomText.TextArvoBold(
                              16* mediaQuery.textScaleFactor,
                              CustomColors.blackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 1),
                  child: Container(
                    color: CustomColors.card1,
                    height: 300,
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
