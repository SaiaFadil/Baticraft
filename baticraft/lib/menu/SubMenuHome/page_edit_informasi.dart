import 'dart:convert';
import 'dart:io';

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

class EditInformasiToko extends StatefulWidget {
  const EditInformasiToko({super.key});

  @override
  State<EditInformasiToko> createState() => _EditInformasiTokoState();
}

class _EditInformasiTokoState extends State<EditInformasiToko> {
  ImagePicker _imagePicker = ImagePicker();
  File? _profileImage;

  Future<void> _getImage() async {
    final PickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      setState(() {
        _profileImage = File(PickedFile.path);
         ImageSaatIni = PickedFile.name; 
      });
    }
  }

//Awal Backend
  String jsonDetailInformasi = "{}";
  Map<String, dynamic> detailInformasi = {};

  Future getDetailUser() async {
    final response = await http.get(Server.url("ShowDetailInformasi.php"));

    if (response.statusCode == 200) {
      jsonDetailInformasi = response.body.toString();
      detailInformasi = json.decode(jsonDetailInformasi);
      if (detailInformasi.isNotEmpty) {
        setState(() {
          print("nama_pemilik = " + detailInformasi['nama_pemilik']);
          print("nama_toko = " + detailInformasi['nama_toko']);
          print("alamatnya = " + detailInformasi['alamat']);
          print("deskripsi = " + detailInformasi['deskripsi']);
          print("no_telpon = " + detailInformasi['no_telpon']);
          print("email = " + detailInformasi['email']);
          print("akun_ig = " + detailInformasi['akun_ig']);
          print("akun_fb = " + detailInformasi['akun_fb']);
          print("akun_tiktok = " + detailInformasi['akun_tiktok']);
          print("image = " + detailInformasi['image']);
        });
      } else {
        print("No data available");
      }
    } else {
      print("HTTP Request failed with status: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    getDetailUser();
  }

  String ImageSaatIni = "";
//Akhir Backend

  void openLink() async {
    if (await canLaunch('https://www.google.com')) {
      await launch('https://www.google.com');
    } else {
      print("Could not launch https://www.google.com");
      throw 'Could not launch https://www.google.com';
    }
  }

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
              Navigator.pop(context);
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
                    ? Image(image: FileImage(_profileImage!),fit: BoxFit.contain,)
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
                                      controller: TextEditingController(
                                          text:
                                              detailInformasi['nama_pemilik']),
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
                                      controller: TextEditingController(
                                          text: detailInformasi['alamat']),
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
                                      controller: TextEditingController(
                                          text: detailInformasi['deskripsi']),
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
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      controller: TextEditingController(
                                          text: detailInformasi['no_telpon']),
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
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      controller: TextEditingController(
                                          text:
                                              detailInformasi['email']),
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
                                      controller: TextEditingController(
                                          text:
                                              detailInformasi['akun_ig']),
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
                                      controller: TextEditingController(
                                          text:
                                              detailInformasi['akun_fb']),
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
                                      controller: TextEditingController(
                                          text:
                                              detailInformasi['akun_tiktok']),
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
                                      controller: TextEditingController(
                                          text:"Masukkan Lokasi Toko"
                                              // detailInformasi['akun_tiktok']
                                              ),
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
                                    onPressed: () {},
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
