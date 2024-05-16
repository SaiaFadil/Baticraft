import 'dart:convert';
import 'dart:async';
import 'package:baticraft/menu/SubMenuHome/subMenuInformasiToko/page_informasi_toko.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuKelolaPengguna/page_kelola_pengguna.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuLaporanPenjualan/Laporan.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuProduk/EditProduk/page_edit_kain.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuProduk/EditProduk/page_edit_kaos.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuProduk/EditProduk/page_edit_kemeja.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuProduk/page_kelola_produk.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuStatusPesanan/page_status_pesanan.dart';
import 'package:baticraft/pageSebelumLogin/page_login.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/List_Kelola_Produk.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:shimmer/shimmer.dart';

class MenuDashboard extends StatefulWidget {
  const MenuDashboard({Key? key}) : super(key: key);
  static String nama = "";
  static String kategori = "";

  @override
  State<MenuDashboard> createState() => _MenuDashboardState();
}

class _MenuDashboardState extends State<MenuDashboard> {
  late MediaQueryData mediaQuery = MediaQuery.of(context);

  String jsonDetailUser = "{}"; // Initialize as an empty JSON object
  Map<String, dynamic> detailUser = {}; // Initialize as an empty map

  String jsonDetailInformasi = "{}";
  Map<String, dynamic> detailInformasi = {};

  Future getDetailInformasi() async {
    try {
      final response =
          await http.get(Server.urlLaravel("DetailInformasiMobile"));
      if (response.statusCode == 200) {
        List<dynamic> detailInformasiList = json.decode(response.body);
        if (detailInformasiList.isNotEmpty) {
          // Ambil elemen pertama dari list (asumsikan hanya satu objek dalam list)
          Map<String, dynamic> detailInformasi = detailInformasiList[0];
          setState(() {
            alamat = detailInformasi['alamat'];
          });
        } else {
          print("No data available");
        }
      } else {
        print("HTTP Request failed with status: ${response.statusCode}");
      }
    } catch ($e) {
      print($e);
    }
  }

  Future getDetailUser() async {
    final response = await http.post(Server.urlLaravel("DetailProfil"),
        body: {"id_user": page_login.id_user});

    if (response.statusCode == 200) {
      jsonDetailUser = response.body.toString();
      detailUser = json.decode(jsonDetailUser);
      if (detailUser.isNotEmpty) {
        setState(() {
          nama = detailUser['nama'];
          MenuDashboard.nama = detailUser['nama'];

          print("Namaaaa " + MenuDashboard.nama);
        });
      } else {
        print("No data available");
      }
    } else {
      print("HTTP Request failed with status: ${response.statusCode}");
    }
  }

  String alamat = "";
  String nama = "";
  String produkTerjual = "0";
  String pembeli = "0";
  late String jsonDataPenjualan = "";
  late List<Map<String, dynamic>> listDataPenjualan = [];

