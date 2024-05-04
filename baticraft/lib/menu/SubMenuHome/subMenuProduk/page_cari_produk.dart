import 'package:baticraft/menu/SubMenuHome/subMenuProduk/page_kelola_produk.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/CustomWidget.dart';

import 'package:baticraft/menu/SubMenuHome/subMenuProduk/EditProduk/page_edit_kain.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuProduk/EditProduk/page_edit_kaos.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuProduk/EditProduk/page_edit_kemeja.dart';
import 'package:baticraft/src/List_Kelola_Produk.dart';

import 'package:flutter/material.dart';
import 'package:baticraft/page/page_login.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class cari_produk extends StatefulWidget {
  const cari_produk({super.key});
  static String kategori = "";
  @override
  State<cari_produk> createState() => _cari_produkState();
}

class _cari_produkState extends State<cari_produk> {
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

  Future showPencarian(String searchText) async {
    final response =
        await http.post(Server.urlLaravel("search"),body: {
          'search' : searchText
        });
    jsonProdukProduk = response.body.toString();
    setState(() {
      listProduk =
          List<Map<String, dynamic>>.from(json.decode(jsonProdukProduk));
    });
     print("GAMBARNYAAAAAA "+listProduk[0]['image_path'].toString());
    print("NAMANYAA "+listProduk[0]['nama']);
    print(jsonProdukProduk);
  }

  String jsonProdukProduk = "{}";
  List<Map<String, dynamic>> listProduk = [];
  Future<void> showProduk() async {
    final response = await http.get(Server.urlLaravel("semuaProduk"));
    jsonProdukProduk = response.body.toString();
    setState(() {
      listProduk =
          List<Map<String, dynamic>>.from(json.decode(jsonProdukProduk));
    });
    print(listProduk[0]['nama']);
  }

  Widget KumpulanProduk() {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: listProduk.isEmpty ? List.empty(): List.generate(
            listProduk.length,
            (index) => Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: GestureDetector(
                onTap: () {
                  List_Kelola_Produk.id_produk =
                      listProduk[index]['id'].toString();
                  cari_produk.kategori =
                      listProduk[index]['kategori'].toString();
                  print("id produk = " + List_Kelola_Produk.id_produk);

                  if (cari_produk.kategori == "kain") {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Edit_Produk_Kain()));
                  } else if (cari_produk.kategori == "kemeja") {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Edit_Produk_Kemeja()));
                  } else if (cari_produk.kategori == "kaos") {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    Edit_Produk_Kaos()));
                  }
                },
                child: Container(
                  width: double.infinity,
                  child: Card(
                    surfaceTintColor: CustomColors.whiteColor,
                    color: CustomColors.whiteColor,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          listProduk.isEmpty
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
                                        listProduk[index]['image_path']),
                                  ),
                                ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: listProduk.isEmpty
                                      ? Shimmer.fromColors(
                                          baseColor: Color.fromARGB(
                                              255, 104, 102, 102)!,
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
                                      : Container(
                                          width: 200,
                                          child: Text(
                                            listProduk[index]['nama'],
                                            style: CustomText.TextArvoBold(
                                                14, CustomColors.blackColor),
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.start,
                                          ),
                                        )),
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    listProduk.isEmpty
                                        ? Shimmer.fromColors(
                                            baseColor: Color.fromARGB(
                                                255, 104, 102, 102)!,
                                            highlightColor:
                                                const Color.fromARGB(
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
                                                listProduk[index]['harga']
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
                                                    style:
                                                        CustomText.TextArvoBold(
                                                            18,
                                                            CustomColors
                                                                .whiteColor),
                                                  ),
                                                  backgroundColor: CustomColors
                                                      .secondaryColor,
                                                  content: Text(
                                                    "Apakah Anda yakin ingin HAPUS produk ini?",
                                                    style: CustomText.TextArvo(
                                                        16,
                                                        CustomColors
                                                            .whiteColor),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                        deleteProductAndImages(
                                                            listProduk[index]
                                                                    ['id']
                                                                .toString());
                                                        print("pressed");
                                                      },
                                                      child: Text(
                                                        "Ya",
                                                        style: CustomText
                                                            .TextArvoBold(
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
                                                        style: CustomText
                                                            .TextArvoBold(
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
                                            Server.urlGambar(
                                                "icons_sampah.png"),
                                            height: 20,
                                          )),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
        ),
      ),
    );
  }

  final FocusNode cari = FocusNode();
  @override
  void initState() {
    showProduk();
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cari.requestFocus();
    });
  }

  final TextEditingController cariController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text("Kelola Produk",
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
                          color: CustomColors.secondaryColor, strokeAlign: 1)),
                  elevation: 10,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: TextField(
                      focusNode: cari,
                      keyboardType: TextInputType.text,
                      textAlign: TextAlign.start,
                      textInputAction: TextInputAction.next,
                      controller: cariController,
                      onChanged: (value) {
                          showProduk();
                       
                        showPencarian(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'Cari Produk...',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 10.0),
                      ),
                      style: CustomText.TextArvo(14, CustomColors.blackColor),
                    ),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            listProduk.isNotEmpty? KumpulanProduk() :SizedBox()
          ]),
        ),
      ),
    );
  }
}
