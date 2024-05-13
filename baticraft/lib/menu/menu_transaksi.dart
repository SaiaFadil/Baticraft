import 'package:baticraft/menu/TabTransaksi/HomeRiwayat.dart';
import 'package:baticraft/menu/TabTransaksi/HomeTransaksi.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';

import 'package:baticraft/src/Server.dart';

class menu_transaksi extends StatefulWidget {
  const menu_transaksi({super.key});

  @override
  State<menu_transaksi> createState() => _menu_transaksiState();
}

class _menu_transaksiState extends State<menu_transaksi> {
  late MediaQueryData mediaQuery = MediaQuery.of(context);
  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    return Scaffold(
        backgroundColor: CustomColors.whiteColor,
        body: Stack(fit: StackFit.expand, children: [
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: Image.asset(Server.urlGambar("lingkaran.png")),
          ),
          Positioned(
              top: 70,
              left: 15,
              right: 15,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 300,
                      width: double.infinity,
                      child: Card(
                        margin: EdgeInsets.only(top: 60, bottom: 10),
                        color: CustomColors.secondaryColor,
                        surfaceTintColor: CustomColors.primaryColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          style: CustomButton.DefaultButton(
                              CustomColors.secondaryColor),
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      HomeTransaksi(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                        opacity: animation, child: child);
                                  },
                                ));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Image.asset(
                                  Server.urlGambar("imgtr1.png"),
                                  height: 150,
                                  alignment: Alignment.center,
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "TRANSAKSI",
                                      style: CustomText.TextArvoBoldShadow(
                                          22, CustomColors.whiteColor),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )),
                  Container(
                      height: 300,
                      width: double.infinity,
                      child: Card(
                        margin: EdgeInsets.only(top: 30, bottom: 40),
                        color: CustomColors.secondaryColor,
                        surfaceTintColor: CustomColors.primaryColor,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      HomeRiwayat(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return FadeTransition(
                                        opacity: animation, child: child);
                                  },
                                ));
                          },
                          style: CustomButton.DefaultButton(
                              CustomColors.secondaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(0),
                            child: Column(
                              children: [
                                Image.asset(
                                  Server.urlGambar("imgtr2.png"),
                                  height: 150,
                                  alignment: Alignment.center,
                                ),
                                Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        "RIWAYAT TRANSAKSI",
                                        style: CustomText.TextArvoBoldShadow(
                                            22, CustomColors.whiteColor),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      )),
                ],
              ))
        ]));

    // return Scaffold(
    //     body: Container(
    //   color: CustomColors.whiteColor,
    //   child: Padding(
    //     padding: EdgeInsets.only(top: 35),
    //     child: DefaultTabController(
    //         length: 3,
    //         child: Column(
    //           children: [
    //             Material(
    //                 color: CustomColors.whiteColor,
    //                 elevation: 5,
    //                 surfaceTintColor: CustomColors.whiteColor,
    //                 child: TabBar(
    //                   tabs: [
    //                     Padding(
    //                       padding: const EdgeInsets.fromLTRB(40, 8, 20, 8),
    //                       child: Text(
    //                         "Transaksi",
    //                         style: CustomText.TextArvoBold(
    //                             16 * mediaQuery.textScaleFactor,
    //                             CustomColors.card1),
    //                       ),
    //                     ),
    //                     Padding(
    //                       padding: const EdgeInsets.fromLTRB(20, 8, 40, 8),
    //                       child: Text(
    //                         "Riwayat",
    //                         style: CustomText.TextArvoBold(
    //                             16 * mediaQuery.textScaleFactor,
    //                             CustomColors.card1),
    //                       ),
    //                     ),
    //                   ],
    //                 )),
    //             Expanded(
    //               flex: 1,
    //               child: TabBarView(
    //                 children: [HomeTransaksi(), HomeRiwayat()],
    //               ),
    //             )
    //           ],
    //         )),
    //   ),
    // ) // This trailing comma makes auto-formatting nicer for build methods.

    //     );
  }
}
