import 'dart:convert';

import 'package:baticraft/menu/TabTransaksi/subMenuTransaksi/page_detail_transaksi.dart';
import 'package:baticraft/menu/TabTransaksi/subMenuTransaksi/transactionManager.dart';
import 'package:baticraft/models/products.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:http/http.dart' as http;

class HomeTransaksi extends StatefulWidget {
  const HomeTransaksi({super.key});
  static double totalPrice = 0.0;
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

  void clearProductList() {
    setState(() {
      productList.clear();
    });
  }

  Future showPencarianKain(String searchText) async {
    final response = await http
        .post(Server.urlLaravel("searchKaintr"), body: {'search': searchText});
    jsonProdukKain = response.body.toString();
    setState(() {
      listKain = List<Map<String, dynamic>>.from(json.decode(jsonProdukKain));
    });
    print("GAMBARNYAAAAAA " + listKain[0]['image_path'].toString());
    print("NAMANYAA " + listKain[0]['nama']);
    print(jsonProdukKain);
  }

  Future showPencarianKemeja(String searchText) async {
    final response = await http.post(Server.urlLaravel("searchKemejatr"),
        body: {'search': searchText});
    jsonProdukKemeja = response.body.toString();
    setState(() {
      listKemeja =
          List<Map<String, dynamic>>.from(json.decode(jsonProdukKemeja));
    });
    print("GAMBARNYAAAAAA " + listKemeja[0]['image_path'].toString());
    print("NAMANYAA " + listKemeja[0]['nama']);
    print(jsonProdukKemeja);
  }

