import 'package:baticraft/menu/SubMenuHome/subMenuStatusPesanan/page_status_pesanan.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class KonfirmasiPesanan extends StatefulWidget {
  final String kodePesanan;
  final String tanggal;
  final String nama;
  final String pembayaran;
  final String transactionId;

  KonfirmasiPesanan({
    Key? key,
    required this.kodePesanan,
    required this.tanggal,
    required this.nama,
    required this.transactionId,
    required this.pembayaran,
  }) : super(key: key);

  @override
  _KonfirmasiPesananState createState() => _KonfirmasiPesananState();
}

class _KonfirmasiPesananState extends State<KonfirmasiPesanan> {
  final TextEditingController TglPengambilan = TextEditingController();
  final TextEditingController TglKadaluarsa = TextEditingController();
  final TextEditingController AlasanPesanan = TextEditingController();




  Future<void> rejectTransaction(String id, String adminNote) async {
    try {
      var response = await http.post(
        Server.urlLaravel('tolakPesanan'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": id, "catatan_admin": adminNote}),
      );

      if (response.statusCode == 200) {
        CustomWidget.NotifBerhasil(context);

        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  StatusPesanan(),
            ));
      } else {
        CustomWidget.NotifGagal(context);
      }
    } catch (e) {
      CustomWidget.NotifGagal(context);
      print("Error: $e");
    }
  }

  Future<void> processTransaction(
      String id, String konfirmasi, String expired) async {
    try {
      var response = await http.post(
        Server.urlLaravel('prosesPesanan'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "id": id,
          "tanggal_konfirmasi": konfirmasi,
          "tanggal_expired": expired,
        }),
      );

      if (response.statusCode == 200) {
        CustomWidget.NotifBerhasil(context);

        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  StatusPesanan(),
            ));
      } else {
        print(response.body);
        CustomWidget.NotifGagal(context);
      }
    } catch (e) {
      print(e);
      CustomWidget.NotifGagal(context);
    }
  }

  bool isChecked = false;
