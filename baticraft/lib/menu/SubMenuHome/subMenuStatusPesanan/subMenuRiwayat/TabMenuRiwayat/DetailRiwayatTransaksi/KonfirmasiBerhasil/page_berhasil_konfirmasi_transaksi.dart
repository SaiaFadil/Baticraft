import 'dart:convert';
import 'package:baticraft/menu/TabTransaksi/subMenuTransaksi/page_detail_transaksi.dart';
import 'package:baticraft/menu/TabTransaksi/subMenuTransaksi/page_transaksi_berhasil.dart';
import 'package:baticraft/models/products.dart';
import 'package:baticraft/navigation/utama.dart';
import 'package:baticraft/pageSebelumLogin/page_login.dart';
import 'package:baticraft/src/CustomWidget.dart';
import 'package:http/http.dart' as http;
import 'package:baticraft/menu/TabTransaksi/HomeTransaksi.dart';
import 'package:baticraft/menu/TabTransaksi/subMenuTransaksi/transactionManager.dart';
import 'package:baticraft/menu/menu_dashboard.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class konfirmasi_berhasil extends StatefulWidget {
  konfirmasi_berhasil({super.key});
  static String kodeTR = "";
  static String totalPesanan = "";
  static String tunai = "";
  static String kembalian = "";
  static String nama = "";
  static String namaKasir = "";

  @override
  State<konfirmasi_berhasil> createState() => _konfirmasi_berhasilState();
}

class _konfirmasi_berhasilState extends State<konfirmasi_berhasil> {
  late String tanggalSekarang;
  late List<Products> productList = [];

  @override
  void initState() {
    super.initState();
    final transactionManager =
        Provider.of<TransactionManager>(context, listen: false);
    tanggalSekarang =
        "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}";
    productList = transactionManager.productList;
  }

  @override
  Widget build(BuildContext context) {
    final transactionManager = Provider.of<TransactionManager>(context);
    final productList = transactionManager.productList;
    this.productList = productList;
    print("LIST "+productList.toString());
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text("Transaksi",
              style: CustomText.TextArvoBold(16, CustomColors.threertyColor),
              textAlign: TextAlign.center),
          leading: IconButton(
            onPressed: () {
              productList.clear();
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
            color: CustomColors.threertyColor,
          ),
          shadowColor: CustomColors.blackColor,
          centerTitle: true,
          surfaceTintColor: CustomColors.whiteColor,
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  child: Image.asset(Server.urlGambar("ictransberhasill.png"))),
              SizedBox(
                height: 20,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Transaksi Berhasil!",
                    style: CustomText.TextArvoBold(
                        18, CustomColors.secondaryColor),
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                color: CustomColors.HintColor,
                height: 1,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Kode Pesanan",
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Tanggal",
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Nama",
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("  :  ",
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("  :  ",
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("  :  ",
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(konfirmasi_berhasil.kodeTR,
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(tanggalSekarang,
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(konfirmasi_berhasil.nama,
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: CustomColors.HintColor,
                height: 1,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: productList.isEmpty
                    ? List.empty()
                    : List.generate(
                        productList.length,
                        (index) => Column(
                          children: [
                            Container(
                              height: 60,
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              width: 200,
                                              child: Text(
                                                productList[index]
                                                    .name
                                                    .toString(),
                                                style: CustomText.TextArvoBold(
                                                  14,
                                                  CustomColors.blackColor,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            SizedBox(height: 5),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Container(
                                                child: Text(
                                                  "${productList[index].quantity} x Rp ${productList[index].price}",
                                                  style: CustomText.TextArvo(14,
                                                      CustomColors.blackColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(right: 10),
                                          child: Text(
                                            "Rp." +
                                                productList[index]
                                                    .price
                                                    .toString(),
                                            style: CustomText.TextArvoBold(
                                              14,
                                              CustomColors.blackColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
              Container(
                color: CustomColors.HintColor,
                height: 1,
              ),
              SizedBox(
                height: 10,
              ),
              //Total detail
              Container(
                margin: EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Total Pesanan",
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor)),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Total Item",
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor)),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Tunai",
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor)),
                            SizedBox(
                              height: 5,
                            ),
                            Text("Kembalian",
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("  :  ",
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor)),
                            SizedBox(
                              height: 5,
                            ),
                            Text("  :  ",
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor)),
                            SizedBox(
                              height: 5,
                            ),
                            Text("  :  ",
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor)),
                            SizedBox(
                              height: 5,
                            ),
                            Text("  :  ",
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor)),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Rp ${konfirmasi_berhasil.totalPesanan}",
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(" ${productList.length} item ",
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Rp ${konfirmasi_berhasil.tunai}",
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Rp ${konfirmasi_berhasil.kembalian}",
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: CustomColors.HintColor,
                height: 1,
              ),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: CustomButton.NewModel(CustomColors.greenColor),
                      onPressed: () {
                        productList.clear();
                        Navigator.pop(context);
                      },
                      child: Text("Selesai",
                          style: CustomText.TextArvoBold(
                              18, CustomColors.whiteColor))),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                      style: CustomButton.NewModel(CustomColors.secondaryColor),
                      onPressed: () {},
                      child: Text("Cetak",
                          style: CustomText.TextArvoBold(
                              18, CustomColors.whiteColor))),
                ],
              ),
              SizedBox(
                height: 50,
              ),
            ],
          )),
        ));
  }
}
