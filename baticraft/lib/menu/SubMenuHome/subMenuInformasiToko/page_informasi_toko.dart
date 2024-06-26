import 'dart:convert';

import 'package:baticraft/menu/SubMenuHome/subMenuInformasiToko/page_edit_informasi.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class InformasiToko extends StatefulWidget {
  const InformasiToko({super.key});

  @override
  State<InformasiToko> createState() => _InformasiTokoState();
}

class _InformasiTokoState extends State<InformasiToko> {
//Awal Backend
  String jsonDetailInformasi = "{}";
  Map<String, dynamic> detailInformasi = {};

  String nama_pemilik = "";
  String nama_toko = "";
  String alamat = "";
  String deskripsi = "";
  String no_telpon = "";
  String email = "";
  String akun_ig = "";
  String akun_fb = "";
  String akun_tiktok = "";
  String image = "";

  Future getDetailInformasi() async {
    final response = await http.get(Server.urlLaravel("DetailInformasiMobile"));
    List<dynamic> detailInformasiList = [];
    try {
      setState(() {});
      if (response.statusCode == 200) {
        detailInformasiList = json.decode(response.body);
        if (detailInformasiList.isNotEmpty) {
          Map<String, dynamic> detailInformasi = detailInformasiList[0];
          setState(() {});
          nama_pemilik = detailInformasi['nama_pemilik'].toString();
          nama_toko = detailInformasi['nama_toko'].toString();
          alamat = detailInformasi['alamat'].toString();
          deskripsi = detailInformasi['deskripsi'].toString();
          no_telpon = detailInformasi['no_telpon'].toString();
          email = detailInformasi['email'].toString();
          if (detailInformasi['akun_fb'].toString() == "null") {
            akun_fb = "";
          } else {
            akun_fb = detailInformasi['akun_fb'];
          }
          if (detailInformasi['akun_ig'].toString()== "null") {
            akun_ig = "";
          } else {
            akun_ig = detailInformasi['akun_ig'];
          }
          if (detailInformasi['akun_tiktok'].toString()== "null") {
            akun_tiktok = "";
          } else {
            akun_tiktok = detailInformasi['akun_tiktok'];
          }
          image = detailInformasi['image'].toString();

          print(detailInformasiList.toString());
        } else {
          print("No data available");
        }
      } else {
        print("HTTP Request failed with status: ${response.statusCode}");
      }
    } catch ($e) {
      print("ERRORRR " + $e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getDetailInformasi();
    setState(() {
      getDetailInformasi();
    });
  }

//Akhir Backend
  void openLink() async {
    if (await canLaunch(detailInformasi['lokasi'])) {
      await launch(detailInformasi['lokasi']);
      print(detailInformasi['lokasi']);
    } else {
      throw 'Could not launch' + detailInformasi['lokasi'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text("Informasi Toko",
              style: CustomText.TextArvoBold(16, CustomColors.threertyColor),
              textAlign: TextAlign.center),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
            color: CustomColors.threertyColor,
          ),
          shadowColor: CustomColors.blackColor,
          centerTitle: true,
          surfaceTintColor: CustomColors.whiteColor,
        ),
        backgroundColor: CustomColors.secondaryColor,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: image.isNotEmpty
                  ? Container(
                      child: Image.network(
                        Server.urlLaravelImageInformation(image),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.center,
                      ),
                    )
                  : Shimmer.fromColors(
                      baseColor: Color.fromARGB(255, 104, 102, 102)!,
                      highlightColor: const Color.fromARGB(255, 202, 200, 200)!,
                      child: Image.asset(Server.urlGambar("default.png"))),
            ),
            Positioned(
              top: 0,
              bottom: -5,
              left: -5,
              right: -5,
              child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 215),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    color: CustomColors.whiteColor,
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(27, 0, 27, 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Griya Batik Sri Siji",
                                  style: CustomText.TextArvoBold(
                                      22, CustomColors.blackColor),
                                ),
                              ),
                            ),
                            // Data Awal
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.person_2_sharp,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Nama Pemilik",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: nama_pemilik.isNotEmpty
                                              ? Text(
                                                  nama_pemilik,
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
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.home_work,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Alamat",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: nama_pemilik.isNotEmpty
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
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            Server.urlGambar(
                                                "ic_deskripsi.png"),
                                            fit: BoxFit.contain,
                                            height: 25,
                                            width: 25),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Deskripsi",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: nama_pemilik.isNotEmpty
                                              ? Text(
                                                  deskripsi,
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
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.call,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Nomor Telepon",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: nama_pemilik.isNotEmpty
                                              ? Text(
                                                  no_telpon,
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
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.mail,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Email",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: nama_pemilik.isNotEmpty
                                              ? Text(
                                                  email,
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
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            Server.urlGambar("ic_ig.png"),
                                            fit: BoxFit.contain,
                                            height: 25,
                                            width: 25),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Akun Instagram",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: nama_pemilik.isNotEmpty
                                              ? Text(
                                                  akun_ig,
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
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.facebook,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Akun Facebook",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: nama_pemilik.isNotEmpty
                                              ? Text(
                                                  akun_fb,
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
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.tiktok,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Akun Tiktok",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: nama_pemilik.isNotEmpty
                                              ? Text(
                                                  akun_tiktok,
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
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Lokasi",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Jalankan link
                                              openLink();
                                            },
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/map.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    style: CustomButton.DefaultButton(
                                        CustomColors.secondaryColor),
                                    child: Text(
                                      "Edit",
                                      style: CustomText.TextArvoBold(
                                          20, CustomColors.whiteColor),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  EditInformasiToko(),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              }));
                                      // Navigator.push(
                                      //     context,
                                      //     PageRouteBuilder(
                                      //       pageBuilder: (context, animation,
                                      //               secondaryAnimation) =>
                                      //           EditInformasiToko(),
                                      //       transitionsBuilder: (context,
                                      //           animation,
                                      //           secondaryAnimation,
                                      //           child) {
                                      //         return FadeTransition(
                                      //           opacity: animation,
                                      //           child: child,
                                      //         );
                                      //       },
                                      //     ));
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
