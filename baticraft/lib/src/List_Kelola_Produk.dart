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
  String jsonProdukKemeja = """[
    {"image_path": "produkterlaris.png", "nama": "Batik Palembang", "harga": "74000"},
    {"image_path": "produkterlaris.png", "nama": "Batik Palembang", "harga": "74000"},
    {"image_path": "produkterlaris.png", "nama": "Batik Palembang", "harga": "74000"}
    
  ]""";
  String jsonProdukBaju = """[
    {"image_path": "produkterlaris.png", "nama": "Batik Palembang", "harga": "74000"},
    {"image_path": "produkterlaris.png", "nama": "Batik Palembang", "harga": "74000"},
    {"image_path": "produkterlaris.png", "nama": "Batik Palembang", "harga": "74000"}

  ]""";
  String jsonProdukKain = """[
    {"image_path": "produkterlaris.png", "nama": "Batik Palembang", "harga": "74000"},
    {"image_path": "produkterlaris.png", "nama": "Batik Palembang", "harga": "74000"},
    {"image_path": "produkterlaris.png", "nama": "Batik Palembang", "harga": "74000"}
  ]""";

  List<Map<String, dynamic>> listProdukKemeja = [];
  List<Map<String, dynamic>> listProdukBaju = [];
  List<Map<String, dynamic>> listProdukKain = [];
  Future<void> showProdukKemeja() async {
    listProdukKemeja =
        List<Map<String, dynamic>>.from(json.decode(jsonProdukKemeja));
  }

  Future<void> showProdukBaju() async {
    listProdukBaju =
        List<Map<String, dynamic>>.from(json.decode(jsonProdukBaju));
  }

  Future<void> showProdukKain() async {
    listProdukKain =
        List<Map<String, dynamic>>.from(json.decode(jsonProdukKain));
  }

  List<Map<String, dynamic>> listKemeja = [];
  List<Map<String, dynamic>> listBaju = [];
  List<Map<String, dynamic>> listKain = [];

  // Future showKemeja() async {
  //   final response = await http.get(Server.url("ShowBuah.php"));
  //   jsonKemeja = response.body.toString();

  //   listKemeja = List<Map<String, dynamic>>.from(json.decode(jsonKemeja));
  // }

  // Future showBaju() async {
  //   final response = await http.get(Server.url("ShowSayur.php"));
  //   jsonBaju = response.body.toString();
  //   listBaju = List<Map<String, dynamic>>.from(json.decode(jsonBaju));
  // }

  // Future showKain() async {
  //   final response = await http.get(Server.url("ShowSayur.php"));
  //   jsonKain = response.body.toString();
  //   listKain = List<Map<String, dynamic>>.from(json.decode(jsonKain));
  // }

  Widget KumpulanKemeja() {
    return Container(
      height: 230,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            listProdukKemeja.length,
            (index) => Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: GestureDetector(
                onTap: () {

                  
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
                              Server.urlImageDatabase(
                                  listProdukKemeja[index]['image_path']),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              listProdukKemeja[index]['nama'],
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
                                Text("Rp." + listProdukKemeja[index]['harga'],
                                    style: CustomText.TextArvoBold(
                                        12, CustomColors.blackColor)),
                                Container(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        Server.urlGambar("icons_sampah.png"),
                                        height: 20,
                                      )),
                                )
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

  Widget KumpulanBaju() {
    return Container(
      height: 230,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            listProdukBaju.length,
            (index) => Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: GestureDetector(
                onTap: () {},
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
                              Server.urlImageDatabase(
                                  listProdukBaju[index]['image_path']),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              listProdukBaju[index]['nama'],
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
                                Text("Rp." + listProdukBaju[index]['harga'],
                                    style: CustomText.TextArvoBold(
                                        12, CustomColors.blackColor)),
                                Container(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        Server.urlGambar("icons_sampah.png"),
                                        height: 20,
                                      )),
                                )
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

  Widget KumpulanKain() {
    return Container(
      height: 230,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            listProdukKain.length,
            (index) => Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: GestureDetector(
                onTap: () {},
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
                              Server.urlImageDatabase(
                                  listProdukKain[index]['image_path']),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Text(
                              listProdukKain[index]['nama'],
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
                                Text("Rp." + listProdukKain[index]['harga'],
                                    style: CustomText.TextArvoBold(
                                        12, CustomColors.blackColor)),
                                Container(
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Image.asset(
                                        Server.urlGambar("icons_sampah.png"),
                                        height: 20,
                                      )),
                                )
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
  void initState() {
    super.initState();
    setState(() {
      showProdukKemeja();
      showProdukBaju();
      showProdukKain();
    });
  }

  @override
  void dispose() {
    super.dispose();
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
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: KumpulanKemeja(),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Text("Kategori : Baju",
                  style: CustomText.TextArvoBold(20, CustomColors.blackColor))),
        ),
        Padding(
           padding: const EdgeInsets.only(top: 10),
          child: KumpulanBaju(),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Text("Kategori : Kain",
                  style: CustomText.TextArvoBold(20, CustomColors.blackColor))),
        ),
        Padding(
           padding: const EdgeInsets.only(top: 10,bottom: 30),
          child: KumpulanKain(),
        ),
      ],
    );
  }
}
