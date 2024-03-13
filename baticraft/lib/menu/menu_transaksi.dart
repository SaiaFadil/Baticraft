import 'package:baticraft/menu/TabTransaksi/HomeRiwayat.dart';
import 'package:baticraft/menu/TabTransaksi/HomeTransaksi.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';

class menu_transaksi extends StatefulWidget {
  const menu_transaksi({super.key});

  @override
  State<menu_transaksi> createState() => _menu_transaksiState();
}

class _menu_transaksiState extends State<menu_transaksi> {
  late MediaQueryData mediaQuery = MediaQuery.of(context);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: CustomColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.only(top: 35),
        child: DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Material(
                    color: CustomColors.whiteColor,
                    elevation: 5,
                    surfaceTintColor: CustomColors.whiteColor,
                    child: TabBar(
                      tabs: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(40, 8, 20, 8),
                          child: Text(
                            "Transaksi",
                            style: CustomText.TextArvoBold(
                                16 * mediaQuery.textScaleFactor,
                                CustomColors.card1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 8, 40, 8),
                          child: Text(
                            "Riwayat",
                            style: CustomText.TextArvoBold(
                                16 * mediaQuery.textScaleFactor,
                                CustomColors.card1),
                          ),
                        ),
                      ],
                    )),
                Expanded(
                  flex: 1,
                  child: TabBarView(
                    children: [HomeTransaksi(), HomeRiwayat()],
                  ),
                )
              ],
            )),
      ),
    ) // This trailing comma makes auto-formatting nicer for build methods.

        );
  }
}