  Future<void> fetchDataPenjualan() async {
    final response = await http.get(Server.urlLaravel('pendapatanHariIni'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final DateTime date = DateTime.parse(data["date"]);
      setState(() {
        jsonDataPenjualan = json.encode([
          {
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
  void initState() {
    super.initState();
    fetchDataPenjualan();
    getDetailInformasi();
    showProduk();
    showPesanan();
    getDetailUser();
    setState(() {
      print("idddddd = " + page_login.id_user);
      showProduk();
    });
  }

  String jsonProduk = "";
  String jsonProdukPesanan = "";
  Future<void> showPesanan() async {
    final response =
        await http.get(Server.urlLaravel("getTransactionDataLimit"));
    jsonProdukPesanan = response.body.toString();
    setState(() {
      listPesanan =
          List<Map<String, dynamic>>.from(json.decode(jsonProdukPesanan));
    });
  }

  List<Map<String, dynamic>> listProdukTerlaris = [];
  List<Map<String, dynamic>> listPesanan = [];
  Future<void> showProduk() async {
    final response = await http.get(Server.urlLaravel('produkTerlaris'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        listProdukTerlaris = List<Map<String, dynamic>>.from(data);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  int nomor = 1;

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
                          "${(nomor + index)} .",
                          style: CustomText.TextArvoBold(
                            16,
                            CustomColors.blackColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Container(
                          width: 280,
                          child: Text(
                            listPesanan[index]['nama'],
                            overflow: TextOverflow.ellipsis,
                            style: CustomText.TextArvoBold(
                              18,
                              CustomColors.blackColor,
                            ),
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
      height: 230,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            listProdukTerlaris.length,
            (index) => Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  List_Kelola_Produk.id_produk =
                      listProdukTerlaris[index]['id'].toString();
                  MenuDashboard.kategori =
                      listProdukTerlaris[index]['kategori'].toString();
                  print("id produk = " + List_Kelola_Produk.id_produk);

                  if (MenuDashboard.kategori == "kain") {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Edit_Produk_Kain()));
                  } else if (MenuDashboard.kategori == "kemeja") {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Edit_Produk_Kemeja()));
                  } else if (MenuDashboard.kategori == "kaos") {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Edit_Produk_Kaos()));
                  }
                },
                child: Container(
                  width: 170,
                  child: Card(
                    surfaceTintColor: CustomColors.whiteColor,
                    color: CustomColors.whiteColor,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.network(
                              fit: BoxFit.fitWidth,
                              height: 120,
                              Server.urlLaravelImageProduct(
                                  listProdukTerlaris[index]['image_path']),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              listProdukTerlaris[index]['nama'],
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.blackColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "Rp." +
                                        listProdukTerlaris[index]['harga']
                                            .toString(),
                                    style: CustomText.TextArvoBold(
                                        12, CustomColors.blackColor)),
                              ],
                            ),
                          )
                        ],
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
            top: 0,
            right: 0,
            left: 0,
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
                detailUser['nama'] != null
                    ? Text(
                        detailUser['nama'],
                        style: CustomText.TextArvoBold(
                          18,
                          CustomColors.whiteColor,
                        ),
                        textAlign: TextAlign.start,
                      )
                    : Shimmer.fromColors(
                        baseColor: Color.fromARGB(255, 104, 102, 102)!,
                        highlightColor:
                            const Color.fromARGB(255, 202, 200, 200)!,
                        child: Text(
                          'Loading...',
                          style: CustomText.TextArvo(
                            14,
                            CustomColors.blackColor,
                          ),
                          textAlign: TextAlign.start,
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
                                    'RP ${listDataPenjualan.isEmpty ? "0" : listDataPenjualan[0]['totalPendapatan']}',
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
                                                        Text(produkTerjual,
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
                                                        Text(pembeli,
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
                    Visibility(
                      visible: listPesanan.isNotEmpty? true : false ,
                      child: Column(
                        children: [
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
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              StatusPesanan()));
                                },
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
                        ],
                      ),
                    ),

                    SizedBox(height: 20,),
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
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                                  secondaryAnimation) =>
                                              KelolaPengguna(),
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
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                StatusPesanan()));
                                  },
                                  child: Card(
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
                                ),
                                SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                LaporanUtama(),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              );
                                            }));
                                  },
                                  child: Card(
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      InformasiToko()));
                        },
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
                                    padding: const EdgeInsets.only(
                                        top: 20, right: 20),
                                    child: Image.asset(
                                        Server.urlGambar("maphome.png")),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 40, 0, 40),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 10, top: 10),
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
                                            child: alamat.isNotEmpty
                                                ? Text(
                                                    alamat,
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  )
                                                : Shimmer.fromColors(
                                                    baseColor: Color.fromARGB(
                                                        255, 104, 102, 102)!,
                                                    highlightColor:
                                                        const Color.fromARGB(
                                                            255,
                                                            202,
                                                            200,
                                                            200)!,
                                                    child: Text(
                                                      'Loading...',
                                                      style:
                                                          CustomText.TextArvo(
                                                        14,
                                                        CustomColors.blackColor,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
                      padding: const EdgeInsets.only(bottom: 20),
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
