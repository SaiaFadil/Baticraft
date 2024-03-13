import 'dart:convert';
import 'dart:async';

import 'package:baticraft/page/page_kelola_produk.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';

class MenuDashboard extends StatefulWidget {
  const MenuDashboard({Key? key}) : super(key: key);

  @override
  State<MenuDashboard> createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard> {
  late MediaQueryData mediaQuery = MediaQuery.of(context);

  String jsonPesanan = """[
    {"nomor": 120, "nama": "Fadillah Wahyu"},
    {"nomor": 122, "nama": "Tria Yunita"},
    {"nomor": 121, "nama": "Evita Sianturi"}
  ]""";

  String jsonPesananMasuk = "[]";
  List<Map<String, dynamic>> listPesanan = [];

  Future<void> showPesanan() async {
    listPesanan = List<Map<String, dynamic>>.from(json.decode(jsonPesanan));
  }

  bool Refresh = false;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // mediaQuery = MediaQuery.of(context);
    setState(() {
      showPesanan();
      if (!Refresh) {
        _startTimer();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      Refresh = true;
      showPesanan();
      setState(() {});
    });
  }

  Widget KumpulanPesanan() {
    return Column(
      children: List.generate(
        listPesanan.length,
        (index) => Padding(
          padding: const EdgeInsets.only(left: 10),
          child: GestureDetector(
            child: Container(
              width: double.infinity,
              child: Card(
                surfaceTintColor: CustomColors.whiteColor,
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          '${listPesanan[index]['nomor']}.',
                          style: CustomText.TextArvoBold(
                            16,
                            CustomColors.blackColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          listPesanan[index]['nama'],
                          style: CustomText.TextArvoBold(
                            16,
                            CustomColors.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget KumpulanProdukTerlaris() {
    return Container(
      height: 190,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            listPesanan.length,
            (index) => Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 150,
                  child: Card(
                    color: CustomColors.primaryColor,
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: -5,
            right: -5,
            left: -5,
            child: Image.asset(Server.urlGambar("lingkaran.png")),
          ),
          Positioned(
            top: 50,
            left: 25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hai ..",
                  style: CustomText.TextArvoBold(
                    16 * mediaQuery.textScaleFactor,
                    CustomColors.whiteColor,
                  ),
                ),
                Text(
                  "Fadillah Wahyu",
                  style: CustomText.TextArvoBold(
                    18 * mediaQuery.textScaleFactor,
                    CustomColors.whiteColor,
                  ),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 230),
                  child: Container(
                    color: CustomColors.whiteColor,
                    width: double.infinity,
                    height:
                        mediaQuery.textScaleFactor * (1000 % double.infinity),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      fit: StackFit.loose,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 140, 20, 0),
                          child: Card(
                            surfaceTintColor: CustomColors.whiteColor,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: Text(
                                      'Pendapatan Hari Ini',
                                      style: CustomText.TextArvoBold(
                                          16, CustomColors.blackColor),
                                    ),
                                  ),
                                  subtitle: Text(
                                    'RP 2.430.000',
                                    style: CustomText.TextArvoBoldItalic(
                                        25, CustomColors.blackColor),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Card(
                                          color: CustomColors.secondaryColor,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Produk Terjual Hari Ini",
                                                        style: CustomText.TextArvo(
                                                            12 *
                                                                mediaQuery
                                                                    .textScaleFactor,
                                                            CustomColors
                                                                .whiteColor)),
                                                    Row(
                                                      children: [
                                                        Text("243",
                                                            style: CustomText
                                                                .TextArvoBoldItalic(
                                                                    20 *
                                                                        mediaQuery
                                                                            .textScaleFactor,
                                                                    CustomColors
                                                                        .whiteColor)),
                                                        SizedBox(width: 5),
                                                        Text("PCS  ",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: CustomText.TextArvo(
                                                                18 *
                                                                    mediaQuery
                                                                        .textScaleFactor,
                                                                CustomColors
                                                                    .whiteColor)),
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
                                          color: CustomColors.secondaryColor,
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        10, 10, 10, 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text("Pembeli Hari Ini",
                                                        style: CustomText.TextArvo(
                                                            12 *
                                                                mediaQuery
                                                                    .textScaleFactor,
                                                            CustomColors
                                                                .whiteColor)),
                                                    Row(
                                                      children: [
                                                        Text("243",
                                                            style: CustomText
                                                                .TextArvoBoldItalic(
                                                                    20 *
                                                                        mediaQuery
                                                                            .textScaleFactor,
                                                                    CustomColors
                                                                        .whiteColor)),
                                                        SizedBox(width: 5),
                                                        Text("orang  ",
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: CustomText.TextArvo(
                                                                18 *
                                                                    mediaQuery
                                                                        .textScaleFactor,
                                                                CustomColors
                                                                    .whiteColor)),
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
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 100,
                          right: 50,
                          child: Image.asset(Server.urlGambar("koinhome.png")),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: mediaQuery.size.width * 0.05,
                        top: 25 * mediaQuery.textScaleFactor,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Pesanan Masuk",
                          style: CustomText.TextArvoBold(
                            14 * mediaQuery.textScaleFactor,
                            CustomColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        mediaQuery.size.width * 0.01,
                        5 * mediaQuery.textScaleFactor,
                        mediaQuery.size.width * 0.01,
                        0,
                      ),
                      child: KumpulanPesanan(),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: mediaQuery.size.width * 0.01,
                      ),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Lihat Semua ..",
                            style: CustomText.TextArvoItalic(
                              14 * mediaQuery.textScaleFactor,
                              CustomColors.HintColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: SingleChildScrollView(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              KelolaProduk(),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            return SizeTransition(
                                              sizeFactor: animation,
                                              child: child,
                                            );
                                          },
                                        ));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    surfaceTintColor: CustomColors.whiteColor,
                                    color: CustomColors.card1,
                                    child: Column(children: [
                                      Padding(
                                        padding: EdgeInsets.all(20),
                                        child: Text(
                                          "KELOLA\nPRODUK",
                                          textAlign: TextAlign.center,
                                          style: CustomText.TextArvoBold(
                                            16 * mediaQuery.textScaleFactor,
                                            CustomColors.whiteColor,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(10, 0, 10, 20),
                                        child: Image.asset(
                                          Server.urlGambar("imgcard1.png"),
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    ]),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Card(
                                  elevation: 5,
                                  surfaceTintColor: CustomColors.whiteColor,
                                  color: CustomColors.card3,
                                  child: Column(children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 20, 30, 10),
                                      child: Text(
                                        "KELOLA\nPENGGUNA",
                                        textAlign: TextAlign.center,
                                        style: CustomText.TextArvoBold(
                                          16 * mediaQuery.textScaleFactor,
                                          CustomColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 20),
                                      child: Image.asset(
                                        Server.urlGambar("imgcard3.png"),
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  ]),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Card(
                                  elevation: 5,
                                  surfaceTintColor: CustomColors.whiteColor,
                                  color: CustomColors.card2,
                                  child: Column(children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(40, 20, 40, 10),
                                      child: Text(
                                        "STATUS\nPESANAN",
                                        textAlign: TextAlign.center,
                                        style: CustomText.TextArvoBold(
                                          16 * mediaQuery.textScaleFactor,
                                          CustomColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 20),
                                      child: Image.asset(
                                        Server.urlGambar("imgcard2.png"),
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  ]),
                                ),
                                SizedBox(height: 10),
                                Card(
                                  elevation: 5,
                                  surfaceTintColor: CustomColors.whiteColor,
                                  color: CustomColors.card4,
                                  child: Column(children: [
                                    Padding(
                                      padding: EdgeInsets.all(20),
                                      child: Text(
                                        "LAPORAN\nPENJUALAN",
                                        textAlign: TextAlign.center,
                                        style: CustomText.TextArvoBold(
                                          16 * mediaQuery.textScaleFactor,
                                          CustomColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 0, 10, 20),
                                      child: Image.asset(
                                        Server.urlGambar("imgcard4.png"),
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 220,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              width: 1,
                              color: CustomColors.HintColor,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          shadowColor: CustomColors.blackColor,
                          elevation: 15,
                          surfaceTintColor: CustomColors.whiteColor,
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, right: 20),
                                  child: Image.asset(
                                      Server.urlGambar("maphome.png")),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 40, 0, 40),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.only(left: 10, top: 10),
                                        child: Text(
                                          "Alamat Toko:",
                                          style: CustomText.TextArvo(
                                            14 * mediaQuery.textScaleFactor,
                                            CustomColors.blackColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: 270,
                                        margin: EdgeInsets.only(
                                          left: 10,
                                        ),
                                        child: Text(
                                          "Perumnas Candirejo Blok GG No. 10, Gejagan,Kec. Nganjuk, Kabupaten Nganjuk, Jawa Timur 64471",
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.left,
                                          style: CustomText.TextArvoBoldItalic(
                                            14 * mediaQuery.textScaleFactor,
                                            CustomColors.blackColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, right: 5),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      "Edit Alamat Toko?",
                                      style: CustomText.TextArvoItalic(
                                        12 * mediaQuery.textScaleFactor,
                                        CustomColors.HintColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: mediaQuery.size.width * 0.05,
                          top: 25 * mediaQuery.textScaleFactor,
                          bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Produk Terlaris",
                          style: CustomText.TextArvoBold(
                            14 * mediaQuery.textScaleFactor,
                            CustomColors.blackColor,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: KumpulanProdukTerlaris(),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}