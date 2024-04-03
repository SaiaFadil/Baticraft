import 'dart:io';

import 'package:baticraft/menu/SubMenuHome/page_kelola_produk.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Tambah_Produk extends StatefulWidget {
  const Tambah_Produk({super.key});

  @override
  State<Tambah_Produk> createState() => Tambah_ProdukState();
}

class Tambah_ProdukState extends State<Tambah_Produk> {
//AWAL BACKEND

  String? _selectedOption;

  String _selectedStatus = 'tersedia'; // Nilai default
  String ImageSaatIni = "";
  ImagePicker _imagePicker = ImagePicker();
  File? _profileImage;
  String? fileName; // Perubahan: fileName diubah menjadi nullable
  late http.MultipartRequest
      request; // Perubahan: request dideklarasikan sebagai late

  Future<void> _getImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        fileName = path.basename(pickedFile.path);
        ImageSaatIni = pickedFile.name;
        // Perubahan: Mengambil nama file setelah pemilihan gambar
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_profileImage == null) {
      print("errorrrrrrr");
      return;
    }

    // Menyiapkan request untuk mengunggah gambar ke server
    request = http.MultipartRequest(
        'POST', Uri.parse(Server.urlString("upload_image.php")));

    // Menambahkan file gambar ke dalam request

    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        _profileImage!.path,
        filename: fileName,
      ),
    );

    // Mengirim request ke server
    var response = await request.send();
    if (response.statusCode == 200) {
      print('Gambar berhasil diunggah');
    } else {
      print('Terjadi kesalahan saat mengunggah gambar');
      print(response.statusCode);
      print(response);
      print(response.reasonPhrase);
    }
  }
//AKHIR BACKEND

// Tambahan inputan KAIN
  Column InputanKain() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Ukuran",
              style: CustomText.TextArvoBold(14, CustomColors.blackColor),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: TextField(
            keyboardType: TextInputType.text,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Masukkan Ukuran Produk",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.secondaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.blackColor),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            ),
            style: CustomText.TextArvo(14, CustomColors.blackColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Panjang Kain",
              style: CustomText.TextArvoBold(14, CustomColors.blackColor),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: TextField(
            keyboardType: TextInputType.text,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Masukkan Panjang Kain",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.secondaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.blackColor),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            ),
            style: CustomText.TextArvo(14, CustomColors.blackColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Lebar Kain",
              style: CustomText.TextArvoBold(14, CustomColors.blackColor),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: TextField(
            keyboardType: TextInputType.text,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Masukkan Lebar Kain",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.secondaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.blackColor),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            ),
            style: CustomText.TextArvo(14, CustomColors.blackColor),
          ),
        ),
      ],
    );
  }
// Tambahan inputan KAIN

// Tambahan inputan KAOS
  Column InputanKaos() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Ukuran",
              style: CustomText.TextArvoBold(14, CustomColors.blackColor),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: TextField(
            keyboardType: TextInputType.text,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Masukkan Ukuran Produk",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.secondaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.blackColor),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            ),
            style: CustomText.TextArvo(14, CustomColors.blackColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Jenis Lengan",
              style: CustomText.TextArvoBold(14, CustomColors.blackColor),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: TextField(
            keyboardType: TextInputType.text,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Masukkan Jenis Lengan",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.secondaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.blackColor),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            ),
            style: CustomText.TextArvo(14, CustomColors.blackColor),
          ),
        ),
      ],
    );
  }

// Tambahan inputan KAOS

// Tambahan inputan KEMEJA
  Column InputanKemeja() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Ukuran",
              style: CustomText.TextArvoBold(14, CustomColors.blackColor),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: TextField(
            keyboardType: TextInputType.text,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Masukkan Ukuran Produk",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.secondaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.blackColor),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            ),
            style: CustomText.TextArvo(14, CustomColors.blackColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Jenis Lengan",
              style: CustomText.TextArvoBold(14, CustomColors.blackColor),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: TextField(
            keyboardType: TextInputType.text,
            textAlign: TextAlign.start,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              hintText: "Masukkan Jenis Lengan",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.secondaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(color: CustomColors.blackColor),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
            ),
            style: CustomText.TextArvo(14, CustomColors.blackColor),
          ),
        ),
      ],
    );
  }

