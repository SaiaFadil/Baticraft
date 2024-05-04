import 'dart:convert';

import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class HomeTransaksi extends StatefulWidget {
  const HomeTransaksi({super.key});

  @override
  State<HomeTransaksi> createState() => _HomeTransaksiState();
}

class _HomeTransaksiState extends State<HomeTransaksi> {
  String _selectedOption = "kain";

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
                                    Server.urlLaravelImage(
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
                                    Server.urlLaravelImage(
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
                                    Server.urlLaravelImage(
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

  late MediaQueryData mediaQuery = MediaQuery.of(context);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text("Transaksi",
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
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                height: 50,
                margin: EdgeInsets.all(10),
                child: Card(
                    surfaceTintColor: CustomColors.whiteColor,
                    borderOnForeground: true,
                    color: CustomColors.whiteColor,
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                            color: CustomColors.secondaryColor,
                            strokeAlign: 1)),
                    elevation: 10,
                    child: CustomWidget.KolomPencarian(() {}))),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Kategori",
                  style: CustomText.TextArvoBold(16, CustomColors.blackColor),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'kain';
                        });
                      },
                      child: Text(
                        'Kain',
                        style: CustomText.TextArvoBold(
                            16,
                            _selectedOption == 'kain'
                                ? CustomColors.whiteColor
                                : CustomColors.secondaryColor),
                      ),
                      style: ButtonStyle(
                        surfaceTintColor: MaterialStateProperty.all<Color>(
                            _selectedOption == 'kain'
                                ? CustomColors.secondaryColor
                                : CustomColors.whiteColor),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            side:
                                BorderSide(color: CustomColors.secondaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(10),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.fromLTRB(30, 5, 30, 5)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            _selectedOption == 'kain'
                                ? CustomColors.secondaryColor
                                : CustomColors.whiteColor),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'kemeja';
                        });
                      },
                      child: Text('kemeja',
                          style: CustomText.TextArvoBold(
                              16,
                              _selectedOption == 'kemeja'
                                  ? CustomColors.whiteColor
                                  : CustomColors.secondaryColor)),
                      style: ButtonStyle(
                        surfaceTintColor: MaterialStateProperty.all<Color>(
                            _selectedOption == 'kemeja'
                                ? CustomColors.secondaryColor
                                : CustomColors.whiteColor),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            side:
                                BorderSide(color: CustomColors.secondaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(10),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.fromLTRB(30, 5, 30, 5)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            _selectedOption == 'kemeja'
                                ? CustomColors.secondaryColor
                                : CustomColors.whiteColor),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedOption = 'kaos';
                        });
                      },
                      child: Text('Kaos',
                          style: CustomText.TextArvoBold(
                              16,
                              _selectedOption == 'kaos'
                                  ? CustomColors.whiteColor
                                  : CustomColors.secondaryColor)),
                      style: ButtonStyle(
                        surfaceTintColor: MaterialStateProperty.all<Color>(
                            _selectedOption == 'kaos'
                                ? CustomColors.secondaryColor
                                : CustomColors.whiteColor),
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          RoundedRectangleBorder(
                            side:
                                BorderSide(color: CustomColors.secondaryColor),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        elevation: MaterialStateProperty.all<double>(10),
                        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.fromLTRB(30, 5, 30, 5)),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            _selectedOption == 'kaos'
                                ? CustomColors.secondaryColor
                                : CustomColors.whiteColor),
                      )),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _selectedOption == 'kain' ? dataKain() : SizedBox(),
            _selectedOption == 'kemeja' ? dataKemeja() : SizedBox(),
            _selectedOption == 'kaos' ? dataKaos() : SizedBox(),
          ]),
        ),
      ),
    );
  }

  Widget dataKain() {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Align(alignment: Alignment.centerLeft, child: KumpulanKain())],
    ));
  }

  Widget dataKemeja() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(alignment: Alignment.centerLeft, child: KumpulanKemeja()),
        ],
      ),
    );
  }

  Widget dataKaos() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(alignment: Alignment.centerLeft, child: KumpulanKaos()),
        ],
      ),
    );
  }
}