@override
  void initState() {
    print("idd "+widget.transactionId);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text("Konfirmasi Pesanan",
            style: CustomText.TextArvoBold(16, CustomColors.threertyColor),
            textAlign: TextAlign.center),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      StatusPesanan(),
                ));
          },
          icon: Icon(Icons.arrow_back_ios),
          color: CustomColors.threertyColor,
        ),
        shadowColor: CustomColors.blackColor,
        centerTitle: true,
        surfaceTintColor: CustomColors.whiteColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Kode Pesanan",
                      style:
                          CustomText.TextArvoBold(16, CustomColors.blackColor)),
                  Text(widget.kodePesanan,
                      style:
                          CustomText.TextArvoBold(16, CustomColors.blackColor)),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Tanggal",
                      style:
                          CustomText.TextArvoBold(16, CustomColors.blackColor)),
                  Text(widget.tanggal,
                      style:
                          CustomText.TextArvoBold(16, CustomColors.blackColor)),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Nama",
                      style:
                          CustomText.TextArvoBold(16, CustomColors.blackColor)),
                  Text(widget.nama,
                      style:
                          CustomText.TextArvoBold(16, CustomColors.blackColor)),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Pembayaran",
                      style:
                          CustomText.TextArvoBold(16, CustomColors.blackColor)),
                  Text("Rp ${widget.pembayaran}",
                      style:
                          CustomText.TextArvoBold(16, CustomColors.blackColor)),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Metode Pembayaran",
                      style:
                          CustomText.TextArvoBold(16, CustomColors.blackColor)),
                  Text("Tunai",
                      style:
                          CustomText.TextArvoBold(16, CustomColors.blackColor)),
                ],
              ),
            ),
            Divider(),
            CheckboxListTile(
              value: isChecked,
              onChanged: (bool? value) {
                setState(() {
                  isChecked = value!;
                });
              },
              title: Text(
                'Setuju untuk konfirmasi pesanan ${widget.kodePesanan} dengan total pembayaran Rp ${widget.pembayaran}',
                style: CustomText.TextArvoBold(
                    14,
                    isChecked == true
                        ? CustomColors.blackColor
                        : CustomColors.redColor),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Visibility(
                visible: isChecked,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          _popUpTolak(context);
                        },
                        style: CustomButton.NewModel(CustomColors.redColor),
                        child: Text(
                          "Tolak",
                          style: CustomText.TextArvoBold(
                              18, CustomColors.whiteColor),
                        )),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _popUpProses(context);
                        },
                        style: CustomButton.NewModel(CustomColors.yellowColor),
                        child: Text(
                          "Proses",
                          style: CustomText.TextArvoBold(
                              18, CustomColors.whiteColor),
                        )),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  DateTime? startDate;
  DateTime? endDate;
  Future<void> _selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        String formattedDate =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        TglPengambilan.text = formattedDate;
      });
    }
  }

  Future<void> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
        String formattedDate =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";

        // Check if endDate is before startDate
        if (endDate!.isBefore(startDate!)) {
          TglKadaluarsa.text = "TIDAK VALID";
          print("Tanggal kadaluarsa harus setelah tanggal pengambilan!");
        } else {
          TglKadaluarsa.text = formattedDate;
        }
      });
    }
  }

  void _popUpProses(BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              content: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Konfirmasi Tanggal Pengambilan Pesanan : ",
                        style: CustomText.TextArvoBold(
                            10, CustomColors.blackColor)),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Material(
                        color: CustomColors.iosColor,
                        child: TextField(
                          onTap: () {
                            // Panggil fungsi untuk menampilkan date picker di sini
                            _selectDate1(context);
                          },
                          keyboardType: TextInputType.datetime,
                          textAlign: TextAlign.start,
                          textInputAction: TextInputAction.next,
                          controller: TglPengambilan,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: CustomColors.secondaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: CustomColors.blackColor),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10.0),
                          ),
                          style:
                              CustomText.TextArvo(14, CustomColors.blackColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text("Tanggal Pengambilan Kadaluarsa : ",
                        style: CustomText.TextArvoBold(
                            10, CustomColors.blackColor)),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Material(
                        color: CustomColors.iosColor,
                        child: TextField(
                          onTap: () {
                            // Panggil fungsi untuk menampilkan date picker di sini
                            _selectDate2(context);
                          },
                          keyboardType: TextInputType.datetime,
                          textAlign: TextAlign.start,
                          textInputAction: TextInputAction.next,
                          controller: TglKadaluarsa,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: CustomColors.secondaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: CustomColors.blackColor),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10.0),
                          ),
                          style:
                              CustomText.TextArvo(14, CustomColors.blackColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text("Catatan : ",
                        style: CustomText.TextArvoBold(
                            10, CustomColors.blackColor)),
                    SizedBox(height: 5),
                    Text(
                      "Pembeli akan mulai menggambil pesanan sesuai tanggal yang telah dikonfirmasi. Pengambilan pesanan akan dilakukan selama jam kerja di Griya Sri Siji Nganjuk",
                      style:
                          CustomText.TextArvoBold(10, CustomColors.blackColor),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Batal',
                    style: CustomText.TextArvoBold(17, CustomColors.blackColor),
                  ),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    if (TglKadaluarsa.text == "TIDAK VALID" ||
                        TglKadaluarsa.text.isEmpty ||
                        TglPengambilan.text.isEmpty) {
                      CustomWidget.KolomKosong(context);
                    } else {
                      processTransaction(widget.transactionId,
                          TglPengambilan.text, TglKadaluarsa.text);
                          print(TglPengambilan.text);
                          print(TglKadaluarsa.text);
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Kirim',
                      style:
                          CustomText.TextArvoBold(17, CustomColors.blackColor)),
                ),
              ],
            ));
  }

  void _popUpTolak(BuildContext context) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              content: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Alasan Pesanan Tidak Diterima : ",
                        style: CustomText.TextArvoBold(
                            12, CustomColors.blackColor)),
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Material(
                        color: CustomColors.iosColor,
                        child: TextField(
                          maxLines: 9,
                          keyboardType: TextInputType.multiline,
                          textAlign: TextAlign.start,
                          textInputAction: TextInputAction.next,
                          controller: AlasanPesanan,
                          maxLength: 255,
                          decoration: InputDecoration(
                            hintText:
                                "Contoh :\nMohon maaf pesanan anda tidak dapat kami proses, dikarenakan kami kehabisan stok pewarna kain.Maaf atas ketidaknyamanannya.",
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: CustomColors.secondaryColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  BorderSide(color: CustomColors.blackColor),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10.0),
                          ),
                          style:
                              CustomText.TextArvo(14, CustomColors.blackColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              actions: <CupertinoDialogAction>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Batal',
                    style: CustomText.TextArvoBold(17, CustomColors.blackColor),
                  ),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  onPressed: () {
                    if (AlasanPesanan.text.isEmpty) {
                      AlasanPesanan.text =
                          "Mohon maaf pesanan anda tidak dapat kami proses, dikarenakan kami kehabisan stok pewarna kain.Maaf atas ketidaknyamanannya";
                    } else {
                      rejectTransaction(widget.transactionId.toString(),
                          AlasanPesanan.text.toString());
                      Navigator.pop(context);
                    }
                  },
                  child: Text('Kirim',
                      style:
                          CustomText.TextArvoBold(17, CustomColors.blackColor)),
                ),
              ],
            ));
  }
}