// Tambahan inputan KEMEJA

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: AppBar(
        elevation: 5,
        title: Text("Tambah Produk",
            style: CustomText.TextArvoBold(16, CustomColors.threertyColor),
            textAlign: TextAlign.center),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        KelolaProduk(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    }));
          },
          icon: Icon(Icons.arrow_back_ios),
          color: CustomColors.threertyColor,
        ),
        shadowColor: CustomColors.blackColor,
        centerTitle: true,
        surfaceTintColor: CustomColors.whiteColor,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  width: 250,
                  height: 250,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: CustomColors.secondaryColor,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: CustomColors.blackColor,
                    elevation: 15,
                    surfaceTintColor: CustomColors.whiteColor,
                    child: ImageSaatIni != ""
                        ? Card(
                            margin: EdgeInsets.all(20),
                            child: Image(
                              image: FileImage(_profileImage!),
                              fit: BoxFit.contain,
                            ),
                          )
                        : Container(
                            margin: EdgeInsets.all(20),
                            child: Image.asset(
                              Server.urlGambar("default2.png"),
                              fit: BoxFit.contain,
                            )),
                  ),
                ),
              ),
              Container(
                width: 210,
                child: Card(
                  child: ElevatedButton(
                    onPressed: () {
                      _getImage();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      elevation: MaterialStateProperty.all<double>(10),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.fromLTRB(5, 12, 5, 12)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          CustomColors.secondaryColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          Server.urlGambar("camera_ad.png"),
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Upload Gambar",
                          style: CustomText.TextArvoBold(
                              16, CustomColors.whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Nama Produk",
                    style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Masukkan Nama Produk",
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
                      borderSide: BorderSide(color: CustomColors.blackColor),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  ),
                  style: CustomText.TextArvo(14, CustomColors.blackColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Deskripsi Produk",
                    style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Masukkan Deskripsi Produk",
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
                      borderSide: BorderSide(color: CustomColors.blackColor),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  ),
                  style: CustomText.TextArvo(14, CustomColors.blackColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Harga",
                    style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Rp.0",
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
                      borderSide: BorderSide(color: CustomColors.blackColor),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  ),
                  style: CustomText.TextArvo(14, CustomColors.blackColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Status",
                    style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Card(
                  surfaceTintColor: CustomColors.whiteColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: CustomColors.blackColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: CustomColors.whiteColor,
                  elevation: 15,
                  color: CustomColors.whiteColor,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: DropdownButton<String>(
                      elevation: 0,
                      isExpanded: true,
                      dropdownColor: CustomColors.whiteColor,
                      iconSize: 30,
                      focusColor: CustomColors.HintColor,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: CustomColors.blackColor,
                      ),
                      style: CustomText.TextArvo(16, CustomColors.blackColor),
                      value: _selectedStatus,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedStatus = newValue!;
                        });
                      },
                      items: <String>['tersedia', 'tidak tersedia']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Stok",
                    style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: TextField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "+1",
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
                      borderSide: BorderSide(color: CustomColors.blackColor),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  ),
                  style: CustomText.TextArvo(14, CustomColors.blackColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Bahan",
                    style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Masukkan Bahan Produk",
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
                      borderSide: BorderSide(color: CustomColors.blackColor),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  ),
                  style: CustomText.TextArvo(14, CustomColors.blackColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Jenis Batik",
                    style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: TextField(
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.start,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Masukkan Jenis Batik",
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
                      borderSide: BorderSide(color: CustomColors.blackColor),
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10.0),
                  ),
                  style: CustomText.TextArvo(14, CustomColors.blackColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Kategori",
                    style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedOption = 'Kain';
                          });
                        },
                        child: Text(
                          'Kain',
                          style: CustomText.TextArvoBold(
                              16,
                              _selectedOption == 'Kain'
                                  ? CustomColors.whiteColor
                                  : CustomColors.secondaryColor),
                        ),
                        style: ButtonStyle(
                          surfaceTintColor: MaterialStateProperty.all<Color>(_selectedOption == 'Kain'
                                  ? CustomColors.secondaryColor
                                  : CustomColors.whiteColor),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                  color: CustomColors.secondaryColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(10),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.fromLTRB(30, 5, 30, 5)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              _selectedOption == 'Kain'
                                  ? CustomColors.secondaryColor
                                  : CustomColors.whiteColor),
                        )),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _selectedOption = 'Kaos';
                          });
                        },
                        child: Text('Kaos',
                            style: CustomText.TextArvoBold(
                                16,
                                _selectedOption == 'Kaos'
                                    ? CustomColors.whiteColor
                                    : CustomColors.secondaryColor)),
                        style: ButtonStyle(
                         
                          surfaceTintColor: MaterialStateProperty.all<Color>(_selectedOption == 'Kaos'
                                  ? CustomColors.secondaryColor
                                  : CustomColors.whiteColor),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                  color: CustomColors.secondaryColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(10),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.fromLTRB(30, 5, 30, 5)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              _selectedOption == 'Kaos'
                                  ? CustomColors.secondaryColor
                                  : CustomColors.whiteColor),
                        )),
                    ElevatedButton(
                      
                        onPressed: () {
                          setState(() {
                            _selectedOption = 'Kemeja';
                          });
                        },
                        child: Text('Kemeja',
                            style: CustomText.TextArvoBold(
                                16,
                                _selectedOption == 'Kemeja'
                                    ? CustomColors.whiteColor
                                    : CustomColors.secondaryColor)),
                        style: ButtonStyle(  
                          surfaceTintColor: MaterialStateProperty.all<Color>(_selectedOption == 'Kemeja'
                                  ? CustomColors.secondaryColor
                                  : CustomColors.whiteColor),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              side: BorderSide(
                                  color: CustomColors.secondaryColor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(10),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  EdgeInsets.fromLTRB(30, 5, 30, 5)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              _selectedOption == 'Kemeja'
                                  ? CustomColors.secondaryColor
                                  : CustomColors.whiteColor),
                        )),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              _selectedOption == 'Kain' ? InputanKain() : SizedBox(),
              _selectedOption == 'Kaos' ? InputanKaos() : SizedBox(),
              _selectedOption == 'Kemeja' ? InputanKemeja() : SizedBox(),
              Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 50),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: CustomButton.DefaultButton(
                          CustomColors.secondaryColor),
                      child: Text(
                        "Tambah",
                        style: CustomText.TextArvoBold(
                            20, CustomColors.whiteColor),
                      ),
                      onPressed: () {},
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
