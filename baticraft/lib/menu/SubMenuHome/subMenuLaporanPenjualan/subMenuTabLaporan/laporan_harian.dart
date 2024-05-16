import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class laporan_harian extends StatefulWidget {
  const laporan_harian({super.key});

  @override
  State<laporan_harian> createState() => _laporan_harianState();
}

class _laporan_harianState extends State<laporan_harian> {
  late String jsonDataPenjualan = "";
  late List<Map<String, dynamic>> listDataPenjualan = [];

  @override
  void initState() {
    super.initState();
    fetchDataPenjualan();
  }

  String produkTerjual = "0";
  String pembeli = "0";

  Future<void> fetchDataPenjualan() async {
    final response = await http.get(Server.urlLaravel('pendapatanHariIni'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final DateTime date = DateTime.parse(data["date"]);
      final formattedDate = DateFormat('EEEE, dd MMMM yyyy').format(date);
      setState(() {
        jsonDataPenjualan = json.encode([
          {
            "tanggal": formattedDate,
            "tanggalnow": data["date"],
            "totalPendapatan": data["total_revenue"].toString(),
            "produk": data["total_products_sold"].toString(),
            "pembeli": data["total_buyers"].toString(),
          }
        ]);
        listDataPenjualan =
            List<Map<String, dynamic>>.from(json.decode(jsonDataPenjualan));
        produkTerjual = listDataPenjualan[0]['produk'];
        pembeli = listDataPenjualan[0]['pembeli'];
      });
    } else {
      throw Exception('Failed to load data');
    }
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
                                listDataPenjualan.isEmpty
                                    ? "0"
                                    : listDataPenjualan[0]['totalPendapatan'],
                                style: CustomText.TextArvoBold(
                                    30, CustomColors.whiteColor),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              listDataPenjualan.isEmpty
                                  ? ""
                                  : listDataPenjualan[0]['tanggal'],
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
                                            Text(
                                                listDataPenjualan.isEmpty
                                                    ? "0"
                                                    : listDataPenjualan[0]
                                                        ['produk'],
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
                                            Text(
                                                listDataPenjualan.isEmpty
                                                    ? "0"
                                                    : listDataPenjualan[0]
                                                        ['pembeli'],
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
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arvo',
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Tanggal',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arvo',
                  ),
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
              listDataPenjualan.isEmpty ? 0 : listDataPenjualan.length,
              (index) => DataRow(
                cells: <DataCell>[
                  DataCell(Text((index + 1).toString(),
                      style: CustomText.TextArvoBold(
                          14, CustomColors.blackColor))),
                  DataCell(Text(listDataPenjualan[index]['tanggalnow'],
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
