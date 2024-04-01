import 'dart:convert';

import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class EditInformasiToko extends StatefulWidget {
  const EditInformasiToko({super.key});

  @override
  State<EditInformasiToko> createState() => _EditInformasiTokoState();
}

class _EditInformasiTokoState extends State<EditInformasiToko> {
  // ImagePicke _imagePicker = ImagePicker();
  // File? _profileImage;

  // Future<void> _getImage() async {
  //   final PickedFile =
  //       await _imagePicker.pickImage(source: ImageSource.gallery);
  //   if (PickedFile != null) {
  //     setState(() {
  //       _profileImage = File(PickedFile.path);
  //     });
  //   }
  // }

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
                top: 50,
                left: 0,
                right: 0,
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(Server.urlGambar("pickimage.png")),
                  alignment: Alignment.center,
                )),
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
                            Card(child: Row(children: [])),
                            Container(
                              height: 50,
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: TextField(
                                onTap: () {},
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.start,
                                textInputAction: TextInputAction.next,
                                decoration: InputDecoration(
                                  hintText: "Masukkan Email Anda",
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: CustomColors
                                          .primaryColor, // Warna border saat aktif
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                      color: CustomColors
                                          .blackColor, // Warna border saat tidak aktif
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10.0),
                                  hintStyle: CustomText.TextArvo(
                                      14, CustomColors.HintColor),
                                ),
                                style: CustomText.TextArvo(
                                  16,
                                  CustomColors.blackColor,
                                ),
                              ),
                            ),

                            // Data Awal
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.person_2_sharp,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Nama Pemilik",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: detailInformasi[
                                                      'nama_pemilik'] !=
                                                  null
                                              ? Text(
                                                  detailInformasi[
                                                      'nama_pemilik'],
                                                  style: CustomText.TextArvo(
                                                    14,
                                                    CustomColors.blackColor,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                )
                                              : Shimmer.fromColors(
                                                  baseColor: Color.fromARGB(
                                                      255, 104, 102, 102)!,
                                                  highlightColor:
                                                      const Color.fromARGB(
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.home_work,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Alamat",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: detailInformasi[
                                                      'nama_pemilik'] !=
                                                  null
                                              ? Text(
                                                  detailInformasi['alamat'],
                                                  style: CustomText.TextArvo(
                                                    14,
                                                    CustomColors.blackColor,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                )
                                              : Shimmer.fromColors(
                                                  baseColor: Color.fromARGB(
                                                      255, 104, 102, 102)!,
                                                  highlightColor:
                                                      const Color.fromARGB(
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            Server.urlGambar(
                                                "ic_deskripsi.png"),
                                            fit: BoxFit.contain,
                                            height: 25,
                                            width: 25),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Deskripsi",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: detailInformasi[
                                                      'nama_pemilik'] !=
                                                  null
                                              ? Text(
                                                  detailInformasi['deskripsi'],
                                                  style: CustomText.TextArvo(
                                                    14,
                                                    CustomColors.blackColor,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                )
                                              : Shimmer.fromColors(
                                                  baseColor: Color.fromARGB(
                                                      255, 104, 102, 102)!,
                                                  highlightColor:
                                                      const Color.fromARGB(
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.call,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Nomor Telepon",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: detailInformasi[
                                                      'nama_pemilik'] !=
                                                  null
                                              ? Text(
                                                  detailInformasi['no_telpon'],
                                                  style: CustomText.TextArvo(
                                                    14,
                                                    CustomColors.blackColor,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                )
                                              : Shimmer.fromColors(
                                                  baseColor: Color.fromARGB(
                                                      255, 104, 102, 102)!,
                                                  highlightColor:
                                                      const Color.fromARGB(
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.mail,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Email",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: detailInformasi[
                                                      'nama_pemilik'] !=
                                                  null
                                              ? Text(
                                                  detailInformasi['email'],
                                                  style: CustomText.TextArvo(
                                                    14,
                                                    CustomColors.blackColor,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                )
                                              : Shimmer.fromColors(
                                                  baseColor: Color.fromARGB(
                                                      255, 104, 102, 102)!,
                                                  highlightColor:
                                                      const Color.fromARGB(
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                            Server.urlGambar("ic_ig.png"),
                                            fit: BoxFit.contain,
                                            height: 25,
                                            width: 25),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Akun Instagram",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: detailInformasi[
                                                      'nama_pemilik'] !=
                                                  null
                                              ? Text(
                                                  detailInformasi['akun_ig'],
                                                  style: CustomText.TextArvo(
                                                    14,
                                                    CustomColors.blackColor,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                )
                                              : Shimmer.fromColors(
                                                  baseColor: Color.fromARGB(
                                                      255, 104, 102, 102)!,
                                                  highlightColor:
                                                      const Color.fromARGB(
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.facebook,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Akun Facebook",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: detailInformasi[
                                                      'nama_pemilik'] !=
                                                  null
                                              ? Text(
                                                  detailInformasi['akun_fb'],
                                                  style: CustomText.TextArvo(
                                                    14,
                                                    CustomColors.blackColor,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                )
                                              : Shimmer.fromColors(
                                                  baseColor: Color.fromARGB(
                                                      255, 104, 102, 102)!,
                                                  highlightColor:
                                                      const Color.fromARGB(
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.tiktok,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Akun Tiktok",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: detailInformasi[
                                                      'nama_pemilik'] !=
                                                  null
                                              ? Text(
                                                  detailInformasi[
                                                      'akun_tiktok'],
                                                  style: CustomText.TextArvo(
                                                    14,
                                                    CustomColors.blackColor,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                )
                                              : Shimmer.fromColors(
                                                  baseColor: Color.fromARGB(
                                                      255, 104, 102, 102)!,
                                                  highlightColor:
                                                      const Color.fromARGB(
                                                          255, 202, 200, 200)!,
                                                  child: Text(
                                                    'Loading...',
                                                    style: CustomText.TextArvo(
                                                      14,
                                                      CustomColors.blackColor,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                        ),
                                        Container(
                                          height: 1,
                                          color: CustomColors.blackColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      children: [
                                        Icon(Icons.location_on,
                                            size: 30,
                                            color: CustomColors.blackColor),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Lokasi",
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.blackColor),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 40),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              const EdgeInsets.only(bottom: 5),
                                          child: GestureDetector(
                                            onTap: () {
                                              // Jalankan link
                                              openLink();
                                            },
                                            child: Card(
                                              elevation: 5,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Container(
                                                width: double.infinity,
                                                height: 150,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    image: AssetImage(
                                                        'assets/images/map.png'),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
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
