import 'package:baticraft/menu/SubMenuHome/subMenuLaporanPenjualan/subMenuTabLaporan/laporan_bulanan.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuLaporanPenjualan/subMenuTabLaporan/laporan_harian.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuLaporanPenjualan/subMenuTabLaporan/laporan_mingguan.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:flutter/material.dart';

class LaporanUtama extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // jumlah tab
      child: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text(
            "Laporan Penjualan",
            style: CustomText.TextArvoBold(
              16,
              CustomColors.threertyColor,
            ),
            textAlign: TextAlign.center,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
            color: CustomColors.secondaryColor,
          ),
          shadowColor: CustomColors.secondaryColor,
          centerTitle: true,
          
          surfaceTintColor: CustomColors.whiteColor,
          bottom: TabBar(
            unselectedLabelColor: CustomColors.secondaryColor,
            labelStyle: CustomText.TextArvoBold(12, CustomColors.secondaryColor),
            tabs: [
              Tab(text: 'Hari'),
              Tab(text: 'Minggu'),
              Tab(text: 'Bulan'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            laporan_harian(),
            laporan_mingguan(),
            laporan_bulanan(),
          ],
        ),
      ),
    );
  }
}
