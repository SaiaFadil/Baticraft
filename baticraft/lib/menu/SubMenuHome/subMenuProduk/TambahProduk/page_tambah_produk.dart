import 'dart:io';

import 'package:baticraft/menu/SubMenuHome/subMenuProduk/page_kelola_produk.dart';
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

class Tambah_Produk extends StatefulWidget {
  const Tambah_Produk({super.key});

  @override
  State<Tambah_Produk> createState() => Tambah_ProdukState();
}

class Tambah_ProdukState extends State<Tambah_Produk> {
//AWAL BACKEND

  String _selectedOption = "kain";
  String _selectedStatus = 'tersedia';
  String _selectedJenisLengan = 'pendek';

//awal generate kode
  String _nextProductCode = '';
  Future<String> generateNextProductCode() async {
    // Mengirim permintaan HTTP ke backend untuk mendapatkan kode produk berikutnya
    // Gantilah URL di bawah sesuai dengan endpoint yang tepat pada backend Anda
    var response = await http.get(Server.url("get_next_id_products.php"));

    if (response.statusCode == 200) {
      // Jika permintaan berhasil, gunakan kode produk berikutnya yang diterima dari backend
      print("respon" + response.body);
      return response.body;
    } else {
      // Jika terjadi kesalahan dalam mendapatkan kode produk berikutnya, kembalikan pesan kesalahan
      throw Exception('Failed to load next product code');
    }
  }

//akhir generate kode
  bool DataTidakLengkap = false;
  TextEditingController namaController = TextEditingController();
  TextEditingController deskripsiController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController stokController = TextEditingController();
  TextEditingController bahanController = TextEditingController();
  TextEditingController jenisBatikController = TextEditingController();
  TextEditingController ukuranController = TextEditingController();
  TextEditingController panjangKainController = TextEditingController();
  TextEditingController lebarKainController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ketika widget diinisialisasi, panggil metode untuk mendapatkan kode produk berikutnya
    generateNextProductCode().then((value) {
      setState(() {
        _nextProductCode = value;
        print("kode produk = " + _nextProductCode);
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  ImagePicker _imagePicker = ImagePicker();
  String ImageSaatIni = "";
  File? _profileImage;
  String? fileName;
  String ImageSaatIni2 = "";
  File? _profileImage2;
  String? fileName2;
  String ImageSaatIni3 = "";
  File? _profileImage3;
  String? fileName3;
  String ImageSaatIni4 = "";
  File? _profileImage4;
  String? fileName4;
  String ImageSaatIni5 = "";
  File? _profileImage5;
  String? fileName5;

  List<File> images = [];
  Future getImage() async {
    final pickedFile = await _imagePicker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        images.add(File(pickedFile.path));
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> uploadData() async {
    var request = http.MultipartRequest('POST', Server.url("insertProduk.php"));
    request.fields['kode_product'] = _nextProductCode;
    request.fields['nama'] = namaController.text;
    request.fields['deskripsi'] = deskripsiController.text;
    request.fields['harga'] = hargaController.text;
    request.fields['kategori'] = _selectedOption;
    request.fields['stok'] = stokController.text;
    request.fields['ukuran'] = ukuranController.text;
    request.fields['bahan'] = bahanController.text;
    request.fields['panjang_kain'] = panjangKainController.text;
    request.fields['lebar_kain'] = lebarKainController.text;
    request.fields['jenis_batik'] = jenisBatikController.text;
    request.fields['jenis_lengan'] = _selectedJenisLengan;
    request.fields['status'] = _selectedStatus;

    // Add images to request
    for (var image in images) {
      request.files
          .add(await http.MultipartFile.fromPath('images[]', image.path));
    }

    var response = await request.send();
    if (response.statusCode == 200) {
      print('Data sended successfully');
      CustomWidget.NotifBerhasilTambahProduk(context, KelolaProduk());
      // Handle success response
    } else {
      print('Failed to upload data. Error: ${response.reasonPhrase}');
      // Handle error response
    }
  }

  Future<void> _getImage() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
        _profileImage = File(pickedFile.path);
        fileName = path.basename(pickedFile.path);
        ImageSaatIni = pickedFile.name;
        // Perubahan: Mengambil nama file setelah pemilihan gambar
      });
    }
  }

  Future<void> _getImage2() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
        _profileImage2 = File(pickedFile.path);
        fileName2 = path.basename(pickedFile.path);
        ImageSaatIni2 = pickedFile.name;
        // Perubahan: Mengambil nama file setelah pemilihan gambar
      });
    }
  }

  Future<void> _getImage3() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
        _profileImage3 = File(pickedFile.path);
        fileName3 = path.basename(pickedFile.path);
        ImageSaatIni3 = pickedFile.name;
        // Perubahan: Mengambil nama file setelah pemilihan gambar
      });
    }
  }

  Future<void> _getImage4() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
        _profileImage4 = File(pickedFile.path);
        fileName4 = path.basename(pickedFile.path);
        ImageSaatIni4 = pickedFile.name;
        // Perubahan: Mengambil nama file setelah pemilihan gambar
      });
    }
  }

  Future<void> _getImage5() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        images.add(File(pickedFile.path));
        _profileImage5 = File(pickedFile.path);
        fileName5 = path.basename(pickedFile.path);
        ImageSaatIni5 = pickedFile.name;
      });
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
            controller: ukuranController,
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
            controller: panjangKainController,
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
            controller: lebarKainController,
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
            controller: ukuranController,
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
                value: _selectedJenisLengan,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedJenisLengan = newValue!;
                  });
                },
                items: <String>['pendek', 'panjang']
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
            controller: ukuranController,
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
                value: _selectedJenisLengan,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedJenisLengan = newValue!;
                  });
                },
                items: <String>['pendek', 'panjang']
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
      ],
    );
  }

