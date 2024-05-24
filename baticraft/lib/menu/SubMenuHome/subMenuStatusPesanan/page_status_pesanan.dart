import 'dart:convert';

import 'package:baticraft/menu/SubMenuHome/subMenuStatusPesanan/subMenuPesanan/page_detail_pesanan.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuStatusPesanan/subMenuRiwayat/page_riwayat_semua.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuStatusPesanan/subMenuPesanan/page_list_pesanan.dart';
import 'package:baticraft/menu/TabTransaksi/subMenuTransaksi/transactionManager.dart';
import 'package:baticraft/menu/menu_dashboard.dart';
import 'package:baticraft/navigation/utama.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class StatusPesanan extends StatefulWidget {
  const StatusPesanan({Key? key}) : super(key: key);

  @override
  State<StatusPesanan> createState() => _StatusPesananState();
}

class _StatusPesananState extends State<StatusPesanan> {
  bool pesanan = true;
  bool riwayat = false;
  Color active = CustomColors.threertyColor;
  Color deactive = CustomColors.HintColor;

  Color gantiWarnapesanan() {
    setState(() {
      pesanan = true;
      riwayat = false;
    });
    return pesanan ? active : deactive;
  }

  Color gantiWarnariwayat() {
    setState(() {
      pesanan = false;
      riwayat = true;
    });
    return riwayat ? active : deactive;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: CustomColors.blackColor,
          elevation: 5,
          surfaceTintColor: CustomColors.whiteColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: CustomColors.threertyColor,
            ), // Icon panah di platform iOS
            onPressed: () {
              Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                utama()));
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {});
                  gantiWarnapesanan();
                },
                child: Text("Pesanan",
                    style: CustomText.TextArvoBold(
                        16, pesanan == true ? active : deactive)),
              ),
              Text(" | ",
                  style:
                      CustomText.TextArvoBold(16, CustomColors.threertyColor)),
              InkWell(
                onTap: () {
                  setState(() {});
                  gantiWarnariwayat();
                },
                child: Text("Riwayat",
                    style: CustomText.TextArvoBold(
                        16, riwayat == true ? active : deactive)),
              ),
              SizedBox(
                width: 40,
              ),
            ],
          )),
      body: pesanan == true
          ? list_pesanan()
          : SemuaRiwayat()
    );
  }
}
