import 'dart:convert';
import 'dart:io';

import 'package:baticraft/navigation/utama.dart';
import 'package:baticraft/pageSebelumLogin/page_login.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import 'package:path/path.dart' as path;

class edit_profil extends StatefulWidget {
  const edit_profil({super.key});

  @override
  State<edit_profil> createState() => edit_profilState();
}

class edit_profilState extends State<edit_profil> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController nomorTeleponController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController lokasiController = TextEditingController();
  final TextEditingController TempatLahirController = TextEditingController();
  final TextEditingController TanggalLahirController = TextEditingController();
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
        TanggalLahirController.text =
            "${picked.year}-${picked.month}-${picked.day}";
      });
    }
  }

  String ImageSaatIni = "";
  String jsonDetailUser = "{}";
  Map<String, dynamic> detailUser = {};
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

  Future getDetailUser() async {
    final response = await http.post(Server.urlLaravel("DetailProfil"),
        body: {"id_user": page_login.id_user});

    if (response.statusCode == 200) {
      jsonDetailUser = response.body.toString();
      detailUser = json.decode(jsonDetailUser);
      if (detailUser.isNotEmpty) {
        setState(() {
          jsonDetailUser = response.body.toString();
          detailUser = json.decode(jsonDetailUser);
          namaController.text = detailUser['nama'];
          nomorTeleponController.text = detailUser['no_telpon'];
          alamatController.text = detailUser['alamat'];
          TempatLahirController.text = detailUser['tempat_lahir'];
          TanggalLahirController.text = detailUser['tanggal_lahir'];
        });
      } else {
        print("No data available");
      }
    } else {
      print("HTTP Request failed with status: ${response.statusCode}");
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
      'alamat': alamatController.text,
      'no_telpon': nomorTeleponController.text,
      'tempat_lahir': TempatLahirController.text,
      'jenis_kelamin': jenisKelamin,
      'tanggal_lahir': TanggalLahirController.text,
      'image': ImageSaatIni,
      'id': page_login.id_user.toString(),
    };

    // Buat request POST ke URL server
    Uri url = Server.urlLaravel("EditProfil");

    try {
      // Kirim request POST ke server
      final response = await http.post(url, body: data);

      // Periksa kode status respons
      if (response.statusCode == 200) {
        _uploadImage();

        CustomWidget.NotifBerhasilEditProfil(context);
        // Sukses mengirim data
        print(response.body);
        print('Data berhasil dikirim');
      } else {
        // Gagal mengirim data
        print('Gagal mengirim data. Kode status: ${response.statusCode}');
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
    getDetailUser();
    print("id = " + page_login.id_user);
    setState(() {
      getDetailUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text("Edit Profil",
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 15),
                  child: detailUser.isNotEmpty
                      ? CircleAvatar(
                          foregroundColor: CustomColors.blackColor,

                          backgroundColor:
                              CustomColors.secondaryColor, // Inner circle color
                          radius: 70.0,
                          child: CircleAvatar(
                            backgroundColor: CustomColors.whiteColor,
                            radius: 65,
                            child: ImageSaatIni != ""
                                ? CircleAvatar(
                                    foregroundColor:
                                        CustomColors.secondaryColor,
                                    radius: 55,
                                    child: ClipOval(
                                      child: Image(
                                        image: FileImage(_profileImage!),
                                        fit: BoxFit
                                            .fitHeight, // Atur ke cover agar gambar terisi penuh di dalam lingkaran
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    foregroundColor:
                                        CustomColors.secondaryColor,
                                    radius: 55, // Ubah ukuran avatar
                                    backgroundImage: NetworkImage(
                                        Server.urlLaravelImageUser(detailUser[
                                            'image'])) // Ganti URL gambar sesuai kebutuhan
                                    ),
                          ),
                        )
                      : Shimmer.fromColors(
                          baseColor: Color.fromARGB(255, 42, 5, 146)!,
                          highlightColor: Color.fromARGB(255, 255, 254, 254)!,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(Server.urlGambar(
                                "default2.png")), // Gunakan AssetImage untuk gambar lokal
                            radius: 30,
                          ),
                        )),
              Container(
                padding: EdgeInsets.fromLTRB(15, 15, 15, 30),
                child: Column(children: [
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
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
                          padding: const EdgeInsets.only(top: 20),
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
                                child: detailUser['nama'] != null
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextField(
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9`.,a-z A-Z]')),
                                          ],
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          textAlign: TextAlign.start,
                                          textInputAction: TextInputAction.next,
                                          controller: namaController,
                                          style: CustomText.TextArvoBold(
                                            12,
                                            CustomColors.blackColor,
                                          ),
                                        ),
                                      )
                                    : Shimmer.fromColors(
                                        baseColor:
                                            Color.fromARGB(255, 104, 102, 102)!,
                                        highlightColor: const Color.fromARGB(
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
                          padding: const EdgeInsets.only(top: 20),
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
                                child: detailUser['nama'] != null
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextField(
                                          maxLength: 15,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                                RegExp(r'[0-9+]')),
                                          ],
                                          maxLines: 1,
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.start,
                                          textInputAction: TextInputAction.next,
                                          controller: nomorTeleponController,
                                          style: CustomText.TextArvoBold(
                                            12,
                                            CustomColors.blackColor,
                                          ),
                                        ),
                                      )
                                    : Shimmer.fromColors(
                                        baseColor:
                                            Color.fromARGB(255, 104, 102, 102)!,
                                        highlightColor: const Color.fromARGB(
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
                          padding: const EdgeInsets.only(top: 20),
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
                                child: detailUser['alamat'] != null
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: TextField(
                                          
                                          inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9`.,-()/a-z A-Z]')),
                                                ],
                                                maxLength: 255,
                                          maxLines: 1,
                                          keyboardType: TextInputType.text,
                                          textAlign: TextAlign.start,
                                          textInputAction: TextInputAction.next,
                                          controller: alamatController,
                                          style: CustomText.TextArvoBold(
                                            12,
                                            CustomColors.blackColor,
                                          ),
                                        ),
                                      )
                                    : Shimmer.fromColors(
                                        baseColor:
                                            Color.fromARGB(255, 104, 102, 102)!,
                                        highlightColor: const Color.fromARGB(
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
                          padding: const EdgeInsets.only(top: 20),
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
                                child: detailUser['jenis_kelamin'] != null
                                    ? DropdownButton<String>(
                                        elevation: 0,
                                        isExpanded: true,
                                        dropdownColor: CustomColors.whiteColor,
                                        iconSize: 30,
                                        focusColor: CustomColors.HintColor,
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: CustomColors.blackColor,
                                        ),
                                        style: CustomText.TextArvo(
                                            16, CustomColors.blackColor),
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
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )
                                    : Shimmer.fromColors(
                                        baseColor:
                                            Color.fromARGB(255, 104, 102, 102)!,
                                        highlightColor: const Color.fromARGB(
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
                          padding: const EdgeInsets.only(top: 20),
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
                          padding: const EdgeInsets.only(top: 10, left: 40),
                          child: detailUser['nama'] != null
                              ? TextField(
                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(r'[0-9.,`a-z A-Z]')),
                                                ],
                                  maxLines: 1,
                                  maxLength: 100,
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.start,
                                  textInputAction: TextInputAction.next,
                                  controller: TempatLahirController,
                                  style: CustomText.TextArvoBold(
                                    12,
                                    CustomColors.blackColor,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Tempat Lahir',
                                    // Jika Anda ingin menambahkan label, Anda bisa menggunakan labelText
                                    // labelText: 'Tempat Lahir',
                                    // Atur style label jika diperlukan
                                    // labelStyle: CustomText.TextArvo(14, CustomColors.blackColor),
                                    // Jika Anda ingin menambahkan ikon di depan input, Anda bisa menggunakan prefixIcon
                                    // prefixIcon: Icon(Icons.location_on),
                                  ),
                                )
                              : Shimmer.fromColors(
                                  baseColor:
                                      Color.fromARGB(255, 104, 102, 102)!,
                                  highlightColor:
                                      const Color.fromARGB(255, 202, 200, 200)!,
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
                        // Tambahkan input tanggal lahir di sini
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 40),
                          child: detailUser['nama'] != null
                              ? TextFormField(
                                
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
                                    hintText: 'Tanggal Lahir',
                                    // Jika Anda ingin menambahkan label, Anda bisa menggunakan labelText
                                    // labelText: 'Tanggal Lahir',
                                    // Atur style label jika diperlukan
                                    // labelStyle: CustomText.TextArvo(14, CustomColors.blackColor),
                                    // Jika Anda ingin menambahkan ikon di depan input, Anda bisa menggunakan prefixIcon
                                    // prefixIcon: Icon(Icons.calendar_today),
                                  ),
                                  // Jika Anda ingin menggunakan date picker untuk memilih tanggal, Anda dapat menggunakan properti onTap
                                  onTap: () {
                                    // Panggil fungsi untuk menampilkan date picker di sini
                                    _selectDate(context);
                                  },
                                )
                              : Shimmer.fromColors(
                                  baseColor:
                                      Color.fromARGB(255, 104, 102, 102)!,
                                  highlightColor:
                                      const Color.fromARGB(255, 202, 200, 200)!,
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
                        "Edit",
                        style: CustomText.TextArvoBold(
                            20, CustomColors.whiteColor),
                      ),
                      onPressed: () {
                        print("output : " + namaController.text);
                        print("output : " + nomorTeleponController.text);
                        print("output : " + alamatController.text);
                        print("output : " + jenisKelamin);
                        print("output : " + TempatLahirController.text);
                        print("output : " + TanggalLahirController.text);
                        print("output : " + detailUser['tanggal_lahir']);
                        print("output : " + ImageSaatIni);
                        postDataToServer();
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
