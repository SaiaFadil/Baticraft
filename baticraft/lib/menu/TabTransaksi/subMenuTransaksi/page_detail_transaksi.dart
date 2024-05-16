import 'dart:convert';
import 'package:baticraft/menu/TabTransaksi/subMenuTransaksi/page_transaksi_berhasil.dart';
import 'package:baticraft/models/products.dart';
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

class detail_transaksi extends StatefulWidget {
  const detail_transaksi({super.key});
  static String kode_transaksi = "";
  static String tunai = "";
  static String kembalian = "";
  @override
  State<detail_transaksi> createState() => _detail_transaksiState();
}

class _detail_transaksiState extends State<detail_transaksi> {
  late String tanggalSekarang;
  late String kodeTransaksi;
  late List<Products> productList = [];

  String generateRandomString() {
    // Mendapatkan tanggal saat ini
    DateTime now = DateTime.now();
    // Format tanggal dengan 'yyyyMMdd'
    String formattedDate =
        "${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}";
    tanggalSekarang =
        "${now.day.toString().padLeft(2, '0')}/${now.month.toString().padLeft(2, '0')}/${now.year}";
    tanggal_sekarang =
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

    const possibleChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    String randomChars = List.generate(
            4, (index) => possibleChars[Random().nextInt(possibleChars.length)])
        .join();

    String randomString = '$formattedDate$randomChars';

    return randomString;
  }

