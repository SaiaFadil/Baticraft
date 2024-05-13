import 'dart:convert';
import 'dart:io';

import 'package:baticraft/menu/SubMenuHome/subMenuKelolaPengguna/page_kelola_pengguna.dart';
import 'package:baticraft/navigation/utama.dart';
import 'package:baticraft/page/page_login.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import 'package:path/path.dart' as path;

class tambah_admin extends StatefulWidget {
  const tambah_admin({super.key});

  @override
  State<tambah_admin> createState() => tambah_adminState();
}

class tambah_adminState extends State<tambah_admin> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nomorTeleponController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController TempatLahirController = TextEditingController();
  final TextEditingController TanggalLahirController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  ImagePicker _imagePicker = ImagePicker();
  File? _profileImage;
  String? fileName;
  DateTime? startDate;
 Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
  );
  if (picked != null && picked != startDate) {
    setState(() {
      startDate = picked;
      TanggalLahirController.text = formatTanggal(picked);
    });
  }
}

String formatTanggal(DateTime picked) {
  // Memperoleh tanggal, bulan, dan tahun dari DateTime
  String day = picked.day.toString().padLeft(2, '0');
  String month = picked.month.toString().padLeft(2, '0');
  String year = picked.year.toString();
  
  // Menggabungkan dalam format yang diinginkan
  return '$year-$month-$day';
}


  String ImageSaatIni = "";
  Future<void> _getImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
        fileName = path.basename(pickedFile.path);
        ImageSaatIni = pickedFile.name;
      });
    }
  }

  late http.MultipartRequest request;
  Future<void> _uploadImage() async {
    if (_profileImage == null) {
      print("errorrrrrrr");
      return;
    }

    // Menyiapkan request untuk mengunggah gambar ke server
    request =
        http.MultipartRequest('POST', Server.urlLaravel("UploadGambarUser"));

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

  Future<void> postDataToServer() async {
    // Persiapkan data yang akan dikirim
    Map<String, dynamic> data = {
      'nama': namaController.text,
      'email': emailController.text,
      'alamat': alamatController.text,
      'no_telpon': nomorTeleponController.text,
      'tempat_lahir': TempatLahirController.text,
      'jenis_kelamin': jenisKelamin,
      'tanggal_lahir': TanggalLahirController.text,
      'password': passwordController.text,
      'image': ImageSaatIni,
    };

    // Buat request POST ke URL server
    Uri url = Server.urlLaravel("tambahAdmin");

    try {
      // Kirim request POST ke server
      final response = await http.post(url, body: data);

      // Periksa kode status respons
      if (response.statusCode == 200) {
        _uploadImage();

        CustomWidget.NotifBerhasilTambahAdmin(context);
        // Sukses mengirim data
        print(response.body);
        print('Data berhasil dikirim');
      } else {
        // Gagal mengirim data
        print('Gagal mengirim data. Kode status: ${response.statusCode}');
        print('Gagal mengirim data. Kode statusss: ${response.body}');
      }
    } catch (error) {
      // Tangani kesalahan jika terjadi
      print('Terjadi kesalahan: $error');
    }
  }

  String jenisKelamin = "laki-laki";
  @override
  void initState() {
    super.initState();
    print("id = " + page_login.id_user);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text("Tambah Admin",
            style: CustomText.TextArvoBold(16, CustomColors.threertyColor),
            textAlign: TextAlign.center),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      KelolaPengguna(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ));
          },
          icon: Icon(Icons.arrow_back_ios),
          color: CustomColors.threertyColor,
        ),
        shadowColor: CustomColors.blackColor,
        centerTitle: true,
        surfaceTintColor: CustomColors.whiteColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: CustomColors.secondaryColor,
                child: Column(
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 5),
                        child: ImageSaatIni.isEmpty
                            ? CircleAvatar(
                                backgroundColor: CustomColors.whiteColor,
                                foregroundColor: CustomColors.HintColor,
                                radius: 55,
                                child: CircleAvatar(
                                  backgroundColor: CustomColors.hintprimary,
                                  foregroundColor: CustomColors.HintColor,
                                  radius: 75,
                                  child: ClipOval(
                                    child: Image.asset(
                                      Server.urlGambar("default2.png"),
                                      scale: 1,
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    ),
                                    // Atur ke cover agar gambar terisi penuh di dalam lingkaran
                                  ),
                                ),
                              )
                            : CircleAvatar(
                                backgroundColor: CustomColors.whiteColor,
                                radius: 60,
                                child: CircleAvatar(
                                  foregroundColor: CustomColors.whiteColor,
                                  radius: 55,
                                  child: ClipOval(
                                    child: Image(
                                      image: FileImage(_profileImage!),
                                      fit: BoxFit
                                          .fitHeight, // Atur ke cover agar gambar terisi penuh di dalam lingkaran
                                    ),
                                  ),
                                ),
                              )),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Foto",
                        style: CustomText.TextArvoBold(
                            16, CustomColors.whiteColor),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 30),
                child: Column(children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.camera_alt,
                                  size: 25, color: CustomColors.secondaryColor),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Photo Profil",
                                style: CustomText.TextArvo(
                                    14, CustomColors.blackColor),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  width: 140,
                                  child: Card(
                                    margin: EdgeInsets.only(left: 10),
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
                                              SizedBox(
                                                width: 20,
                                              ),
                                              Text(
                                                "Pilih File",
                                                style: CustomText.TextArvoBold(
                                                    14,
                                                    CustomColors
                                                        .secondaryColor),
                                              )
                                            ]),
                                          ),
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.person_pin,
                                  size: 25, color: CustomColors.secondaryColor),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Nama",
                                style: CustomText.TextArvo(
                                    14, CustomColors.blackColor),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          width: double.infinity,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0), // Adjust as needed
                                            ),
                                            elevation:
                                                5.0, // Adjust as needed for shadow

                                            color: CustomColors.whiteColor,
                                            surfaceTintColor:
                                                CustomColors.whiteColor,
                                            shadowColor:
                                                CustomColors.blackColor,
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
                                              child: TextField(
                                                maxLines: 1,
                                                keyboardType:
                                                    TextInputType.text,
                                                textAlign: TextAlign.start,
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: namaController,
                                                style: CustomText.TextArvoBold(
                                                  12,
                                                  CustomColors.blackColor,
                                                ),
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 10)),
                                              ),
                                            ),
                                          )))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.email_rounded,
                                  size: 25, color: CustomColors.secondaryColor),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Email",
                                style: CustomText.TextArvo(
                                    14, CustomColors.blackColor),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                          width: double.infinity,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0), // Adjust as needed
                                            ),
                                            elevation:
                                                5.0, // Adjust as needed for shadow

                                            color: CustomColors.whiteColor,
                                            surfaceTintColor:
                                                CustomColors.whiteColor,
                                            shadowColor:
                                                CustomColors.blackColor,
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
                                              child: TextField(
                                                maxLines: 1,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                textAlign: TextAlign.start,
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: emailController,
                                                style: CustomText.TextArvoBold(
                                                  12,
                                                  CustomColors.blackColor,
                                                ),
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 10)),
                                              ),
                                            ),
                                          )))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.call,
                                  size: 25, color: CustomColors.secondaryColor),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Nomor Telepon",
                                style: CustomText.TextArvo(
                                    14, CustomColors.blackColor),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: double.infinity,
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0), // Adjust as needed
                                            ),
                                            elevation:
                                                5.0, // Adjust as needed for shadow

                                            color: CustomColors.whiteColor,
                                            surfaceTintColor:
                                                CustomColors.whiteColor,
                                            shadowColor:
                                                CustomColors.blackColor,
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
                                              child: TextField(
                                                maxLines: 1,
                                                keyboardType:
                                                    TextInputType.number,
                                                textAlign: TextAlign.start,
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller:
                                                    nomorTeleponController,
                                                style: CustomText.TextArvoBold(
                                                  12,
                                                  CustomColors.blackColor,
                                                ),
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 10)),
                                              ),
                                            )),
                                      )))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.location_pin,
                                  size: 25, color: CustomColors.secondaryColor),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Alamat",
                                style: CustomText.TextArvo(
                                    14, CustomColors.blackColor),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: double.infinity,
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0), // Adjust as needed
                                            ),
                                            elevation:
                                                5.0, // Adjust as needed for shadow

                                            color: CustomColors.whiteColor,
                                            surfaceTintColor:
                                                CustomColors.whiteColor,
                                            shadowColor:
                                                CustomColors.blackColor,
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
                                              child: TextField(
                                                maxLines: 5,
                                                keyboardType:
                                                    TextInputType.text,
                                                textAlign: TextAlign.start,
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: alamatController,
                                                style: CustomText.TextArvoBold(
                                                  12,
                                                  CustomColors.blackColor,
                                                ),
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 10)),
                                              ),
                                            )),
                                      )))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.lock_open_rounded,
                                  size: 25, color: CustomColors.secondaryColor),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Password",
                                style: CustomText.TextArvo(
                                    14, CustomColors.blackColor),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: double.infinity,
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10.0), // Adjust as needed
                                            ),
                                            elevation:
                                                5.0, // Adjust as needed for shadow

                                            color: CustomColors.whiteColor,
                                            surfaceTintColor:
                                                CustomColors.whiteColor,
                                            shadowColor:
                                                CustomColors.blackColor,
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
                                              child: TextField(
                                                maxLines: 1,
                                                keyboardType:
                                                    TextInputType.text,
                                                textAlign: TextAlign.start,
                                                textInputAction:
                                                    TextInputAction.next,
                                                controller: passwordController,
                                                style: CustomText.TextArvoBold(
                                                  12,
                                                  CustomColors.blackColor,
                                                ),
                                                decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                            left: 10)),
                                              ),
                                            )),
                                      )))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.circle_outlined,
                                  size: 25, color: CustomColors.secondaryColor),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Jenis Kelamin",
                                style: CustomText.TextArvo(
                                    14, CustomColors.blackColor),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 40),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Container(
                                      width: double.infinity,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Adjust as needed
                                        ),
                                        elevation:
                                            5.0, // Adjust as needed for shadow

                                        color: CustomColors.whiteColor,
                                        surfaceTintColor:
                                            CustomColors.whiteColor,
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
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: DropdownButton<String>(
                                                elevation: 0,
                                                isExpanded: true,
                                                dropdownColor:
                                                    CustomColors.whiteColor,
                                                iconSize: 30,
                                                focusColor:
                                                    CustomColors.HintColor,
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                  color:
                                                      CustomColors.blackColor,
                                                ),
                                                style: CustomText.TextArvo(16,
                                                    CustomColors.blackColor),
                                                value: jenisKelamin,
                                                onChanged: (String? newValue) {
                                                  setState(() {
                                                    jenisKelamin = newValue!;
                                                  });
                                                },
                                                items: <String>[
                                                  'perempuan',
                                                  'laki-laki'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                              ),
                                            )),
                                      )))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Row(
                            children: [
                              Icon(Icons.date_range,
                                  size: 25, color: CustomColors.secondaryColor),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Tempat/Tanggal Lahir",
                                style: CustomText.TextArvo(
                                    14, CustomColors.blackColor),
                              )
                            ],
                          ),
                        ),
                        // Tambahkan input tempat lahir
                        Padding(
                            padding: const EdgeInsets.only(top: 0, left: 40),
                            child: Container(
                                width: double.infinity,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Adjust as needed
                                  ),
                                  elevation: 5.0, // Adjust as needed for shadow

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
                                      child: TextField(
                                        maxLines: 1,
                                        keyboardType: TextInputType.text,
                                        textAlign: TextAlign.start,
                                        textInputAction: TextInputAction.next,
                                        controller: TempatLahirController,
                                        style: CustomText.TextArvoBold(
                                          12,
                                          CustomColors.blackColor,
                                        ),
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10)),
                                      )),
                                ))),
                        // Tambahkan input tanggal lahir di sini
                        Padding(
                            padding: const EdgeInsets.only(top: 0, left: 40),
                            child: Container(
                                width: double.infinity,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10.0), // Adjust as needed
                                  ),
                                  elevation: 5.0, // Adjust as needed for shadow

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
                                      child: TextFormField(
                                        maxLines: 1,
                                        keyboardType: TextInputType.datetime,
                                        textAlign: TextAlign.start,
                                        textInputAction: TextInputAction.next,
                                        controller: TanggalLahirController,
                                        style: CustomText.TextArvoBold(
                                          12,
                                          CustomColors.blackColor,
                                        ),
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10)),
                                        // Jika Anda ingin menggunakan date picker untuk memilih tanggal, Anda dapat menggunakan properti onTap
                                        onTap: () {
                                          // Panggil fungsi untuk menampilkan date picker di sini
                                          _selectDate(context);
                                        },
                                      )),
                                )))
                      ],
                    ),
                  )
                ]),
              ),
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
                      onPressed: () {
                        if (namaController.text.isEmpty ||
                            emailController.text.isEmpty ||
                            nomorTeleponController.text.isEmpty ||
                            alamatController.text.isEmpty ||
                            jenisKelamin.isEmpty ||
                            TempatLahirController.text.isEmpty ||
                            TanggalLahirController.text.isEmpty ||
                            ImageSaatIni.isEmpty) {
                          print("output : " + namaController.text);
                          print("output : " + emailController.text);
                          print("output : " + nomorTeleponController.text);
                          print("output : " + alamatController.text);
                          print("output : " + jenisKelamin);
                          print("output : " + TempatLahirController.text);
                          print("output : " + TanggalLahirController.text);
                          print("output : " + passwordController.text);
                          print("output : " + ImageSaatIni);
                          CustomWidget.KolomKosong(context);
                        } else {
                          postDataToServer();
                        }
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
