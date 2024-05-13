import 'package:baticraft/menu/SubMenuHome/subMenuStatusPesanan/subMenuRiwayat/TabMenuRiwayat/RiwayatProses.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuStatusPesanan/subMenuRiwayat/TabMenuRiwayat/RiwayatSelesai.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuStatusPesanan/subMenuRiwayat/TabMenuRiwayat/RiwayatTolak.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:flutter/material.dart';

class SemuaRiwayat extends StatefulWidget {
  const SemuaRiwayat({super.key});

  @override
  State<SemuaRiwayat> createState() => _SemuaRiwayatState();
}

class _SemuaRiwayatState extends State<SemuaRiwayat>  with SingleTickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 3,
        child: new Scaffold(
          appBar: new PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: new Container(
              color: CustomColors.whiteColor,
              child: new SafeArea(
                child: Column(
                  children: <Widget>[
                    new Expanded(child: new Container()),
                    new TabBar(
                      tabs: [new Text("Proses",style: CustomText.TextArvoBold(16, CustomColors.secondaryColor),), new Text("Tolak",style: CustomText.TextArvoBold(16, CustomColors.secondaryColor)), new Text("Selesai",style: CustomText.TextArvoBold(16, CustomColors.secondaryColor))],
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: new TabBarView(
            children: <Widget>[
              RiwayatProses(),
              RiwayatTolak(),
              RiwayatSelesai()
            ],
          ),
        ),
      
    );
  }
}

