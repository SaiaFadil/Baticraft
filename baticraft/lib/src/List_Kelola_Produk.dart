import 'dart:async';
import 'dart:convert';

import 'package:baticraft/page/page_login.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class List_Kelola_Produk extends StatefulWidget {
  const List_Kelola_Produk({super.key});
  static String kategori = "";
  static String id_produk = "";
  @override
  State<List_Kelola_Produk> createState() => _List_Kelola_ProdukState();
}

class _List_Kelola_ProdukState extends State<List_Kelola_Produk> {
  bool Refresh = false;
  String jsonKemeja = "{[]}";
  String jsonBaju = "{[]}";
  String jsonKain = "{[]}";
  List<Map<String, dynamic>> listKemeja = [];
  List<Map<String, dynamic>> listBaju = [];
  List<Map<String, dynamic>> listKain = [];

  Future showKemeja() async {
    final response = await http.get(Server.url("ShowBuah.php"));
    jsonKemeja = response.body.toString();

    listKemeja = List<Map<String, dynamic>>.from(json.decode(jsonKemeja));
  }

  Future showBaju() async {
    final response = await http.get(Server.url("ShowSayur.php"));
    jsonBaju = response.body.toString();
    listBaju = List<Map<String, dynamic>>.from(json.decode(jsonBaju));
  }
 
  Future showKain() async {
    final response = await http.get(Server.url("ShowSayur.php"));
    jsonKain = response.body.toString();
    listKain = List<Map<String, dynamic>>.from(json.decode(jsonKain));
  }

  Widget KumpulanKemeja() {
    return Container(
      height: 190,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            listKemeja.length,
            (index) => Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  List_Kelola_Produk.kategori = "Kemeja";
                  List_Kelola_Produk.id_produk = listKemeja[index]['id_produk'];
                  // Navigator.push(
                  //     context,
                  //     PageRouteBuilder(
                  //         pageBuilder:
                  //             (context, animation, secondaryAnimation) =>
                  //                 page_detail_produk(),
                  //         transitionsBuilder:
                  //             (context, animation, secondaryAnimation, child) {
                  //           return FadeTransition(
                  //             opacity: animation,
                  //             child: child,
                  //           );
                  //         }));
                  print("id produk = " + List_Kelola_Produk.id_produk);
                },
                child: Container(
                  width: 150,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 75,
                              child: Image.asset(
                                Server.urlGambar(listKemeja[index]['image']),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              listKemeja[index]['nama_produk'],
                              style: CustomText.TextArvoBold(
                                16,
                                CustomColors.blackColor,
                              ),
                            ),
                          ),
                         
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rp." + listKemeja[index]['harga'],
                                  style: CustomText.TextArvoBold(
                                    12,
                                    CustomColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  "/ " + listKemeja[index]['satuan'],
                                  style: CustomText.TextArvoBold(
                                    12,
                                    CustomColors.primaryColor,
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
  Widget KumpulanBaju() {
    return Container(
      height: 190,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            listBaju.length,
            (index) => Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  List_Kelola_Produk.kategori = "Baju";
                  List_Kelola_Produk.id_produk = listBaju[index]['id_produk'];
                  // Navigator.push(
                  //     context,
                  //     PageRouteBuilder(
                  //         pageBuilder:
                  //             (context, animation, secondaryAnimation) =>
                  //                 page_detail_produk(),
                  //         transitionsBuilder:
                  //             (context, animation, secondaryAnimation, child) {
                  //           return FadeTransition(
                  //             opacity: animation,
                  //             child: child,
                  //           );
                  //         }));
                  print("id produk = " + List_Kelola_Produk.id_produk);
                },
                child: Container(
                  width: 150,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              listBaju[index]['nama'],
                              style: CustomText.TextArvoBold(
                                  16, CustomColors.blackColor),
                            ),
                          ),
                         
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rp." + listBaju[index]['harga'],
                                  style: CustomText.TextArvoBold(
                                      12, CustomColors.primaryColor),
                                ),
                                Text(
                                  "/ " + listBaju[index]['satuan'],
                                  style: CustomText.TextArvoBold(
                                      12, CustomColors.primaryColor),
                                ),
                              ],
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
        ),
      ),
    );
  }
  Widget KumpulanKain() {
    return Container(
      height: 190,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            listKain.length,
            (index) => Padding(
              padding: const EdgeInsets.only(left: 10),
              child: GestureDetector(
                onTap: () {
                  List_Kelola_Produk.kategori = "Kain";
                  List_Kelola_Produk.id_produk = listKain[index]['id_produk'];
                  // Navigator.push(
                  //     context,
                  //     PageRouteBuilder(
                  //         pageBuilder:
                  //             (context, animation, secondaryAnimation) =>
                  //                 page_detail_produk(),
                  //         transitionsBuilder:
                  //             (context, animation, secondaryAnimation, child) {
                  //           return FadeTransition(
                  //             opacity: animation,
                  //             child: child,
                  //           );
                  //         }));
                  print("id produk = " + List_Kelola_Produk.id_produk);
                },
                child: Container(
                  width: 150,
                  child: Card(
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                  height: 75,
                                  child: Image.asset(
                                    Server.urlGambar(
                                        listKain[index]['image'] != null
                                            ? listKain[index]['image']
                                            : "default.png"),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              listKain[index]['nama'],
                              style: CustomText.TextArvoBold(
                                  16, CustomColors.blackColor),
                            ),
                          ),
                          
                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rp." + listKain[index]['harga'],
                                  style: CustomText.TextArvoBold(
                                      12, CustomColors.primaryColor),
                                ),
                                Text(
                                  "/ " + listKain[index]['satuan'],
                                  style: CustomText.TextArvoBold(
                                      12, CustomColors.primaryColor),
                                ),
                              ],
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
        ),
      ),
    );
  }

  late Timer _timer;
  @override
  void initState() {
    super.initState();
    setState(() {
      showKemeja();
      showBaju();
      showKain();
    });
    if (!Refresh) {
      _startTimer();
      print(page_login.id_user);
      print("SUCCESSSSSSSSSSSSSSSSSS");
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 100), (Timer timer) {
      Refresh = true;
      
      setState(() {
        showKemeja();
      showBaju();
      showKain();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: Text("Kategori : Kemeja",
                  textAlign: TextAlign.start,
                  style: CustomText.TextArvoBold(20, CustomColors.blackColor))),
        ),
        KumpulanKemeja(),
        Align(
             alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Text("Kategori : Baju",
                  style: CustomText.TextArvoBold(20, CustomColors.blackColor))),
        ),
        KumpulanBaju(),
        Align(
             alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Text("Kategori : Kain",
                  style: CustomText.TextArvoBold(20, CustomColors.blackColor))),
        ),
        KumpulanKain(),
      ],
    );
  }
}
