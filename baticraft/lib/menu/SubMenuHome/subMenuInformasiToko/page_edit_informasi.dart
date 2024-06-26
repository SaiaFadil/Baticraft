import 'dart:convert';
import 'dart:io';

import 'package:baticraft/menu/SubMenuHome/subMenuInformasiToko/page_informasi_toko.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class EditInformasiToko extends StatefulWidget {
  const EditInformasiToko({super.key});

  @override
  State<EditInformasiToko> createState() => _EditInformasiTokoState();
}

class _EditInformasiTokoState extends State<EditInformasiToko> {
//Awal Backend
  ImagePicker _imagePicker = ImagePicker();
  File? _profileImage;
  String? fileName; // Perubahan: fileName diubah menjadi nullable
  late http.MultipartRequest
      request; // Perubahan: request dideklarasikan sebagai late
      Future<void> postDataToServer() async {
    // Persiapkan data yang akan dikirim
    Map<String, dynamic> data = {
      'nama_pemilik': namaPemilikController.text,
      'alamat': alamatController.text,
      'lokasi': lokasiController.text,
      'deskripsi': deskripsiController.text,
      'no_telpon': nomorTeleponController.text,
      'email': emailController.text,
      'image': ImageSaatIni,
      'akun_ig': akunInstagramController.text,
      'akun_fb': akunFacebookController.text,
      'akun_tiktok': akunTiktokController.text,
    };

    // Buat request POST ke URL server
    Uri url = Server.urlLaravel("EditIformasiMobile");

    try {
      // Kirim request POST ke server
      final response = await http.post(url, body: data);

      // Periksa kode status respons
      if (response.statusCode == 200) {

        if(response.body.contains("error")){
          print("ERROR ${response.body}");
        CustomWidget.NotifGagalEditInformasi(context);
        }else{
        _uploadImage();
        CustomWidget.NotifBerhasilEditInformasi(context, InformasiToko());
        // Sukses mengirim data
        print(response.body);
        print('Data berhasil dikirim');}
      } else {
        // Gagal mengirim data
        print('Gagal mengirim data. Kode status: ${response.statusCode}');
      }
    } catch (error) {
      // Tangani kesalahan jika terjadi
      print('Terjadi kesalahan: $error');
    }
  }



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

  // Menginisialisasi variabel request sebelum menggunakannya
  request = http.MultipartRequest(
      'POST', Server.urlLaravel("UploadGambarInformasi"));

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

  String jsonDetailInformasi = "{}";
  Map<String, dynamic> detailInformasi = {};

    Future getDetailInformasi() async {
    try {
      final response =
          await http.get(Server.urlLaravel("DetailInformasiMobile"));

      if (response.statusCode == 200) {
        List<dynamic> detailInformasiList = json.decode(response.body);
        if (detailInformasiList.isNotEmpty) {
          Map<String, dynamic> detailInformasi = detailInformasiList[0];
          setState(() {

        // Set nilai-nilai dari detailInformasi ke dalam controller
        namaPemilikController.text = detailInformasi['nama_pemilik'];
        alamatController.text = detailInformasi['alamat'];
        deskripsiController.text = detailInformasi['deskripsi'];
        nomorTeleponController.text = detailInformasi['no_telpon'];
        emailController.text = detailInformasi['email'];
        lokasiController.text = detailInformasi['lokasi'];
        if (detailInformasi['akun_fb'].toString() == "null") {
            akunFacebookController.text = "";
          } else {
            akunFacebookController.text = detailInformasi['akun_fb'];
          }
          if (detailInformasi['akun_ig'].toString()== "null") {
            akunInstagramController.text = "";
          } else {
            akunInstagramController.text = detailInformasi['akun_ig'];
          }
          if (detailInformasi['akun_tiktok'].toString()== "null") {
            akunTiktokController.text = "";
          } else {
            akunTiktokController.text = detailInformasi['akun_tiktok'];
          }
       });
        } else {
          print("No data available");
        }
      } else {
        print("HTTP Request failed with status: ${response.statusCode}");
      }
    } catch ($e) {
      print("error "+$e.toString());
      
    }
  }

  @override
  void initState() {
    super.initState();
    getDetailInformasi();
  }

  String ImageSaatIni = "";
//Akhir Backend