  Future<void> insertNewTransaction(List<Products> products) async {
    final transactionData = {
      'kode_transaksi': KodeTransaksi,
      'user_id': page_login.id_user,
      'kasir': MenuDashboard.nama,
      'jenis_transaksi': 'langsung',
      'total_item': products.length,
      'total_harga': HomeTransaksi.totalPrice,
      'status_transaksi':
          'selesai', // Ganti dengan status transaksi yang sesuai
      'tanggal_konfirmasi': tanggal_sekarang,
      'transaction_details':
          products.map((product) => product.toMap()).toList(),
    };

    try {
      final response = await http.post(
        Server.urlLaravel("insertNew"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(transactionData),
      );

      if (response.statusCode == 201) {
        print('Transaksi berhasil ditambahkan');
        detail_transaksi.tunai = tunaiController.text.toString();
        detail_transaksi.kembalian = kembalianController.text.toString();
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    transaksi_berhasil(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                }));
      } else {
        print('Gagal menambahkan transaksi: ${response.body}');

        print(transactionData.toString());
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  String KodeTransaksi = "";
  @override
  void initState() {
    super.initState();
    KodeTransaksi = generateRandomString();
    detail_transaksi.kode_transaksi = KodeTransaksi;
    print("detail kode = " + detail_transaksi.kode_transaksi);
    print(KodeTransaksi);
    final transactionManager =
        Provider.of<TransactionManager>(context, listen: false);
    tanggalSekarang =
        "${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().year}";
    productList = transactionManager.productList;
  }

  String tanggal_sekarang = "";

// Fungsi untuk menghitung total harga dari productList
  int calculateTotalPrice(List<Products> productList) {
    int totalPrice = 0;
    for (var product in productList) {
      totalPrice += product.price * product.quantity;
    }
    return totalPrice;
  }

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
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(Server.urlGambar("ictrans.png")),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Detail Transaksi",
                          style: CustomText.TextArvoBold(
                              16, CustomColors.blackColor)),
                    ],
                  ),
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
                          Text("Tanggal",
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.blackColor)),
                          Text("Nama Kasir",
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.blackColor)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("  : ",
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.blackColor)),
                          Text("  : ",
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.blackColor)),
                          Text("  : ",
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.blackColor)),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(KodeTransaksi,
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.blackColor)),
                          Text(tanggalSekarang,
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.blackColor)),
                          Text(MenuDashboard.nama,
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.blackColor)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
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
                                height: 90,
                                width: double.infinity,
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                                    productList[index].image),
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
                                                  productList[index]
                                                      .name
                                                      .toString(),
                                                  style:
                                                      CustomText.TextArvoBold(
                                                    14,
                                                    CustomColors.blackColor,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                    style: CustomText.TextArvo(
                                                        14,
                                                        CustomColors
                                                            .blackColor),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
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
                              Container(
                                height: 1,
                                color: CustomColors.HintColor,
                              )
                            ],
                          ),
                        ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Pesanan ( ${productList.length} item )",
                          style: CustomText.TextArvoBold(
                              14, CustomColors.blackColor)),
                      Text("Rp ${HomeTransaksi.totalPrice.toInt()}",
                          style: CustomText.TextArvoBold(
                              14, CustomColors.redColor)),
                    ],
                  ),
                ),
                Container(height: 1, color: CustomColors.HintColor),
                Container(
                    margin: EdgeInsets.symmetric(vertical: 50),
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () {
                          showPaymentDialog(context);
                        },
                        child: Text(
                          "Konfirmasi",
                          style: CustomText.TextArvoBold(
                              16, CustomColors.whiteColor),
                        ),
                        style:
                            CustomButton.NewModel(CustomColors.secondaryColor)))
              ],
            ),
          ),
        ));
  }

  TextEditingController tunaiController = TextEditingController();
  TextEditingController kembalianController = TextEditingController();
  showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        tunaiController.addListener(() {
          // Ambil nilai tunai yang dimasukkan pengguna
          double tunai = double.tryParse(tunaiController.text) ?? 0.0;

          // Hitung kembalian
          double kembalian = tunai - HomeTransaksi.totalPrice;
          if (kembalian < 0) {
            print("NILAI NEGATIF");
            kembalianController.text = "Tunai Tidak Mencukupi";
          } else {
            // Tampilkan kembalian di kolom kembalian
            kembalianController.text = kembalian.toInt().toString();
          }
        });
        return AlertDialog(
          surfaceTintColor: CustomColors.whiteColor,
          elevation: 10,
          backgroundColor: CustomColors.whiteColor,
          title: Text("PEMBAYARAN",
              textAlign: TextAlign.center,
              style: CustomText.TextArvo(20, CustomColors.blackColor)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 1,
                color: CustomColors.HintColor,
                width: double.infinity,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Total : Rp ${HomeTransaksi.totalPrice.toInt()}",
                      style:
                          CustomText.TextArvoBold(20, CustomColors.blackColor)),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Tunai",
                    style: CustomText.TextArvo(14, CustomColors.blackColor)),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start,
                        textInputAction: TextInputAction.next,
                        controller: tunaiController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: CustomColors.secondaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: CustomColors.blackColor),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10.0),
                        ),
                        style: CustomText.TextArvo(14, CustomColors.blackColor),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Kembalian",
                    style: CustomText.TextArvo(14, CustomColors.blackColor)),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: TextField(
                        keyboardType: TextInputType.number,
                        enabled: false,
                        textAlign: TextAlign.start,
                        textInputAction: TextInputAction.next,
                        controller: kembalianController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: CustomColors.secondaryColor),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide:
                                BorderSide(color: CustomColors.blackColor),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 0, horizontal: 10.0),
                        ),
                        style: CustomText.TextArvo(14, CustomColors.blackColor),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              style: CustomButton.NewModel(CustomColors.secondaryColor),
              onPressed: () {
                if (kembalianController.text != "Tunai Tidak Mencukupi" &&
                    kembalianController.text.isNotEmpty &&
                    tunaiController.text.isNotEmpty) {
                  Navigator.of(context).pop();
                  insertNewTransaction(productList);
                } else {
                  CustomWidget.NotifGagalBayar(context);
                }
              },
              child: Align(
                alignment: Alignment.center,
                child: Text("Transaksi",
                    style:
                        CustomText.TextArvoBold(16, CustomColors.whiteColor)),
              ),
            ),
          ],
        );
      },
    );
  }
}
