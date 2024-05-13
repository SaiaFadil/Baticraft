import 'dart:convert';

import 'package:baticraft/page/page_login.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class detail_kelola_pengguna extends StatefulWidget {
  const detail_kelola_pengguna({super.key});
  static String id_user = "";

  @override
  State<detail_kelola_pengguna> createState() => _detail_kelola_penggunaState();
}

class _detail_kelola_penggunaState extends State<detail_kelola_pengguna> {
  String jsonDetailUser = "{}"; // Initialize as an empty JSON object
  Map<String, dynamic> detailUser = {}; // Initialize as an empty map
  String email = "";
  String nama = "";
  Future getDetailUser() async {
    final response = await http.post(Server.urlLaravel("DetailProfil"),
        body: {"id_user": detail_kelola_pengguna.id_user});

    if (response.statusCode == 200) {
      jsonDetailUser = response.body.toString();
      detailUser = json.decode(jsonDetailUser);
      if (detailUser.isNotEmpty) {
        setState(() {
          email = detailUser['email'];
          nama = detailUser['nama'];
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
    print("id = ");
    setState(() {
      getDetailUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        title: Text("Profil Lengkap",
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
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.all(10),
        height: 550,
        width: double.infinity,
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
            padding: EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        alignment: Alignment.topCenter,
                        margin: EdgeInsets.only(top: 15),
                        child: detailUser.isNotEmpty
                            ? CircleAvatar(
                                foregroundColor: CustomColors.whiteColor,

                                backgroundColor: CustomColors
                                    .secondaryColor, // Inner circle color
                                radius: 50,
                                child: CircleAvatar(
                                  backgroundColor: CustomColors.whiteColor,
                                  radius: 45,
                                  child: CircleAvatar(
                                      foregroundColor:
                                          CustomColors.secondaryColor,
                                      radius: 42, // Ubah ukuran avatar
                                      backgroundImage: NetworkImage(
                                          Server.urlLaravelImageUser(detailUser[
                                              'image'])) // Ganti URL gambar sesuai kebutuhan
                                      ),
                                ),
                              )
                            : CircleAvatar(
                                // Gunakan AssetImage untuk gambar lokal
                                radius: 50,
                                backgroundColor: CustomColors.secondaryColor,
                                child: CircleAvatar(
                                    backgroundColor: CustomColors.whiteColor,
                                    radius: 45,
                                    child: Shimmer.fromColors(
                                        baseColor: CustomColors.secondaryColor!,
                                        highlightColor:
                                            Color.fromARGB(255, 255, 254, 254)!,
                                        child: CircleAvatar(
                                          foregroundColor:
                                              CustomColors.secondaryColor,
                                          radius: 42,
                                          backgroundImage: AssetImage(
                                              Server.urlGambar("default2.png")),
                                        ))),
                              )),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: detailUser['nama'] != null
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    detailUser['nama'],
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomText.TextArvoBold(
                                      16,
                                      CustomColors.whiteColor,
                                    ),
                                    textAlign: TextAlign.start,
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
                                      16,
                                      CustomColors.whiteColor,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: detailUser['role'] != null
                              ? Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    detailUser['role'],
                                    overflow: TextOverflow.ellipsis,
                                    style: CustomText.TextArvo(
                                      12,
                                      CustomColors.whiteColor,
                                    ),
                                    textAlign: TextAlign.start,
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
                                      CustomColors.whiteColor,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ],
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
                            Icon(Icons.email,
                                size: 25, color: CustomColors.whiteColor),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Email",
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.whiteColor),
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
                              child: detailUser['email'] != null
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        detailUser['email'],
                                        style: CustomText.TextArvo(
                                          12,
                                          CustomColors.whiteColor,
                                        ),
                                        textAlign: TextAlign.start,
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
                                          CustomColors.whiteColor,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Icon(Icons.call,
                                size: 25, color: CustomColors.whiteColor),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Nomor Telepon",
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.whiteColor),
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
                                      child: Text(
                                        detailUser['no_telpon'],
                                        style: CustomText.TextArvo(
                                          12,
                                          CustomColors.whiteColor,
                                        ),
                                        textAlign: TextAlign.start,
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
                                          CustomColors.whiteColor,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Icon(Icons.location_pin,
                                size: 25, color: CustomColors.whiteColor),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Alamat",
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.whiteColor),
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
                                      child: Text(
                                        detailUser['alamat'],
                                        overflow: TextOverflow.ellipsis,
                                        style: CustomText.TextArvo(
                                          12,
                                          CustomColors.whiteColor,
                                        ),
                                        textAlign: TextAlign.start,
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
                                          CustomColors.whiteColor,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Icon(Icons.circle_outlined,
                                size: 25, color: CustomColors.whiteColor),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Jenis Kelamin",
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.whiteColor),
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
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        detailUser['jenis_kelamin'],
                                        style: CustomText.TextArvo(
                                          12,
                                          CustomColors.whiteColor,
                                        ),
                                        textAlign: TextAlign.start,
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
                                          CustomColors.whiteColor,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Icon(Icons.date_range,
                                size: 25, color: CustomColors.whiteColor),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Tempat/Tanggal Lahir",
                              style: CustomText.TextArvoBold(
                                  14, CustomColors.whiteColor),
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
                              child: detailUser['tempat_lahir'] != null
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        detailUser['tempat_lahir'] +
                                            ", " +
                                            detailUser['tanggal_lahir'],
                                        style: CustomText.TextArvo(
                                          12,
                                          CustomColors.whiteColor,
                                        ),
                                        textAlign: TextAlign.start,
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
                                          CustomColors.whiteColor,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
