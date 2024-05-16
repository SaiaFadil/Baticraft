import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';

import 'package:http/http.dart' as http;

class laporan_bulanan extends StatefulWidget {
  const laporan_bulanan({super.key});

  @override
  State<laporan_bulanan> createState() => _laporan_bulananState();
}

class _laporan_bulananState extends State<laporan_bulanan> {
  String? _tahunSelected;
  String pendapatan = "0";
  String produk = "0";
  String pembeli = "0";

  List<String> _listTahun =
      List.generate(10, (index) => (2024 + index).toString());

  List<Map<String, dynamic>> _listDataPenjualan = [];
  List<Map<String, dynamic>> listDataUtama = [];
  @override
  void initState() {
    super.initState();
    _tahunSelected = _listTahun.first; // Set tahun awal saat inisialisasi
    _fetchDataPenjualan();
  }

  DateTime? year;
  late String jsonDataPenjualan = "";
  Future<void> _fetchDataPenjualan() async {
    final response = await http.post(
      Server.urlLaravel('pendapatanBulanan'),
      body: {
        'year': _tahunSelected.toString().isEmpty
            ? DateTime.now().year
            : _tahunSelected.toString(),
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        jsonDataPenjualan = json.encode([
          {
            "totalPendapatan": data["pendapatanTahunIni"].toString(),
            "produk": data["ProdukTerjualBulanIni"].toString(),
            "pembeli": data["pembeliBulanIni"].toString(),
          }
        ]);
        _listDataPenjualan = List<Map<String, dynamic>>.from(data['data']);
        listDataUtama =
              List<Map<String, dynamic>>.from(json.decode(jsonDataPenjualan));
        pendapatan = listDataUtama[0]['totalPendapatan'];
          produk = listDataUtama[0]['produk'];
          pembeli = listDataUtama[0]['pembeli'];
      });
    } else {
      print("ERRORRv: " + response.statusCode.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  margin: EdgeInsets.only(top: 20, left: 20),
                  width: 120,
                  height: 40,
                  child: Card(
                    color: CustomColors.whiteColor,
                    surfaceTintColor: CustomColors.whiteColor,
                    elevation: 5,
                    borderOnForeground: true,
                    shadowColor: CustomColors.secondaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      side: BorderSide(
                        color: CustomColors.secondaryColor,
                        width: 2,
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: DropdownButton<String>(
                        hint: Text(
                          "Pilih",
                          style: CustomText.TextArvoBold(
                              16, CustomColors.blackColor),
                        ),
                        value: _tahunSelected,
                        icon: Icon(Icons.arrow_drop_down,
                            color: CustomColors.blackColor),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(
                            color: CustomColors.blackColor, fontSize: 18),
                        underline: Container(
                          height: 0,
                          color: CustomColors.whiteColor,
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            _tahunSelected = newValue;
                            _fetchDataPenjualan(); // Ambil data saat tahun berubah
                            print("Tahun yang dipilih: $_tahunSelected");
                          });
                        },
                        items: _listTahun.map((tahun) {
                          return DropdownMenuItem<String>(
                            value: tahun,
                            child: Text(
                              tahun,
                              style: CustomText.TextArvoBold(
                                  16, CustomColors.blackColor),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ))),
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
                  height: 120,
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
                                "Pendapatan",
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
                                pendapatan,
                                style: CustomText.TextArvoBold(
                                    30, CustomColors.whiteColor),
                              )
                            ],
                          ),
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
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Text(
                                              "Produk Terjual\nBulan Ini",
                                              textAlign: TextAlign.center,
                                              style: CustomText.TextArvoBold(12,
                                                  CustomColors.threertyColor)),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(produk,
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
                                        Text("Pembeli Bulan Ini\n ",
                                            style: CustomText.TextArvoBold(12,
                                                CustomColors.threertyColor)),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(pembeli,
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
                  'Bulan',
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
              _listDataPenjualan.length,
              (index) => DataRow(
                cells: <DataCell>[
                  DataCell(Text((index + 1).toString(),
                      style: CustomText.TextArvoBold(
                          14, CustomColors.blackColor))),
                  DataCell(Text(_listDataPenjualan[index]['bulan'],
                      style: CustomText.TextArvoBold(
                          14, CustomColors.blackColor))),
                  DataCell(Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Rp ",
                          style: CustomText.TextArvoBold(
                              14, CustomColors.blackColor)),
                      Text(
                          _listDataPenjualan[index]['total_pendapatan']
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
