import 'dart:async';
import 'dart:convert';

import 'package:baticraft/menu/SubMenuHome/subMenuProduk/EditProduk/page_edit_kain.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuProduk/EditProduk/page_edit_kaos.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuProduk/EditProduk/page_edit_kemeja.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuProduk/page_kelola_produk.dart';
import 'package:baticraft/page/page_login.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class List_Kelola_Produk extends StatefulWidget {
  const List_Kelola_Produk({super.key});
  static String kategori = "";
  static String id_produk = "";
  @override
  State<List_Kelola_Produk> createState() => _List_Kelola_ProdukState();
}

class _List_Kelola_ProdukState extends State<List_Kelola_Produk> {
  Future<void> deleteProductAndImages(String idProduk) async {
    final response = await http.post(Server.urlLaravel('deleteProduct'),
        body: {'id_produk': idProduk.toString()});

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      print(responseData['message']);
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                KelolaProduk(), 
          ));
    } else {
      print(
          'Failed to delete product and images. Error: ${response.reasonPhrase}');
    }
  }

  String jsonProdukKemeja = "{}";
  String jsonProdukBaju = "{}";
  String jsonProdukKain = "{}";

  List<Map<String, dynamic>> listKemeja = [];
  List<Map<String, dynamic>> listBaju = [];
  List<Map<String, dynamic>> listKain = [];

  Future<void> showKemeja() async {
    final response = await http.get(Server.urlLaravel("showKemeja"));
    jsonProdukKemeja = response.body.toString();
    setState(() {
      listKemeja =
          List<Map<String, dynamic>>.from(json.decode(jsonProdukKemeja));
    });
    print(listKemeja[0]['nama']);
  }

  Future<void> showKaos() async {
    final response = await http.get(Server.urlLaravel("showKaos"));
    jsonProdukBaju = response.body.toString();
    setState(() {
      listBaju = List<Map<String, dynamic>>.from(json.decode(jsonProdukBaju));
    });
    print(listBaju[0]['nama']);
  }

  Future<void> showKain() async {
    final response = await http.get(Server.urlLaravel("showKain"));
    jsonProdukKain = response.body.toString();
    setState(() {
      listKain = List<Map<String, dynamic>>.from(json.decode(jsonProdukKain));
    });
    print(listKain[0]['nama']);
  }

  Widget KumpulanKemeja() {
      return Container(
      height: 230,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            listKemeja.length,
            (index) => Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  List_Kelola_Produk.id_produk = listKemeja[index]['id'].toString();
                  print("id produk = " + List_Kelola_Produk.id_produk);
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Edit_Produk_Kemeja()));
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
                          listKemeja.isEmpty
                              ? Shimmer.fromColors(
                                  baseColor:
                                      Color.fromARGB(255, 104, 102, 102)!,
                                  highlightColor:
                                      const Color.fromARGB(255, 202, 200, 200)!,
                                  child: Text(
                                    '...',
                                    style: CustomText.TextArvo(
                                      14,
                                      CustomColors.blackColor,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                )
                              : Container(
                                  child: Image.network(
                                    fit: BoxFit.fitWidth,
                                    height: 120,
                                    Server.urlLaravelImageProduct(
                                        listKemeja[index]['image_path']),
                                  ),
                                ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: listKemeja.isEmpty
                                  ? Shimmer.fromColors(
                                      baseColor:
                                          Color.fromARGB(255, 104, 102, 102)!,
                                      highlightColor: const Color.fromARGB(
                                          255, 202, 200, 200)!,
                                      child: Text(
                                        '...',
                                        style: CustomText.TextArvo(
                                          14,
                                          CustomColors.blackColor,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    )
                                  : Text(
                                      listKemeja[index]['nama'],
                                      style: CustomText.TextArvoBold(
                                          14, CustomColors.blackColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    )),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                listKemeja.isEmpty
                                    ? Shimmer.fromColors(
                                        baseColor:
                                            Color.fromARGB(255, 104, 102, 102)!,
                                        highlightColor: const Color.fromARGB(
                                            255, 202, 200, 200)!,
                                        child: Text(
                                          '...',
                                          style: CustomText.TextArvo(
                                            14,
                                            CustomColors.blackColor,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      )
                                    : Text(
                                        "Rp." +
                                            listKemeja[index]['harga']
                                                .toString(),
                                        style: CustomText.TextArvoBold(
                                            12, CustomColors.blackColor)),
                                Container(
                                  child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Konfirmasi",
                                                style: CustomText.TextArvoBold(
                                                    18,
                                                    CustomColors.whiteColor),
                                              ),
                                              backgroundColor:
                                                  CustomColors.secondaryColor,
                                              content: Text(
                                                "Apakah Anda yakin ingin HAPUS produk ini?",
                                                style: CustomText.TextArvo(16,
                                                    CustomColors.whiteColor),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    deleteProductAndImages(
                                                        listKemeja[index]
                                                            ['id'].toString());
                                                    print("pressed");
                                                  },
                                                  child: Text(
                                                    "Ya",
                                                    style:
                                                        CustomText.TextArvoBold(
                                                            18,
                                                            CustomColors
                                                                .whiteColor),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Tutup dialog
                                                  },
                                                  child: Text(
                                                    "Tidak",
                                                    style:
                                                        CustomText.TextArvoBold(
                                                            18,
                                                            CustomColors
                                                                .whiteColor),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
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

  Widget KumpulanKaos() {
    return Container(
      height: 230,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            listBaju.length,
            (index) => Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  List_Kelola_Produk.id_produk = listBaju[index]['id'].toString();
                  print("id produk = " + List_Kelola_Produk.id_produk);
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Edit_Produk_Kaos()));
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
                          listBaju.isEmpty
                              ? Shimmer.fromColors(
                                  baseColor:
                                      Color.fromARGB(255, 104, 102, 102)!,
                                  highlightColor:
                                      const Color.fromARGB(255, 202, 200, 200)!,
                                  child: Text(
                                    '...',
                                    style: CustomText.TextArvo(
                                      14,
                                      CustomColors.blackColor,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                )
                              : Container(
                                  child: Image.network(
                                    fit: BoxFit.fitWidth,
                                    height: 120,
                                    Server.urlLaravelImageProduct(
                                        listBaju[index]['image_path']),
                                  ),
                                ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: listBaju.isEmpty
                                  ? Shimmer.fromColors(
                                      baseColor:
                                          Color.fromARGB(255, 104, 102, 102)!,
                                      highlightColor: const Color.fromARGB(
                                          255, 202, 200, 200)!,
                                      child: Text(
                                        '...',
                                        style: CustomText.TextArvo(
                                          14,
                                          CustomColors.blackColor,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    )
                                  : Text(
                                      listBaju[index]['nama'],
                                      style: CustomText.TextArvoBold(
                                          14, CustomColors.blackColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    )),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                listBaju.isEmpty
                                    ? Shimmer.fromColors(
                                        baseColor:
                                            Color.fromARGB(255, 104, 102, 102)!,
                                        highlightColor: const Color.fromARGB(
                                            255, 202, 200, 200)!,
                                        child: Text(
                                          '...',
                                          style: CustomText.TextArvo(
                                            14,
                                            CustomColors.blackColor,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      )
                                    : Text(
                                        "Rp." +
                                            listBaju[index]['harga'].toString(),
                                        style: CustomText.TextArvoBold(
                                            12, CustomColors.blackColor)),
                                Container(
                                  child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Konfirmasi",
                                                style: CustomText.TextArvoBold(
                                                    18,
                                                    CustomColors.whiteColor),
                                              ),
                                              backgroundColor:
                                                  CustomColors.secondaryColor,
                                              content: Text(
                                                "Apakah Anda yakin ingin HAPUS produk ini?",
                                                style: CustomText.TextArvo(16,
                                                    CustomColors.whiteColor),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    deleteProductAndImages(
                                                        listBaju[index]['id'].toString());
                                                    print("pressed");
                                                  },
                                                  child: Text(
                                                    "Ya",
                                                    style:
                                                        CustomText.TextArvoBold(
                                                            18,
                                                            CustomColors
                                                                .whiteColor),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Tutup dialog
                                                  },
                                                  child: Text(
                                                    "Tidak",
                                                    style:
                                                        CustomText.TextArvoBold(
                                                            18,
                                                            CustomColors
                                                                .whiteColor),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
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
            listKain.length,
            (index) => Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  List_Kelola_Produk.id_produk = listKain[index]['id'].toString();
                  print("id produk = " + List_Kelola_Produk.id_produk);
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Edit_Produk_Kain()));
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
                          listKain.isEmpty
                              ? Shimmer.fromColors(
                                  baseColor:
                                      Color.fromARGB(255, 104, 102, 102)!,
                                  highlightColor:
                                      const Color.fromARGB(255, 202, 200, 200)!,
                                  child: Text(
                                    '...',
                                    style: CustomText.TextArvo(
                                      14,
                                      CustomColors.blackColor,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                )
                              : Container(
                                  child: Image.network(
                                    fit: BoxFit.fitWidth,
                                    height: 120,
                                    Server.urlLaravelImageProduct(
                                        listKain[index]['image_path']),
                                  ),
                                ),
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: listKain.isEmpty
                                  ? Shimmer.fromColors(
                                      baseColor:
                                          Color.fromARGB(255, 104, 102, 102)!,
                                      highlightColor: const Color.fromARGB(
                                          255, 202, 200, 200)!,
                                      child: Text(
                                        '...',
                                        style: CustomText.TextArvo(
                                          14,
                                          CustomColors.blackColor,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    )
                                  : Text(
                                      listKain[index]['nama'],
                                      style: CustomText.TextArvoBold(
                                          14, CustomColors.blackColor),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    )),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                listKain.isEmpty
                                    ? Shimmer.fromColors(
                                        baseColor:
                                            Color.fromARGB(255, 104, 102, 102)!,
                                        highlightColor: const Color.fromARGB(
                                            255, 202, 200, 200)!,
                                        child: Text(
                                          '...',
                                          style: CustomText.TextArvo(
                                            14,
                                            CustomColors.blackColor,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                      )
                                    : Text(
                                        "Rp." +
                                            listKain[index]['harga'].toString(),
                                        style: CustomText.TextArvoBold(
                                            12, CustomColors.blackColor)),
                                Container(
                                  child: IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(
                                                "Konfirmasi",
                                                style: CustomText.TextArvoBold(
                                                    18,
                                                    CustomColors.whiteColor),
                                              ),
                                              backgroundColor:
                                                  CustomColors.secondaryColor,
                                              content: Text(
                                                "Apakah Anda yakin ingin HAPUS produk ini?",
                                                style: CustomText.TextArvo(16,
                                                    CustomColors.whiteColor),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                    deleteProductAndImages(
                                                        listKain[index]['id'].toString());
                                                    print("pressed");
                                                  },
                                                  child: Text(
                                                    "Ya",
                                                    style:
                                                        CustomText.TextArvoBold(
                                                            18,
                                                            CustomColors
                                                                .whiteColor),
                                                  ),
                                                ),
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context)
                                                        .pop(); // Tutup dialog
                                                  },
                                                  child: Text(
                                                    "Tidak",
                                                    style:
                                                        CustomText.TextArvoBold(
                                                            18,
                                                            CustomColors
                                                                .whiteColor),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
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
    showKemeja();
    showKaos();
    showKain();
    setState(() {
      showKemeja();
      showKaos();
      showKain();
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
      children: [    Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25, top: 10),
              child: Text("Kategori : Kain",
                  style: CustomText.TextArvoBold(20, CustomColors.blackColor))),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 20),
          child: KumpulanKain(),
        ),
       
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25,),
              child: Text("Kategori : Baju",
                  style: CustomText.TextArvoBold(20, CustomColors.blackColor))),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: KumpulanKaos(),
        ),
     Align(
          alignment: Alignment.centerLeft,
          child: Padding(
              padding: EdgeInsets.only(left: 25, right: 25,top:10),
              child: Text("Kategori : Kemeja",
                  textAlign: TextAlign.start,
                  style: CustomText.TextArvoBold(20, CustomColors.blackColor))),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: KumpulanKemeja(),
        ),
      ],
    );
  }
}
