import 'dart:convert';
import 'package:baticraft/menu/TabTransaksi/HomeRiwayat.dart';
import 'package:baticraft/menu/menu_dashboard.dart';
import 'package:baticraft/navigation/utama.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DetailDitolak extends StatelessWidget {
  final String transactionId;

  DetailDitolak({Key? key, required this.transactionId}) : super(key: key);

  Future<Map<String, dynamic>> fetchTransaction() async {
    final response = await http.post(
        Server.urlLaravel("showTransactionAndDetails"),
        body: {"id": transactionId.toString()});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load transaction');
    }
  }

  // Fungsi untuk memformat tanggal ke dalam format dd/mm/yyyy
  String formatTanggal(String tanggal) {
    // Memecah tanggal menjadi bagian-bagian
    List<String> parts = tanggal.split(' ')[0].split('-');
    // Menggabungkan bagian-bagian tersebut dalam format yang diinginkan
    return '${parts[2]}/${parts[1]}/${parts[0]}';
  }

  String formatJam(String tanggal) {
    // Memecah tanggal menjadi bagian-bagian
    List<String> parts = tanggal.split(' ')[1].split(':');
    // Menggabungkan bagian-bagian tersebut dalam format yang diinginkan
    return '${parts[0]}.${parts[1]}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text("Detail Riwayat Transaksi",
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
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchTransaction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic> transaction = snapshot.data!;
            List<dynamic> details = transaction['details'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Card(
                      color: CustomColors.redColor,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        child: Text("${transaction['status_transaksi']}",
                            style: CustomText.TextArvoBold(
                                16, CustomColors.whiteColor)),
                      )),
                ),
                Container(
                  margin: EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Catatan : \n${transaction['catatan_admin']}",
                          style: CustomText.TextArvoBold(
                              14, CustomColors.blackColor)),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: CustomColors.HintColor,
                  height: 1,
                ),
                SizedBox(
                  height: 20,
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
                          Text("${transaction['kode_transaksi']}",
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.blackColor)),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              transaction['created_at'].toString().isEmpty
                                  ? formatTanggal(
                                          "${transaction['created_at']}") +
                                      "       " +
                                      formatJam("${transaction['created_at']}")
                                  : formatTanggal(
                                          "${transaction['tanggal_konfirmasi']}") +
                                      "       " +
                                      formatJam(
                                          "${transaction['tanggal_konfirmasi']}"),
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.blackColor)),
                          SizedBox(
                            height: 5,
                          ),
                          Text("${transaction['nama_pembeli']}",
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
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: details.length,
                    itemBuilder: (context, index) {
                      var detail = details[index];
                      return Column(
                        children: [
                          Container(
                            height: 90,
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: Card(
                                          surfaceTintColor:
                                              CustomColors.whiteColor,
                                          color: CustomColors.whiteColor,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Image.network(
                                            fit: BoxFit.fitWidth,
                                            height: 120,
                                            Server.urlLaravelImageProduct(
                                                "${detail['image_path']}"),
                                          ),
                                        ),
                                      ),
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
                                            width: 190,
                                            child: Text(
                                              "${detail['nama_product']}",
                                              style: CustomText.TextArvoBold(
                                                14,
                                                CustomColors.blackColor,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Container(
                                              child: Text(
                                                "${detail['jumlah']} x Rp ${detail['harga_total']}",
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
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(right: 10),
                                        child: Text(
                                          "Rp ${detail['harga_total']}",
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
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 1,
                            color: CustomColors.HintColor,
                          )
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  height: 1,
                  color: CustomColors.HintColor,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Pesanan ( ${details.length} item )",
                          style: CustomText.TextArvoBold(
                              14, CustomColors.blackColor)),
                      Text("Rp ${transaction['total_harga']}",
                          style: CustomText.TextArvoBold(
                              14, CustomColors.redColor)),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: CustomColors.HintColor,
                ),
               
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Catatan :",
                          style: CustomText.TextArvoBold(
                              12, CustomColors.blackColor)),
                              SizedBox(
                            height: 10,
                          ),
                      Text(transaction['catatan_customer'] != null ?"${transaction['catatan_customer']}":"Tidak Ada Catatan",
                          style: CustomText.TextArvoBold(
                              14, CustomColors.blackColor)),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: CustomColors.HintColor,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
