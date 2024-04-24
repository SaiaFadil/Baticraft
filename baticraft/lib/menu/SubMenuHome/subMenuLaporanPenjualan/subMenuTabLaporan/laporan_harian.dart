import 'dart:convert';

import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';

class laporan_harian extends StatefulWidget {
  const laporan_harian({super.key});

  @override
  State<laporan_harian> createState() => _laporan_harianState();
}

class _laporan_harianState extends State<laporan_harian> {
  @override
  void initState() {
    super.initState();

    showDataPenjualan();
    setState(() {
      showDataPenjualan();
    });
  }

  String jsonDataPenjualan = """[
    {"tanggal": "01/03/2024", "totalPendapatan": "550000"},
    {"tanggal": "01/03/2024", "totalPendapatan": "550000"},
    {"tanggal": "01/03/2024", "totalPendapatan": "550000"}
  ]""";
  List<Map<String, dynamic>> listDataPenjualan = [];
  Future<void> showDataPenjualan() async {
    listDataPenjualan =
        List<Map<String, dynamic>>.from(json.decode(jsonDataPenjualan));

    print("panjang data = " + listDataPenjualan.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 130,
                  margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Card(color: CustomColors.threertyColor),
                ),
                Container(
                  width: double.infinity,
                  height: 140,
                  margin: EdgeInsets.fromLTRB(15, 35, 15, 10),
                  child: Card(
                    color: CustomColors.secondaryColor,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Server.urlGambar(
                                  "ic_money.png",
                                ),
                                height: 25,
                                width: 25,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Pendapatan Hari Ini",
                                style: CustomText.TextArvoBold(
                                    16, CustomColors.whiteColor),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Rp",
                                style: CustomText.TextArvoBold(
                                    30, CustomColors.whiteColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "550.000",
                                style: CustomText.TextArvoBold(
                                    30, CustomColors.whiteColor),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Jumat, 01 Maret 2024",
                              style: CustomText.TextArvo(
                                  14, CustomColors.whiteColor),
                            ),
                          )
                        ]),
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            child: Card(
              color: CustomColors.hintprimary,
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    children: [
                      Image.asset(
                        Server.urlGambar("ic_grafik.png"),
                        height: 200,
                        width: 300,
                        fit: BoxFit.contain,
                      ),
                      Container(
                        color: CustomColors.whiteColor,
                        height: 2,
                        width: double.infinity,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Card(
                              color: CustomColors.whiteColor,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Produk Terjual Hari Ini",
                                            style: CustomText.TextArvoBold(12,
                                                CustomColors.threertyColor)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("23",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: CustomText
                                                    .TextArvoBoldItalic(
                                                        30,
                                                        CustomColors
                                                            .blackColor)),
                                            SizedBox(width: 5),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Text("pcs",
                                                  style: CustomText.TextArvo(18,
                                                      CustomColors.blackColor)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Card(
                              color: CustomColors.whiteColor,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Pembeli Hari Ini",
                                            style: CustomText.TextArvoBold(12,
                                                CustomColors.threertyColor)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("243",
                                                style: CustomText
                                                    .TextArvoBoldItalic(
                                                        30,
                                                        CustomColors
                                                            .blackColor)),
                                            SizedBox(width: 5),
                                            Padding(
                                              padding: EdgeInsets.only(top: 10),
                                              child: Text("orang  ",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: CustomText.TextArvo(18,
                                                      CustomColors.blackColor)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                            top: 25,
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: ElevatedButton(
                              style: CustomButton.DefaultButton(
                                  CustomColors.greenColor),
                              child: Text(
                                "Ekspor",
                                style: CustomText.TextArvoBold(
                                    16, CustomColors.whiteColor),
                              ),
                              onPressed: () {},
                            ),
                          )),
                    ],
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              "Data Penjualan",
              style: CustomText.TextArvoBold(20, CustomColors.blackColor),
            ),
          ),
          Container(
            height: 2,
            width: double.infinity,
            color: CustomColors.secondaryColor,
            margin: EdgeInsets.symmetric(horizontal: 20),
          ),
          DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'No.',
                  style: TextStyle( fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arvo',),
                ),
              ),
              DataColumn(
                label: Text(
                  'Tanggal',
                  style: TextStyle( fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arvo',),
                ),
              ),
              DataColumn(
                label: Text(
                  'Total Pendapatan',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arvo',
                  ),
                ),
              ),
            ],
            rows: List<DataRow>.generate(
              listDataPenjualan.length,
              (index) => DataRow(
                cells: <DataCell>[
                  DataCell(Text((index + 1).toString(),
                      style: CustomText.TextArvoBold(
                          14, CustomColors.blackColor))),
                  DataCell(Text(listDataPenjualan[index]['tanggal'],
                      style: CustomText.TextArvoBold(
                          14, CustomColors.blackColor))),
                  DataCell(Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Rp ",
                          style: CustomText.TextArvoBold(
                              14, CustomColors.blackColor)),
                      Text(
                          listDataPenjualan[index]['totalPendapatan']
                              .toString(),
                          style: CustomText.TextArvoBold(
                              14, CustomColors.blackColor))
                    ],
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          )
        ],
      )),
    );
  }
}
