import 'dart:convert';
import 'package:baticraft/menu/SubMenuHome/subMenuStatusPesanan/page_status_pesanan.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuStatusPesanan/subMenuRiwayat/TabMenuRiwayat/DetailRiwayatTransaksi/KonfirmasiBerhasil/page_berhasil_konfirmasi_transaksi.dart';
import 'package:baticraft/menu/TabTransaksi/subMenuTransaksi/transactionManager.dart';
import 'package:baticraft/menu/menu_dashboard.dart';
import 'package:baticraft/models/products.dart';
import 'package:baticraft/navigation/utama.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class DetailDiproses extends StatefulWidget {
  final String transactionId;

  DetailDiproses({Key? key, required this.transactionId}) : super(key: key);

  @override
  State<DetailDiproses> createState() => _DetailDiprosesState();
}

class _DetailDiprosesState extends State<DetailDiproses> {
// Fungsi untuk menambahkan produk ke dalam list produk
  void addProductToList(Map<dynamic, dynamic> productData) {
    bool isProductExist = productList
        .any((product) => product.id == productData['id'].toString());

    if (!isProductExist) {
      Products newProduct = Products(
        id: productData['id'].toString(),
        image: productData['image_path'].toString(),
        name: productData['nama_product'],
        price: productData['harga_total'],
        quantity: 1, // Jumlah awal produk adalah 1
      );
      productList.add(newProduct);
      setState(() {}); // Perbarui widget setelah penambahan produk
    } else {
      print('Produk sudah ada dalam list');
    }
  }

  void updateProductQuantity(int index, int quantity) {
    if (index >= 0 && index < productList.length) {
      productList[index].quantity += quantity;
      if (productList[index].quantity < 0) {
        productList[index].quantity = 1;
      }
      setState(() {}); // Perbarui widget setelah mengubah jumlah produk
    }
  }

  List<Products> productList = [];

  Future<void> TransactionDone(String id) async {
    try {
      var response = await http.post(
        Server.urlLaravel('PesananDiambil'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"id": id}),
      );

      if (response.statusCode == 200) {
        print('Transaksi berhasil ditambahkan');
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    konfirmasi_berhasil(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                }));
      } else {
        print('Gagal mengkonfirmasi transaksi: ${response.body}');
      }
    } catch (e) {
      CustomWidget.NotifGagal(context);
      print("Error: $e");
    }
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
          double kembalian = tunai - totalHarga;
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
                  child: Text("Total : Rp ${totalHarga.toInt()}",
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
                  Navigator.pop(context);

                  konfirmasi_berhasil.kembalian = kembalianController.text;
                  konfirmasi_berhasil.tunai = tunaiController.text;

                  print(konfirmasi_berhasil.kembalian);
                  print(konfirmasi_berhasil.tunai);

                  TransactionDone(widget.transactionId);
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

  Future<Map<String, dynamic>> fetchTransaction() async {
    final response = await http.post(
        Server.urlLaravel("showTransactionAndDetails"),
        body: {"id": widget.transactionId.toString()});

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load transaction');
    }
  }

  int totalHarga = 0;
  @override
  void initState() {
    TransactionManager tm = TransactionManager();
    tm.clearTransactionData();
    super.initState();
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
    final transactionManager =
        Provider.of<TransactionManager>(context, listen: false);
    void addAllProductsToTransaction() {
      // Pastikan productList tidak kosong
      if (productList.isNotEmpty) {
        // Iterasi melalui semua produk dalam productList
        for (int i = 0; i < productList.length; i++) {
          // Ambil informasi produk dari productList berdasarkan indeks
          Products productToAdd = productList[i];

          // Periksa apakah produk sudah ada dalam daftar transaksi berdasarkan ID
          bool isProductExist = transactionManager.productList
              .any((product) => product.id == productToAdd.id);

          // Jika produk belum ada dalam daftar transaksi, tambahkan produk
          if (!isProductExist) {
            transactionManager.addProduct(productToAdd);
          } else {
            print(
                'Produk dengan ID ${productToAdd.id} sudah ada dalam daftar transaksi');
          }
        }
        // Setelah selesai menambahkan produk, pindahkan ke halaman detail transaksi
      } else {
        print('ProductList kosong');
      }
    }

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

            totalHarga = transaction['total_harga'];

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  child: Card(
                      color: CustomColors.yellowColor,
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
                      Text(
                          "Pesanan sedang diproses, pembeli dapat mulai mengambil pesanan pada tanggal :",
                          style: CustomText.TextArvoBold(
                              12, CustomColors.blackColor)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          formatTanggal("${transaction['tanggal_konfirmasi']}"),
                          style: CustomText.TextArvoBold(
                              14, CustomColors.blackColor)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Tanggal Pengambilan Kadaluarsa :",
                          style: CustomText.TextArvoBold(
                              12, CustomColors.blackColor)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                          formatTanggal("${transaction['tanggal_konfirmasi']}"),
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
                      Text(
                          transaction['catatan_customer'] != null
                              ? "${transaction['catatan_customer']}"
                              : "Tidak ada catatan",
                          style: CustomText.TextArvoBold(
                              12, CustomColors.blackColor)),
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  color: CustomColors.HintColor,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                        onPressed: () {
                          konfirmasi_berhasil.kodeTR =
                              "${transaction['kode_transaksi']}";
                          konfirmasi_berhasil.totalPesanan =
                              "${transaction['total_harga']}";
                              
                          konfirmasi_berhasil.nama =
                              "${transaction['nama_pembeli']}";
                          konfirmasi_berhasil.namaKasir =
                              "${transaction['kasir']}";

                          print(konfirmasi_berhasil.kodeTR);
                          print(konfirmasi_berhasil.totalPesanan);
                          if (details.isNotEmpty) {
                            for (int i = 0; i < details.length; i++) {
                              addProductToList(details[i]);
                              addAllProductsToTransaction();
                            }
                          }
                          showPaymentDialog(context);
                        },
                        style: CustomButton.DefaultButton(
                            CustomColors.secondaryColor),
                        child: Text(
                          "Pesanan Diambil",
                          style: CustomText.TextArvoBold(
                              16, CustomColors.whiteColor),
                        )),
                  ),
                ),
                SizedBox(
                  height: 30,
                )
              ],
            );
          }
        },
      ),
    );
  }
}
