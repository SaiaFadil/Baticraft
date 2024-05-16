import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:baticraft/menu/TabTransaksi/subMenuTransaksi/page_detail_transaksi.dart';
import 'package:baticraft/menu/TabTransaksi/subMenuTransaksi/page_transaksi_berhasil.dart';
import 'package:baticraft/models/products.dart';
import 'package:baticraft/navigation/utama.dart';
import 'package:baticraft/pageSebelumLogin/page_login.dart';
import 'package:baticraft/src/CustomWidget.dart';
import 'package:flutter/services.dart';
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

// import 'package:screenshot/screenshot.dart';
// import 'package:path_provider/path_provider.dart';

class transaksi_berhasil extends StatefulWidget {
  transaksi_berhasil({super.key});

  @override
  State<transaksi_berhasil> createState() => _transaksi_berhasilState();
}

class _transaksi_berhasilState extends State<transaksi_berhasil> {
  late String tanggalSekarang;
  late List<Products> productList = [];

  Future<Uint8List> readFileBytes(String path) async {
    ByteData fileData = await rootBundle.load(path);
    Uint8List fileUnit8List = fileData.buffer
        .asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
    return fileUnit8List;
  }

  Future<Uint8List> _getImageFromAsset(String iconPath) async {
    return await readFileBytes(iconPath);
  }

// all method from sunmi printer need to async await
  @override
  void initState() {
    super.initState();
    final transactionManager =
        Provider.of<TransactionManager>(context, listen: false);
    tanggalSekarang =
        "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}";
    productList = transactionManager.productList;
   
  }

  int calculateTotalPrice(List<Products> productList) {
    int totalPrice = 0;
    for (var product in productList) {
      totalPrice += product.price * product.quantity;
    }
    return totalPrice;
  }

// ScreenshotController screenshotController = ScreenshotController();


  
  // Future<void> _saveScreenshot() async {
  //   final directory = (await getApplicationDocumentsDirectory()).path;
  //   final path = '$directory/screenshot.png';

  //   screenshotController.capture().then((Uint8List? image) async {
  //     if (image != null) {
  //       final file = File(path);
  //       await file.writeAsBytes(image);

  //       // Save image to gallery
  //       // final result = await ImageGallerySaver.saveImage(image, quality: 100, name: "screenshot");
  //       // print(result);

  //       // Show preview dialog
  //       showDialog(
  //         context: context,
  //         builder: (_) => AlertDialog(
  //           content: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               Image.memory(image),
  //               SizedBox(height: 20),
  //               TextButton(
  //                 onPressed: () => Navigator.of(context).pop(),
  //                 child: Text('Close'),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     }
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final transactionManager = Provider.of<TransactionManager>(context);
    final productList = transactionManager.productList;
    this.productList = productList;
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
                        Text("Detail Transaksi",
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
                        Text("Nama Kasir",
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
                        Text(detail_transaksi.kode_transaksi,
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
                        Text(MenuDashboard.nama,
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
                        Text("Rp ${HomeTransaksi.totalPrice.toInt()}",
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
                        Text("Rp ${detail_transaksi.tunai}",
                            style: CustomText.TextArvoBold(
                                14, CustomColors.blackColor)),
                        SizedBox(
                          height: 5,
                        ),
                        Text("Rp ${detail_transaksi.kembalian}",
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
                      onPressed: () {
                        // _saveScreenshot();
                      },
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