  Future showPencarianKaos(String searchText) async {
    final response = await http
        .post(Server.urlLaravel("searchKaostr"), body: {'search': searchText});
    jsonProdukBaju = response.body.toString();
    setState(() {
      listBaju = List<Map<String, dynamic>>.from(json.decode(jsonProdukBaju));
    });
    print("GAMBARNYAAAAAA " + listBaju[0]['image_path'].toString());
    print("NAMANYAA " + listBaju[0]['nama']);
    print(jsonProdukBaju);
  }
  Future<void> showKemeja() async {
    final response = await http.get(Server.urlLaravel("getProductsKemejatr"));
    jsonProdukKemeja = response.body.toString();
    setState(() {
      listKemeja =
          List<Map<String, dynamic>>.from(json.decode(jsonProdukKemeja));
    });
    print(listKemeja[0]['nama']);
  }
  Future<void> showKaos() async {
    final response = await http.get(Server.urlLaravel("getProductsKaostr"));
    jsonProdukBaju = response.body.toString();
    setState(() {
      listBaju = List<Map<String, dynamic>>.from(json.decode(jsonProdukBaju));
    });
    print(listBaju[0]['nama']);
  }
  Future<void> showKain() async {
    final response = await http.get(Server.urlLaravel("getProductsKaintr"));
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
        child: listKemeja.isEmpty
            ? Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 50),
                child: Text("Tidak Ada Produk Yang Tersisa",
                    style:
                        CustomText.TextArvoBold(16, CustomColors.blackColor)))
            : Row(
                children: List.generate(
                  listKemeja.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        print("PRINTT " + listKemeja[index].toString());
                        addProductToList(listKemeja[index]);
                      },
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
                                listKemeja[index]['image_path'] == null
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
                                    : Container(
                                        child: Image.network(
                                          fit: BoxFit.fitWidth,
                                          height: 120,
                                          Server.urlLaravelImageProduct(
                                              listKemeja[index]['image_path']),
                                        ),
                                      ),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: listKemeja.isEmpty
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      listKemeja.isEmpty
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
        child: listBaju.isEmpty
            ? Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 50),
                child: Text("Tidak Ada Produk Yang Tersisa",
                    style:
                        CustomText.TextArvoBold(16, CustomColors.blackColor)))
            : Row(
                children: List.generate(
                  listBaju.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        addProductToList(listBaju[index]);
                      },
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
                                listBaju[index]['image_path'] == null
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
                                    : Container(
                                        child: Image.network(
                                          fit: BoxFit.fitWidth,
                                          height: 120,
                                          Server.urlLaravelImageProduct(
                                              listBaju[index]['image_path']),
                                        ),
                                      ),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: listBaju.isEmpty
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      listBaju.isEmpty
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
                                                  listBaju[index]['harga']
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
  Widget KumpulanKain() {
    return Container(
      height: 230,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: listKain.isEmpty
            ? Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 50),
                child: Text("Tidak Ada Produk Yang Tersisa",
                    style:
                        CustomText.TextArvoBold(16, CustomColors.blackColor)))
            : Row(
                children: List.generate(
                  listKain.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        addProductToList(listKain[index]);
                      },
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
                                listKain[index]['image_path'] == null
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
                                    : Container(
                                        child: Image.network(
                                          fit: BoxFit.fitWidth,
                                          height: 120,
                                          Server.urlLaravelImageProduct(
                                              listKain[index]['image_path']),
                                        ),
                                      ),
                                Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 15),
                                    child: listKain.isEmpty
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      listKain.isEmpty
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
                                                  listKain[index]['harga']
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

  List<Products> productList = [];
  void removeProductFromList(int index) {
    setState(() {
      productList.removeAt(index);
      calculateTotalPrice();
      setState(() {});
    });
  }

// Fungsi untuk menambahkan produk ke dalam list produk
  void addProductToList(Map<dynamic, dynamic> productData) {
    try {
      bool isProductExist = productList
          .any((product) => product.id == productData['id'].toString());
// 
      if (!isProductExist) {
        Products newProduct = Products(
          id: productData['id'].toString(),
          image: productData['image_path'].toString(),
          name: productData['nama'],
          price: int.parse(productData['harga'].toString()),
          quantity: 1,
        );
        productList.add(newProduct);
        calculateTotalPrice();
        setState(() {});
      } else {
        print('Produk sudah ada dalam list');
      }
    } catch (e) {
      print(e);
      print(
        productData['image_path'].toString(),
      );
      print(
        productData['nama'],
      );
      print(
        productData['harga'],
      );
      print(
        productData['id'].toString(),
      );
    }
  }

  void updateProductQuantity(int index, int quantity) {
    if (index >= 0 && index < productList.length) {
      productList[index].quantity += quantity;
      if (productList[index].quantity < 0) {
        productList[index].quantity = 1;
      }
      calculateTotalPrice(); // Hitung total harga setelah mengubah jumlah produk
      setState(() {}); // Perbarui widget setelah mengubah jumlah produk
    }
  }

  double totalPrice = 0.0;
// Fungsi untuk menghitung total harga dari semua barang dalam productList
  void calculateTotalPrice() {
    totalPrice = 0.0; // Reset total harga ke nilai awal
    HomeTransaksi.totalPrice = 0.0;
    // Iterasi melalui productList untuk menghitung total harga
    for (int i = 0; i < productList.length; i++) {
      totalPrice += productList[i].price * productList[i].quantity;
      HomeTransaksi.totalPrice +=
          productList[i].price * productList[i].quantity;
    }
  }

  final FocusNode cari = FocusNode();
  final TextEditingController cariController = TextEditingController();
  String id_produk = "";
  Widget KumpulanProduk() {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: productList.isEmpty
              ? List.empty()
              : List.generate(
                  productList.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 90,
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        child: productList[index].image == null
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
                                            : Image.network(
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
                                            productList[index].name.toString(),
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
                                          padding: EdgeInsets.only(left: 10),
                                          child: Container(
                                            child: Card(
                                              surfaceTintColor:
                                                  CustomColors.whiteColor,
                                              color: CustomColors.whiteColor,
                                              elevation: 0,
                                              shape: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: CustomColors
                                                      .secondaryColor,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (productList[index]
                                                                .quantity >
                                                            1) {
                                                          updateProductQuantity(
                                                            index,
                                                            -1,
                                                          );
                                                        }
                                                      },
                                                      child: Container(
                                                        color: CustomColors
                                                            .whiteColor,
                                                        child: Icon(
                                                          Icons.remove,
                                                          size: 20,
                                                          color: CustomColors
                                                              .secondaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      productList[index]
                                                          .quantity
                                                          .toString(),
                                                      style:
                                                          CustomText.TextArvo(
                                                        14,
                                                        CustomColors.blackColor,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    GestureDetector(
                                                      onTap: () =>
                                                          updateProductQuantity(
                                                        index,
                                                        1,
                                                      ),
                                                      child: Container(
                                                        color: CustomColors
                                                            .whiteColor,
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 20,
                                                          color: CustomColors
                                                              .secondaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        removeProductFromList(index);
                                      },
                                      icon: Image.asset(
                                        Server.urlGambar("icons_sampah.png"),
                                        height: 20,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(right: 10),
                                      child: Text(
                                        "Rp." +
                                            productList[index].price.toString(),
                                        style: CustomText.TextArvoBold(
                                          12,
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
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    clearProductList();
    TransactionManager tm = TransactionManager();
    tm.clearTransactionData();
    showKemeja();
    showKaos();
    showKain();
    calculateTotalPrice();
    setState(() {
      tm.clearTransactionData();
      showKemeja();
      showKaos();
      showKain();
      calculateTotalPrice();
    });
  }

  late MediaQueryData mediaQuery = MediaQuery.of(context);
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
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  detail_transaksi(),
            ));
      } else {
        print('ProductList kosong');
      }
    }

    return ChangeNotifierProvider(
      create: (context) => TransactionManager(),
      child: Scaffold(
        bottomSheet: Container(
          height: 80,
          child: Card(
            elevation: 20,
            surfaceTintColor: CustomColors.whiteColor,
            color: CustomColors.whiteColor,
            shadowColor: CustomColors.blackColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Total Harga",
                            style: CustomText.TextArvoBold(
                                12, CustomColors.blackColor),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            "Rp. ${totalPrice.toInt()}",
                            style: CustomText.TextArvoBold(
                                20, CustomColors.blackColor),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: addAllProductsToTransaction,
                      child: Text(
                        "Transaksi",
                        style: CustomText.TextArvoBold(
                            16, CustomColors.whiteColor),
                      ),
                      style: CustomButton.NewModel(CustomColors.secondaryColor),
                    )
                  ]),
            ),
          ),
        ),
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
                        if (value.isEmpty) {
                          showKain();
                          showKaos();
                          showKemeja();
                        } else {
                          showPencarianKain(value);
                          showPencarianKaos(value);
                          showPencarianKemeja(value);
                        }
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
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Produk",
                  style: CustomText.TextArvoBold(16, CustomColors.blackColor),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            KumpulanProduk(),
            SizedBox(
              height: 120,
            ),
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
