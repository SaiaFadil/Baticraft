import 'dart:convert';

import 'package:baticraft/menu/SubMenuHome/subMenuStatusPesanan/subMenuPesanan/page_detail_pesanan.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:flutter/material.dart';

import 'package:baticraft/src/Server.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class list_pesanan extends StatefulWidget {
  const list_pesanan({super.key});

  @override
  State<list_pesanan> createState() => _list_pesananState();
}

class _list_pesananState extends State<list_pesanan> {
  String jsonProdukPesanan = "{}";
  List<Map<String, dynamic>> listPesanan = [];
  final TextEditingController cariController = TextEditingController();

  String jsonProdukUser = "{}";

  @override
  void initState() {
    showPesanan();
    super.initState();
  }

  Future<void> showPesanan() async {
    final response = await http.get(Server.urlLaravel("getTransactionData"));
    jsonProdukPesanan = response.body.toString();
    setState(() {
      listPesanan =
          List<Map<String, dynamic>>.from(json.decode(jsonProdukPesanan));
    });
  }

  Future showPencarian(String searchText) async {
    final response = await http.post(
        Server.urlLaravel("getCariTransactionData"),
        body: {'search': searchText});
    jsonProdukUser = response.body.toString();
    setState(() {
      listPesanan =
          List<Map<String, dynamic>>.from(json.decode(jsonProdukUser));
    });
    print(jsonProdukUser);
  }

  String formatTanggal(String tanggal) {
    List<String> parts = tanggal.split(' ')[0].split('-');
    return '${parts[2]}/${parts[1]}/${parts[0]}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    controller: cariController,
                    onChanged: (value) {
                      // showPesanan();
                      if (value.isNotEmpty) {
                        showPencarian(value);
                      } else {
                        showPesanan();
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari Nama...',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
                    ),
                    style: CustomText.TextArvo(14, CustomColors.blackColor),
                  ),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          listPesanan.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: listPesanan.isEmpty
                      ? List.empty()
                      : List.generate(
                          listPesanan.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                            ),
                            child: Card(
                              surfaceTintColor: CustomColors.whiteColor,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.all(13),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              child: Image.asset(
                                                Server.urlGambar(
                                                    "ic_keranjang.png"),
                                                fit: BoxFit.contain,
                                                height: 15,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              listPesanan[index]
                                                          ['kode_transaksi'] ==
                                                      null
                                                  ? ""
                                                  : listPesanan[index]
                                                          ['kode_transaksi']
                                                      .toString(),
                                              style: CustomText.TextArvoBold(
                                                  12, CustomColors.blackColor),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          listPesanan[index]['tanggal'] == null
                                              ? ""
                                              : listPesanan[index]['tanggal']
                                                  .toString(),
                                          style: CustomText.TextArvoBold(
                                              12, CustomColors.blackColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            listPesanan[index]['image'] != null
                                                ? CircleAvatar(
                                                    radius:
                                                        22, // Ubah ukuran avatar
                                                    backgroundImage: NetworkImage(
                                                        Server.urlLaravelImageUser(
                                                            listPesanan[index][
                                                                'image'])) // Ganti URL gambar sesuai kebutuhan
                                                    )
                                                : CircleAvatar(
                                                    radius:
                                                        22, // Ubah ukuran avatar
                                                    child: Icon(
                                                      Icons.person,
                                                      size: 25,
                                                    ),
                                                  ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  listPesanan[index]['nama'] ==
                                                          null
                                                      ? ""
                                                      : listPesanan[index]
                                                              ['nama']
                                                          .toString(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      CustomText.TextArvoBold(
                                                          14,
                                                          CustomColors
                                                              .blackColor),
                                                ),
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    listPesanan[index][
                                                                'nama_barang'] ==
                                                            null
                                                        ? ""
                                                        : listPesanan[index]
                                                                ['nama_barang']
                                                            .toString(),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: CustomText.TextArvo(
                                                        12,
                                                        CustomColors
                                                            .blackColor),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        //button
                                        Container(
                                          height: 30,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              String id = listPesanan[index]
                                                      ['id']
                                                  .toString();
                                              print("id : "+id);
                                              Navigator.pushReplacement(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DetailPesanan(
                                                          transactionId: id,
                                                          namaPembeli:
                                                              listPesanan[index]
                                                                      ['nama']
                                                                  .toString(),
                                                          catatanCustomer: listPesanan[
                                                                          index]
                                                                      [
                                                                      'catatan_customer'] ==
                                                                  null
                                                              ? "Tidak ada catatan"
                                                              : listPesanan[
                                                                      index][
                                                                  'catatan_customer'],
                                                        )),
                                              );
                                            },
                                            style: CustomButton.miniButton(
                                                CustomColors.secondaryColor),
                                            child: Text(
                                              "Lihat",
                                              textAlign: TextAlign.left,
                                              style: CustomText.TextArvoBold(
                                                  12, CustomColors.whiteColor),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
              : Center(
                  child: Text(
                    "BELUM ADA PESANAN ",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CustomText.TextArvo(12, CustomColors.blackColor),
                  ),
                )
        ]),
      ),
    );
  }
}