  final TextEditingController namaPemilikController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController nomorTeleponController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController akunInstagramController = TextEditingController();
  final TextEditingController akunFacebookController = TextEditingController();
  final TextEditingController akunTiktokController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          elevation: 5,
          title: Text("Edit Informasi Toko",
              style: CustomText.TextArvoBold(16, CustomColors.threertyColor),
              textAlign: TextAlign.center),
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          InformasiToko(),
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
        backgroundColor: CustomColors.HintColor,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: ImageSaatIni != ""
                    ? Image(
                        image: FileImage(_profileImage!),
                        fit: BoxFit.contain,
                      )
                    : Image.asset(Server.urlGambar("gambarawal.png"))),
            Positioned(
              top: 0,
              bottom: -5,
              left: -5,
              right: -5,
              child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 215),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    color: CustomColors.whiteColor,
                    child: Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(27, 0, 27, 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Text(
                                  "Foto Toko",
                                  style: CustomText.TextArvoBold(
                                      16, CustomColors.blackColor),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width: 140,
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Adjust as needed
                                    ),
                                    elevation:
                                        5.0, // Adjust as needed for shadow

                                    color: CustomColors.whiteColor,
                                    surfaceTintColor: CustomColors.whiteColor,
                                    shadowColor: CustomColors.blackColor,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: CustomColors.whiteColor,
                                        borderRadius: BorderRadius.circular(
                                            10.0), // Match shape with borderRadius
                                        border: Border.all(
                                          color: CustomColors
                                              .secondaryColor, // Set your stroke color
                                          width:
                                              2.0, // Adjust stroke width as needed
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: _getImage,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(children: [
                                            Icon(
                                              Icons.camera_alt_outlined,
                                              color: CustomColors.HintColor,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Pilih File",
                                              style: CustomText.TextArvoBold(
                                                  14, CustomColors.HintColor),
                                            )
                                          ]),
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            // Data Awal
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Nama Pemilik",
                                        style: CustomText.TextArvoBold(
                                            14, CustomColors.blackColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      controller: namaPemilikController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color:
                                                  CustomColors.secondaryColor),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: CustomColors.blackColor),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                      ),
                                      style: CustomText.TextArvo(
                                          14, CustomColors.blackColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Alamat",
                                        style: CustomText.TextArvoBold(
                                            14, CustomColors.blackColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: TextField(
                                      maxLines: 4,
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      controller: alamatController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color:
                                                  CustomColors.secondaryColor),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: CustomColors.blackColor),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                      ),
                                      style: CustomText.TextArvo(
                                          14, CustomColors.blackColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Deskripsi",
                                        style: CustomText.TextArvoBold(
                                            14, CustomColors.blackColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: TextField(
                                      maxLines: 7,
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      controller: deskripsiController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color:
                                                  CustomColors.secondaryColor),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: CustomColors.blackColor),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                      ),
                                      style: CustomText.TextArvo(
                                          14, CustomColors.blackColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Nomor Telepon",
                                        style: CustomText.TextArvoBold(
                                            14, CustomColors.blackColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: TextField(
                                      minLines: 1,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      controller: nomorTeleponController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color:
                                                  CustomColors.secondaryColor),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: CustomColors.blackColor),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                      ),
                                      style: CustomText.TextArvo(
                                          14, CustomColors.blackColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Email",
                                        style: CustomText.TextArvoBold(
                                            14, CustomColors.blackColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color:
                                                  CustomColors.secondaryColor),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: CustomColors.blackColor),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                      ),
                                      style: CustomText.TextArvo(
                                          14, CustomColors.blackColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Akun Instagram",
                                        style: CustomText.TextArvoBold(
                                            14, CustomColors.blackColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      controller: akunInstagramController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color:
                                                  CustomColors.secondaryColor),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: CustomColors.blackColor),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                      ),
                                      style: CustomText.TextArvo(
                                          14, CustomColors.blackColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Akun Facebook",
                                        style: CustomText.TextArvoBold(
                                            14, CustomColors.blackColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      controller: akunFacebookController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color:
                                                  CustomColors.secondaryColor),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: CustomColors.blackColor),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                      ),
                                      style: CustomText.TextArvo(
                                          14, CustomColors.blackColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Akun Tiktok",
                                        style: CustomText.TextArvoBold(
                                            14, CustomColors.blackColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      controller: akunTiktokController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color:
                                                  CustomColors.secondaryColor),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: CustomColors.blackColor),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                      ),
                                      style: CustomText.TextArvo(
                                          14, CustomColors.blackColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Lokasi",
                                        style: CustomText.TextArvoBold(
                                            14, CustomColors.blackColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      controller: lokasiController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color:
                                                  CustomColors.secondaryColor),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: CustomColors.blackColor),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                      ),
                                      style: CustomText.TextArvo(
                                          14, CustomColors.blackColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(top: 50),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    style: CustomButton.DefaultButton(
                                        CustomColors.secondaryColor),
                                    child: Text(
                                      "Edit",
                                      style: CustomText.TextArvoBold(
                                          20, CustomColors.whiteColor),
                                    ),
                                    onPressed: () {
                                      postDataToServer();
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
