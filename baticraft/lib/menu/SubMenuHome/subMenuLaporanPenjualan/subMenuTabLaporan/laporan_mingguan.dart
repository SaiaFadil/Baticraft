import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';

class laporan_mingguan extends StatefulWidget {
  const laporan_mingguan({super.key});

  @override
  State<laporan_mingguan> createState() => _laporan_mingguanState();
}

class _laporan_mingguanState extends State<laporan_mingguan> {
  DateTime? tanggalAwal;
  DateTime? tanggalAkhir;

  @override
  void initState() {
    super.initState();

    showDataPenjualan();
    setState(() {
      showDataPenjualan();
    });
  }

  String jsonDataPenjualan = """[
    {"tanggal": "24/04/2024", "totalPendapatan": "5000000"},
    {"tanggal": "24/04/2024", "totalPendapatan": "5000000"}
  ]""";
  List<Map<String, dynamic>> listDataPenjualan = [];
  Future<void> showDataPenjualan() async {
    listDataPenjualan =
        List<Map<String, dynamic>>.from(json.decode(jsonDataPenjualan));

    print("panjang data = " + listDataPenjualan.length.toString());
  }

  Widget _buildDatePickerContainer(
      {required String labelText,
      required DateTime? selectedDate,
      required Function(DateTime?) onDateSelected}) {
    return Container(
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
        child: GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: selectedDate ?? DateTime.now(),
              firstDate: DateTime(2020),
              lastDate: DateTime(2025),
              locale: const Locale('id'),
              // Set locale to Indonesian
            );
            if (picked != null) {
              onDateSelected(picked);
              print("Tanggal yang dipilih: $picked");
            }
          },
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  labelText,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                Icon(
                  Icons.calendar_today,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final TextEditingController tglAwal = TextEditingController();
  final TextEditingController tglAkhir = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  Future<void> _showDatePicker(BuildContext context, bool isStartDate) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    setState(() {
      if (isStartDate) {
        startDate = picked;
      } else {
        endDate = picked;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () => _showDatePicker(context, true),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomColors.secondaryColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text(
                          startDate != null
                              ? "${startDate!.day}/${startDate!.month}/${startDate!.year}"
                              : "Tanggal Awal",
                          style: CustomText.TextArvoBold(
                              12, CustomColors.blackColor),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.date_range,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  color: CustomColors.blackColor,
                  height: 2,
                  width: 15,
                ),
                SizedBox(width: 8),
                Divider(
                  thickness: 1,
                  color: Colors.grey,
                  height: 24,
                ),
                InkWell(
                  onTap: () => _showDatePicker(context, false),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomColors.secondaryColor),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      children: [
                        Text(
                          endDate != null
                              ? "${endDate!.day}/${endDate!.month}/${endDate!.year}"
                              : "Tanggal Akhir",
                          style: CustomText.TextArvoBold(
                              12, CustomColors.blackColor),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.date_range,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 8),
                InkWell(
                  onTap: (){
                    
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: CustomColors.secondaryColor),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.search,
                        color: CustomColors.secondaryColor,
                        size: 25,
                      )),
                ),
              ],
            ),
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
                                  "5.000.000",
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
                                                "Produk Terjual\nMinggu Ini",
                                                textAlign: TextAlign.center,
                                                style: CustomText.TextArvoBold(
                                                    12,
                                                    CustomColors
                                                        .threertyColor)),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text("23",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: CustomText
                                                      .TextArvoBoldItalic(
                                                          30,
                                                          CustomColors
                                                              .blackColor)),
                                              SizedBox(width: 5),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Text("pcs",
                                                    style: CustomText.TextArvo(
                                                        18,
                                                        CustomColors
                                                            .blackColor)),
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
                                          Text("Pembeli Minggu Ini\n ",
                                              style: CustomText.TextArvoBold(12,
                                                  CustomColors.threertyColor)),
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
                                                padding:
                                                    EdgeInsets.only(top: 10),
                                                child: Text("orang  ",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: CustomText.TextArvo(
                                                        18,
                                                        CustomColors
                                                            .blackColor)),
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
        ),
      )),
    );
  }
}
