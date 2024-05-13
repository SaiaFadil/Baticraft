import 'dart:convert';

import 'package:baticraft/menu/SubMenuHome/subMenuStatusPesanan/subMenuRiwayat/TabMenuRiwayat/DetailRiwayatTransaksi/page_detail_ditolak.dart';
import 'package:baticraft/menu/TabTransaksi/subMenuRiwayatTransaksi/page_detail_riwayat_selesai.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class RiwayatTolak extends StatefulWidget {
  const RiwayatTolak({super.key});

  @override
  State<RiwayatTolak> createState() => _RiwayatTolakState();
}

class _RiwayatTolakState extends State<RiwayatTolak> {
  String jsonProdukRiwayat = "{}";
  List<Map<String, dynamic>> listRiwayat = [];
  final TextEditingController cariController = TextEditingController();
  Future<void> showRiwayat() async {
    final response =
        await http.get(Server.urlLaravel("showRiwayatTolak"));
    jsonProdukRiwayat = response.body.toString();
    setState(() {
      listRiwayat =
          List<Map<String, dynamic>>.from(json.decode(jsonProdukRiwayat));
      print("id nya = " + listRiwayat[0]['id'].toString());
    });
  }

  @override
  void initState() {
    showRiwayat();
    // TODO: implement initState
    super.initState();
  }

  Future showPencarian(String searchText) async {
    final response = await http.post(Server.urlLaravel("searchTolak"),
        body: {'search': searchText});
    jsonProdukRiwayat = response.body.toString();
    setState(() {
      listRiwayat =
          List<Map<String, dynamic>>.from(json.decode(jsonProdukRiwayat));
    });
    print(jsonProdukRiwayat);
  }

  String formatTanggal(String tanggal) {
    // Memecah tanggal menjadi bagian-bagian
    List<String> parts = tanggal.split(' ')[0].split('-');
    // Menggabungkan bagian-bagian tersebut dalam format yang diinginkan
    return '${parts[2]}/${parts[1]}/${parts[0]}';
  }

  int nomor = 1;
  Widget KumpulanRiwayat() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: listRiwayat.isEmpty
            ? List.empty()
            : List.generate(
                listRiwayat.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(
                    left: 0,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      String id = listRiwayat[index]['id'].toString();
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    DetailDitolak(transactionId: id),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            }),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                (index + 1).toInt().toString(),
                                textAlign: TextAlign.left,
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor),
                              ),
                              Text(
                                "${listRiwayat[index]['kode_transaksi']}",
                                textAlign: TextAlign.left,
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor),
                              ),
                              Text(
                                formatTanggal(
                                    listRiwayat[index]['tanggal_konfirmasi']),
                                textAlign: TextAlign.left,
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor),
                              ),
                              Card(
                                color: CustomColors.redColor,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 2),
                                  child: Text(
                                    "${listRiwayat[index]['status_transaksi']}",
                                    textAlign: TextAlign.left,
                                    style: CustomText.TextArvoBold(
                                        14, CustomColors.whiteColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            color: CustomColors.HintColor,
                            height: 1,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
                height: 50,
                margin: EdgeInsets.all(10),
                child: Card(
                  surfaceTintColor: CustomColors.whiteColor,
                  borderOnForeground: true,
                  color: CustomColors.whiteColor,
                  semanticContainer: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      side: BorderSide(
                          color: CustomColors.secondaryColor, strokeAlign: 1)),
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: TextField(
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.next,
                      controller: cariController,
                      onChanged: (value) {
                        showRiwayat();
                        if (value.isNotEmpty) {
                          showPencarian(value);
                        } else {
                          showRiwayat();
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari Riwayat...',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10.0),
                      ),
                      style: CustomText.TextArvo(14, CustomColors.blackColor),
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Container(
              color: CustomColors.secondaryColor,
              height: 2,
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "No.",
                    style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                  ),
                  Text(
                    "Kode",
                    style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                  ),
                  Text(
                    "Tanggal",
                    style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                  ),
                  Text(
                    "Status",
                    style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              color: CustomColors.secondaryColor,
              height: 2,
            ),
            SizedBox(
              height: 20,
            ),
            listRiwayat.isNotEmpty ? KumpulanRiwayat() :  Center(child: Text("Tidak Ada Riwayat",style: CustomText.TextArvoBold(18, CustomColors.blackColor),),)
          ]),
        ),
      ),
    );
  }
}