// Tambahan inputan KEMEJA

//tambahan inputan gambar 2
  Column InputGambar2() {
    return Column(
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
              child: ImageSaatIni2 != ""
                  ? Card(
                      margin: EdgeInsets.all(20),
                      child: Image(
                        image: FileImage(_profileImage2!),
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
                _getImage2();
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
                    "Upload Gambar 2",
                    style: CustomText.TextArvoBold(16, CustomColors.whiteColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

//tambahan inputan gambar 2
//tambahan inputan gambar 3
  Column InputGambar3() {
    return Column(
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
              child: ImageSaatIni3 != ""
                  ? Card(
                      margin: EdgeInsets.all(20),
                      child: Image(
                        image: FileImage(_profileImage3!),
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
                _getImage3();
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
                    "Upload Gambar 3",
                    style: CustomText.TextArvoBold(16, CustomColors.whiteColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

//tambahan inputan gambar 3
//tambahan inputan gambar 4
  Column InputGambar4() {
    return Column(
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
              child: ImageSaatIni4 != ""
                  ? Card(
                      margin: EdgeInsets.all(20),
                      child: Image(
                        image: FileImage(_profileImage4!),
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
                _getImage4();
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
                    "Upload Gambar 4",
                    style: CustomText.TextArvoBold(16, CustomColors.whiteColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

//tambahan inputan gambar 4
//tambahan inputan gambar 5
  Column InputGambar5() {
    return Column(
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
              child: ImageSaatIni5 != ""
                  ? Card(
                      margin: EdgeInsets.all(20),
                      child: Image(
                        image: FileImage(_profileImage5!),
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
                _getImage5();
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
                    "Upload Gambar 5",
                    style: CustomText.TextArvoBold(16, CustomColors.whiteColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

//tambahan inputan gambar 5

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          DataTidakLengkap = false;
        });
        return true;
      },
      child: Scaffold(
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
        body: GestureDetector(
          onTap: () {
            setState(() {
              DataTidakLengkap = false;
            });
          },
          child: Container(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(10),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
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
                  ImageSaatIni.isEmpty ? SizedBox() : InputGambar2(),
                  ImageSaatIni2.isEmpty ? SizedBox() : InputGambar3(),
                  ImageSaatIni3.isEmpty ? SizedBox() : InputGambar4(),
                  ImageSaatIni4.isEmpty ? SizedBox() : InputGambar5(),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Nama Produk",
                        style: CustomText.TextArvoBold(
                            14, CustomColors.blackColor),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: TextField(
                      onTap: () {
                        DataTidakLengkap = false;
                      },
                      controller: namaController,
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
                          borderSide:
                              BorderSide(color: CustomColors.blackColor),
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
                        style: CustomText.TextArvoBold(
                            14, CustomColors.blackColor),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: TextField(
                      onTap: () {
                        DataTidakLengkap = false;
                      },
                      controller: deskripsiController,
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
                          borderSide:
                              BorderSide(color: CustomColors.blackColor),
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
                        style: CustomText.TextArvoBold(
                            14, CustomColors.blackColor),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: TextField(
                      onTap: () {
                        DataTidakLengkap = false;
                      },
                      controller: hargaController,
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
                          borderSide:
                              BorderSide(color: CustomColors.blackColor),
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
                        style: CustomText.TextArvoBold(
                            14, CustomColors.blackColor),
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
                          style:
                              CustomText.TextArvo(16, CustomColors.blackColor),
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
                        style: CustomText.TextArvoBold(
                            14, CustomColors.blackColor),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: TextField(
                      onTap: () {
                        DataTidakLengkap = false;
                      },
                      controller: stokController,
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
                          borderSide:
                              BorderSide(color: CustomColors.blackColor),
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
                        style: CustomText.TextArvoBold(
                            14, CustomColors.blackColor),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: TextField(
                      onTap: () {
                        DataTidakLengkap = false;
                      },
                      controller: bahanController,
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
                          borderSide:
                              BorderSide(color: CustomColors.blackColor),
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
                        style: CustomText.TextArvoBold(
                            14, CustomColors.blackColor),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: TextField(
                      onTap: () {
                        DataTidakLengkap = false;
                      },
                      controller: jenisBatikController,
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
                          borderSide:
                              BorderSide(color: CustomColors.blackColor),
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
                        style: CustomText.TextArvoBold(
                            14, CustomColors.blackColor),
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
                              surfaceTintColor:
                                  MaterialStateProperty.all<Color>(
                                      _selectedOption == 'kain'
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
                                  _selectedOption == 'kain'
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
                              surfaceTintColor:
                                  MaterialStateProperty.all<Color>(
                                      _selectedOption == 'kaos'
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
                                  _selectedOption == 'kaos'
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
                              surfaceTintColor:
                                  MaterialStateProperty.all<Color>(
                                      _selectedOption == 'kemeja'
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
                                  _selectedOption == 'kemeja'
                                      ? CustomColors.secondaryColor
                                      : CustomColors.whiteColor),
                            )),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  _selectedOption == 'kain' ? InputanKain() : SizedBox(),
                  _selectedOption == 'kaos' ? InputanKaos() : SizedBox(),
                  _selectedOption == 'kemeja' ? InputanKemeja() : SizedBox(),
                  Visibility(
                    visible: DataTidakLengkap,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        "Lengkapi Semua Kolom!",
                        style: CustomText.TextArvoBoldItalic(
                            18, CustomColors.redColor),
                      ),
                    ),
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
                            setState(() {
                              if (ImageSaatIni.isEmpty) {
                                DataTidakLengkap = true;
                              } else if (namaController.text.isEmpty) {
                                DataTidakLengkap = true;
                              } else if (deskripsiController.text.isEmpty) {
                                DataTidakLengkap = true;
                              } else if (hargaController.text.isEmpty) {
                                DataTidakLengkap = true;
                              } else if (stokController.text.isEmpty) {
                                DataTidakLengkap = true;
                              } else if (bahanController.text.isEmpty) {
                                DataTidakLengkap = true;
                              } else if (jenisBatikController.text.isEmpty) {
                                DataTidakLengkap = true;
                              } else if (ukuranController.text.isEmpty) {
                                DataTidakLengkap = true;
                              } else if (_selectedOption == "kain") {
                                if (panjangKainController.text.isEmpty) {
                                  DataTidakLengkap = true;
                                } else if (lebarKainController.text.isEmpty) {
                                  DataTidakLengkap = true;
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text(
                                          "Konfirmasi",
                                          style: CustomText.TextArvoBold(
                                              18, CustomColors.whiteColor),
                                        ),
                                        backgroundColor:
                                            CustomColors.secondaryColor,
                                        content: Text(
                                          "Apakah Anda yakin data sudah benar?",
                                          style: CustomText.TextArvo(
                                              16, CustomColors.whiteColor),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Tutup dialog
                                              uploadData(); // Unggah data jika user yakin
                                              print("pressed");
                                            },
                                            child: Text(
                                              "Ya",
                                              style: CustomText.TextArvoBold(
                                                  18, CustomColors.whiteColor),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Tutup dialog
                                            },
                                            child: Text(
                                              "Tidak",
                                              style: CustomText.TextArvoBold(
                                                  18, CustomColors.whiteColor),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        "Konfirmasi",
                                        style: CustomText.TextArvoBold(
                                            18, CustomColors.whiteColor),
                                      ),
                                      backgroundColor:
                                          CustomColors.secondaryColor,
                                      content: Text(
                                        "Apakah Anda yakin data sudah benar?",
                                        style: CustomText.TextArvo(
                                            16, CustomColors.whiteColor),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Tutup dialog
                                            uploadData(); // Unggah data jika user yakin
                                            print("pressed");
                                          },
                                          child: Text(
                                            "Ya",
                                            style: CustomText.TextArvoBold(
                                                18, CustomColors.whiteColor),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Tutup dialog
                                          },
                                          child: Text(
                                            "Tidak",
                                            style: CustomText.TextArvoBold(
                                                18, CustomColors.whiteColor),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            });
                          },
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
