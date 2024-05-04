import 'dart:convert';

import 'package:baticraft/page/page_login.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class ubah_kata_sandi extends StatefulWidget {
  const ubah_kata_sandi({super.key});

  @override
  State<ubah_kata_sandi> createState() => _ubah_kata_sandiState();
}

class _ubah_kata_sandiState extends State<ubah_kata_sandi> {
  String jsonDetailUser = "{}";
  Map<String, dynamic> detailUser = {};
  bool _showPassword = false;
  final TextEditingController katasandisaatini = TextEditingController();
  final TextEditingController katabaru = TextEditingController();
  final TextEditingController katasandikonfirmasi = TextEditingController();

  void checkCurrentPassword() async {
    var url = Server.urlLaravel("checkCurrentPassword");

    // Data yang akan dikirim ke server
    var data = {'id': page_login.id_user, 'password': katasandisaatini.text};

    // Kirim permintaan POST ke server
    var response = await http.post(url, body: data);

    // Periksa respons dari server
    if (response.statusCode == 200) {
      print(response.body);
      // CustomWidget.NotifGagalEditPassword2(context);
    postDataToServer();
    } else {

    }

    print(response.statusCode);
  }

  Future<void> postDataToServer() async {
    // Persiapkan data yang akan dikirim
    Map<String, dynamic> data = {
      'password_baru': katabaru.text,
      'id': page_login.id_user,
    };
    Uri url = Server.urlLaravel("UbahPassword");
    try {
      final response = await http.post(url, body: data);
      if (response.statusCode == 200) {
        CustomWidget.NotifBerhasilEditPassword(context);
        print(response.body);
        print('Data berhasil dikirim');
      } else {
        print('Gagal mengirim data. Kode status: ${response.statusCode} ${response.body}');
      }
    } catch (error) {
      print('Terjadi kesalahan: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    print("id = " + page_login.id_user);
    setState(() {});
  }

// hir Backend

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text("Ganti Kata Sandi",
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
      body: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(10),
        width: double.infinity,
        height: 550,
        child: Card(
          color: CustomColors.secondaryColor,
          surfaceTintColor: CustomColors.secondaryColor,
          elevation: 10,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: CustomColors.secondaryColor,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 50, 15, 50),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(Server.urlGambar("ic_pw.png"),
                        height: 25, width: 25, color: CustomColors.whiteColor),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Kata Sandi Saat Ini",
                          style: CustomText.TextArvoBold(
                              16, CustomColors.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 20),
                  child: TextField(
                    obscureText: !_showPassword,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    controller: katasandisaatini,
                    decoration: InputDecoration(
                      // Add underline using UnderlineInputBorder
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: CustomColors.whiteColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: CustomColors.whiteColor),
                      ),
                    ),
                    style: CustomText.TextArvo(16, CustomColors.whiteColor),
                  ),
                ),
                Row(
                  children: [
                    Image.asset(Server.urlGambar("ic_pw.png"),
                        height: 25, width: 25, color: CustomColors.whiteColor),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Kata Sandi Baru",
                          style: CustomText.TextArvoBold(
                              16, CustomColors.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 20),
                  child: TextField(
                    obscureText: !_showPassword,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    controller: katabaru,
                    decoration: InputDecoration(
                      // Add underline using UnderlineInputBorder
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: CustomColors.whiteColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: CustomColors.whiteColor),
                      ),
                    ),
                    style: CustomText.TextArvo(16, CustomColors.whiteColor),
                  ),
                ),
                Row(
                  children: [
                    Image.asset(Server.urlGambar("ic_pw.png"),
                        height: 25, width: 25, color: CustomColors.whiteColor),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Konfirmasi Kata Sandi",
                          style: CustomText.TextArvoBold(
                              16, CustomColors.whiteColor),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
                  child: TextField(
                    obscureText: !_showPassword,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    controller: katasandikonfirmasi,
                    decoration: InputDecoration(
                      // Add underline using UnderlineInputBorder
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: CustomColors.whiteColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: CustomColors.whiteColor),
                      ),
                    ),
                    style: CustomText.TextArvo(16, CustomColors.whiteColor),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CheckboxListTile(
                    checkColor: CustomColors.blackColor,
                    activeColor: CustomColors.whiteColor,
                    title: Text(
                      'Tampilkan Kata Sandi',
                      style: CustomText.TextArvo(14, CustomColors.whiteColor),
                    ), // Judul checkbox
                    controlAffinity: ListTileControlAffinity.leading,
                    value: _showPassword,
                    onChanged: (value) {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        style:
                            CustomButton.DefaultButton(CustomColors.whiteColor),
                        child: Text(
                          "Simpan",
                          style: CustomText.TextArvoBold(
                              20, CustomColors.secondaryColor),
                        ),
                        onPressed: () {
                          if (katasandisaatini.text.isEmpty ||
                              katabaru.text.isEmpty ||
                              katasandikonfirmasi.text.isEmpty) {
                            CustomWidget.KolomKosong(context);
                          } else if (katabaru.text !=
                              katasandikonfirmasi.text) {
                            CustomWidget.NotifGagalEditPassword(context);
                          } else {
                            checkCurrentPassword();
                          }
                        },
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
