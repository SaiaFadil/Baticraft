import 'dart:convert';
import 'dart:io';
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

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:pdf/src/widgets/document.dart';
import 'dart:math';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

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

  final pdf = pw.Document();
 

  Future<void> printAndSavePdf(pw.Document pdf) async {
    // Use the Printing package to handle the printing/layout
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());

    // Optionally, save the document to a file for further use
    Directory appDocDirectory = await getApplicationDocumentsDirectory();
    Directory newDirectory =
        await Directory('${appDocDirectory.path}/dir').create(recursive: true);
    print('Path of New Dir: ${newDirectory.path}');

    final file = File('${newDirectory.path}/example1.pdf');
    await file.writeAsBytes(await pdf.save());
    Navigator.push(context, PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) => utama(),transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(opacity: animation,child: child,);
    },));
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
                      onPressed: ()  async {
                        final fontData = await rootBundle
                            .load("assets/fonts/OpenSans-Italic.ttf");
                        final ttf = pw.Font.ttf(fontData);

                        // Create a new PDF document
                        final pdf = pw.Document();

                        pdf.addPage(
                          pw.Page(
                            pageFormat: PdfPageFormat.a5,
                            build: (context) => pw.Center(
                                child: pw.Column(
                              children: [
                                pw.SizedBox(
                                  height: 20,
                                ),
                                pw.Align(
                                    alignment: pw.Alignment.center,
                                    child: pw.Text(
                                      "Transaksi Berhasil!",style: pw.TextStyle(font: ttf)
                                    )),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Container(
                                  color: HintColor,
                                  height: 1,
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Container(
                                  margin: pw.EdgeInsets.only(left: 20),
                                  child: pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.start,
                                    children: [
                                      pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(style: pw.TextStyle(font: ttf),
                                            "Detail Transaksi",
                                          ),
                                          pw.SizedBox(
                                            height: 5,
                                          ),
                                          pw.Text(style: pw.TextStyle(font: ttf),
                                            "Tanggal",
                                          ),
                                          pw.SizedBox(
                                            height: 5,
                                          ),
                                          pw.Text(style: pw.TextStyle(font: ttf),
                                            "Nama",
                                          ),
                                        ],
                                      ),
                                      pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(style: pw.TextStyle(font: ttf),
                                            "  :  ",
                                          ),
                                          pw.SizedBox(
                                            height: 5,
                                          ),
                                          pw.Text(style: pw.TextStyle(font: ttf),
                                            "  :  ",
                                          ),
                                          pw.SizedBox(
                                            height: 5,
                                          ),
                                          pw.Text(style: pw.TextStyle(font: ttf),
                                            "  :  ",
                                          ),
                                        ],
                                      ),
                                      pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.start,
                                        children: [
                                          pw.Text(style: pw.TextStyle(font: ttf),
                                            konfirmasi_berhasil.kodeTR,
                                          ),
                                          pw.SizedBox(
                                            height: 5,
                                          ),
                                          pw.Text(style: pw.TextStyle(font: ttf),
                                            tanggalSekarang,
                                          ),
                                          pw.SizedBox(
                                            height: 5,
                                          ),
                                          pw.Text(style: pw.TextStyle(font: ttf),
                                            konfirmasi_berhasil.nama,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Container(
                                  color: HintColor,
                                  height: 1,
                                ),

                                pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.center,
                                  children: productList.isEmpty
                                      ? List.empty()
                                      : List.generate(
                                          productList.length,
                                          (index) => pw.Column(
                                            children: [
                                              pw.Container(
                                                height: 60,
                                                width: double.infinity,
                                                child: pw.Padding(
                                                  padding:
                                                      pw.EdgeInsets.symmetric(
                                                          horizontal: 10),
                                                  child: pw.Row(
                                                    mainAxisAlignment: pw
                                                        .MainAxisAlignment
                                                        .spaceBetween,
                                                    crossAxisAlignment: pw
                                                        .CrossAxisAlignment
                                                        .center,
                                                    children: [
                                                      pw.Row(
                                                        children: [
                                                          pw.Column(
                                                            crossAxisAlignment: pw
                                                                .CrossAxisAlignment
                                                                .start,
                                                            mainAxisAlignment: pw
                                                                .MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              pw.Container(
                                                                
                                                                padding: pw
                                                                        .EdgeInsets
                                                                    .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                ),
                                                                width: 200,
                                                                child: pw.Text(style: pw.TextStyle(font: ttf),
                                                                  productList[
                                                                          index]
                                                                      .name
                                                                      .toString(),
                                                                  maxLines: 2,
                                                                  textAlign: pw
                                                                      .TextAlign
                                                                      .start,
                                                                ),
                                                              ),
                                                              pw.SizedBox(
                                                                  height: 5),
                                                              pw.Container(
                                                                padding: pw
                                                                        .EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            10),
                                                                child: pw
                                                                    .Container(
                                                                  child:
                                                                      pw.Text(style: pw.TextStyle(font: ttf),
                                                                    "${productList[index].quantity} x Rp ${productList[index].price}",
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      pw.Column(
                                                        mainAxisAlignment: pw
                                                            .MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          pw.Container(
                                                            padding: pw
                                                                    .EdgeInsets
                                                                .only(
                                                                    right: 10),
                                                            child: pw.Text(style: pw.TextStyle(font: ttf),
                                                              "Rp." +
                                                                  productList[
                                                                          index]
                                                                      .price
                                                                      .toString(),
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
                                pw.Container(
                                  color: HintColor,
                                  height: 1,
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                //Total detail
                                pw.Container(
                                  margin:
                                      pw.EdgeInsets.only(left: 20, right: 10),
                                  child: pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Row(
                                        children: [
                                          pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(style: pw.TextStyle(font: ttf),
                                                "Total Pesanan",
                                              ),
                                              pw.SizedBox(
                                                height: 5,
                                              ),
                                              pw.Text(style: pw.TextStyle(font: ttf),
                                                "Total Item",
                                              ),
                                              pw.SizedBox(
                                                height: 5,
                                              ),
                                              pw.Text(style: pw.TextStyle(font: ttf),
                                                "Tunai",
                                              ),
                                              pw.SizedBox(
                                                height: 5,
                                              ),
                                              pw.Text(style: pw.TextStyle(font: ttf),
                                                "Kembalian",
                                              ),
                                            ],
                                          ),
                                          pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(style: pw.TextStyle(font: ttf),
                                                "  :  ",
                                              ),
                                              pw.SizedBox(
                                                height: 5,
                                              ),
                                              pw.Text(style: pw.TextStyle(font: ttf),
                                                "  :  ",
                                              ),
                                              pw.SizedBox(
                                                height: 5,
                                              ),
                                              pw.Text(style: pw.TextStyle(font: ttf),
                                                "  :  ",
                                              ),
                                              pw.SizedBox(
                                                height: 5,
                                              ),
                                              pw.Text(style: pw.TextStyle(font: ttf),
                                                "  :  ",
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      pw.Column(
                                        crossAxisAlignment:
                                            pw.CrossAxisAlignment.end,
                                        children: [
                                          pw.Text(style: pw.TextStyle(font: ttf),
                                            "Rp ${konfirmasi_berhasil.totalPesanan}",
                                          ),
                                          pw.SizedBox(
                                            height: 5,
                                          ),
                                          pw.Text(style: pw.TextStyle(font: ttf),
                                            " ${productList.length} item ",
                                          ),
                                          pw.SizedBox(
                                            height: 5,
                                          ),
                                          pw.Text(style: pw.TextStyle(font: ttf),
                                            "Rp ${konfirmasi_berhasil.tunai}",
                                          ),
                                          pw.SizedBox(
                                            height: 5,
                                          ),
                                          pw.Text(style: pw.TextStyle(font: ttf),
                                            "Rp ${konfirmasi_berhasil.kembalian}",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                pw.SizedBox(
                                  height: 10,
                                ),
                                pw.Container(
                                  color: HintColor,
                                  height: 1,
                                ),
                                pw.SizedBox(
                                  height: 50,
                                ),
                                pw.SizedBox(
                                  height: 50,
                                ),
                              ],
                            )),
                          ),
                        );
                        await printAndSavePdf(pdf);
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
  

  PdfColor secondaryColor = PdfColor(0, 0, 0); // Adjust color as needed
  PdfColor blackColor = PdfColor(0, 0, 0); // Adjust color as needed
  PdfColor HintColor = PdfColor(0.5, 0.5, 0.5);
}
