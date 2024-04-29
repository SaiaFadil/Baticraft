import 'dart:convert';
import 'dart:io';

import 'package:baticraft/menu/SubMenuHome/subMenuProduk/page_kelola_produk.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/List_Kelola_Produk.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class Edit_Produk_Kemeja extends StatefulWidget {
  const Edit_Produk_Kemeja({super.key});

  @override
  State<Edit_Produk_Kemeja> createState() => Edit_Produk_KemejaState();
}

class Edit_Produk_KemejaState extends State<Edit_Produk_Kemeja> {
//AWAL BACKEND
  String jsonProdukKemeja = "{}";
  List<String> imagePaths = [];
  List<Map<String, dynamic>> listKemeja = [];
  Future<void> showKemeja() async {
    final response = await http.post(Server.urlLaravel("getDetailKemeja"),
        body: {"id_produk": List_Kelola_Produk.id_produk});
    jsonProdukKemeja = response.body.toString();
    setState(() {
      listKemeja =
          List<Map<String, dynamic>>.from(json.decode(jsonProdukKemeja));
      namaController.text = listKemeja[0]['nama'];
      deskripsiController.text = listKemeja[0]['deskripsi'];
      hargaController.text = listKemeja[0]['harga'];
      stokController.text = listKemeja[0]['stok'];
      bahanController.text = listKemeja[0]['bahan'];
      jenisBatikController.text = listKemeja[0]['jenis_batik'];
      ukuranController.text = listKemeja[0]['ukuran'];
      panjangKainController.text = listKemeja[0]['panjang_kain'];
      lebarKainController.text = listKemeja[0]['lebar_kain'];
      _selectedJenisLengan = listKemeja[0]['jenis_lengan'];
      imagePaths = List<String>.from(listKemeja[0]['image_paths']);
    });
    print("Panjang dataaa = " + imagePaths.length.toString());

    print(listKemeja[0]['nama']);
  }

  String _selectedStatus = 'tersedia';
  String _selectedJenisLengan = 'pendek';

//awal generate kode

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
    showKemeja();
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

  Future<void> addImagesToProduct() async {
    // URL endpoint untuk mengirimkan data ke backend
    var url = Server.urlLaravel('generateProductCode');

    // Membuat request HTTP POST
    var requesttt = http.MultipartRequest('POST', url);
    List<String> imagePathhh = [];
    // Menambahkan data ID produk ke dalam request
    requesttt.fields['id_produk'] = List_Kelola_Produk.id_produk;

    if (imagePaths.length > 4 && ImageSaatIni5.isEmpty) {
      imagePathhh.add(imagePaths[4]);
    }
    if (imagePaths.length > 3 && ImageSaatIni4.isEmpty) {
      imagePathhh.add(imagePaths[3]);
    }
    if (imagePaths.length > 2 && ImageSaatIni3.isEmpty) {
      imagePathhh.add(imagePaths[2]);
    }
    if (imagePaths.length > 1 && ImageSaatIni2.isEmpty) {
      imagePathhh.add(imagePaths[1]);
    }
    if (imagePaths.length > 0 && ImageSaatIni.isEmpty) {
      imagePathhh.add(imagePaths[0]);
    }
    // Menambahkan nama file gambar ke dalam request
    for (var imagePath in imagePaths) {
      requesttt.fields['image_paths[]'] = imagePath;
    }

    try {
      // Mengirimkan request ke backend
      var streamedResponse = await requesttt.send();

      // Mengecek status response
      if (streamedResponse.statusCode == 200) {
        print(streamedResponse.stream);
        print('Data gambar berhasil ditambahkan.');
      } else {
        print(
            'Gagal menambahkan data gambar. Status: ${streamedResponse.statusCode}');
      }
    } catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  Future<void> uploadData() async {
    var request =
        http.MultipartRequest('POST', Server.urlLaravel("updateProduct"));
    request.fields['id_produk'] = List_Kelola_Produk.id_produk;
    request.fields['nama'] = namaController.text;
    request.fields['deskripsi'] = deskripsiController.text;
    request.fields['harga'] = hargaController.text;
    request.fields['stok'] = stokController.text;
    request.fields['ukuran'] = ukuranController.text;
    request.fields['bahan'] = bahanController.text;
    request.fields['panjang_kain'] = panjangKainController.text;
    request.fields['lebar_kain'] = lebarKainController.text;
    request.fields['jenis_batik'] = jenisBatikController.text;
    request.fields['jenis_lengan'] = _selectedJenisLengan;

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
                value: listKemeja.isEmpty
                    ? _selectedJenisLengan
                    : listKemeja[0]['jenis_lengan'],
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
                      child: imagePaths.length < 2
                          ? Image.asset(
                              Server.urlGambar("default2.png"),
                              fit: BoxFit.contain,
                            )
                          : Container(
                              margin: EdgeInsets.all(20),
                              child: Image.network(
                                Server.urlLaravelImage(imagePaths[1]),
                                fit: BoxFit.contain,
                              ))),
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
                    Server.urlGambar("ic_editproduk.png"),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Edit Gambar",
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
                      child: imagePaths.length < 3
                          ? Image.asset(
                              Server.urlGambar("default2.png"),
                              fit: BoxFit.contain,
                            )
                          : Container(
                              margin: EdgeInsets.all(20),
                              child: Image.network(
                                Server.urlLaravelImage(imagePaths[2]),
                                fit: BoxFit.contain,
                              ))),
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
                    Server.urlGambar("ic_editproduk.png"),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Edit Gambar",
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
                      child: imagePaths.length < 4
                          ? Image.asset(
                              Server.urlGambar("default2.png"),
                              fit: BoxFit.contain,
                            )
                          : Container(
                              margin: EdgeInsets.all(20),
                              child: Image.network(
                                Server.urlLaravelImage(imagePaths[3]),
                                fit: BoxFit.contain,
                              ))),
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
                    Server.urlGambar("ic_editproduk.png"),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Edit Gambar",
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
                      child: imagePaths.length < 5
                          ? Image.asset(
                              Server.urlGambar("default2.png"),
                              fit: BoxFit.contain,
                            )
                          : Container(
                              margin: EdgeInsets.all(20),
                              child: Image.network(
                                Server.urlLaravelImage(imagePaths[4]),
                                fit: BoxFit.contain,
                              ))),
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
                    Server.urlGambar("ic_editproduk.png"),
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Edit Gambar",
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
          title: Text("Edit Produk",
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
                                child: imagePaths.length > 0
                                    ? Container(
                                        margin: EdgeInsets.all(20),
                                        child: Image.network(
                                          Server.urlLaravelImage(
                                              imagePaths[0]),
                                          fit: BoxFit.contain,
                                        ))
                                    : Image.asset(
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
                                  EdgeInsets.fromLTRB(0, 12, 0, 12)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              CustomColors.secondaryColor),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              Server.urlGambar("ic_editproduk.png"),
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Edit Gambar",
                              style: CustomText.TextArvoBold(
                                  16, CustomColors.whiteColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  imagePaths.length > 0 || ImageSaatIni.isNotEmpty
                      ? InputGambar2()
                      : SizedBox(),
                  imagePaths.length > 1 || ImageSaatIni2.isNotEmpty
                      ? InputGambar3()
                      : SizedBox(),
                  imagePaths.length > 2 || ImageSaatIni3.isNotEmpty
                      ? InputGambar4()
                      : SizedBox(),
                  imagePaths.length > 3 || ImageSaatIni4.isNotEmpty
                      ? InputGambar5()
                      : SizedBox(),
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
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text("Kategori : Kemeja",
                        style: CustomText.TextArvoBold(
                            16, CustomColors.blackColor)),
                  ),
                  InputanKemeja(),
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
                            "Edit",
                            style: CustomText.TextArvoBold(
                                20, CustomColors.whiteColor),
                          ),
                          onPressed: () {
                            setState(() {
                              if (namaController.text.isEmpty) {
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
                                                addImagesToProduct();
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
