import 'dart:convert';

import 'package:baticraft/page/page_login.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class detail_profil extends StatefulWidget {
  const detail_profil({super.key});

  @override
  State<detail_profil> createState() => _detail_profilState();
}

class _detail_profilState extends State<detail_profil> {
  String jsonDetailUser = "{}"; // Initialize as an empty JSON object
  Map<String, dynamic> detailUser = {}; // Initialize as an empty map
  String email = "";
  String nama = "";
  Future getDetailUser() async {
    final response = await http.post(Server.urlLaravel("DetailProfil"),
        body: {"id_user": page_login.id_user});

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
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            padding: EdgeInsets.all(10),
            height: 470,
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
                padding: EdgeInsets.fromLTRB(15, 50, 15, 50),
                child: Column(
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
                                  24,
                                  CustomColors.whiteColor,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            )
                          : Shimmer.fromColors(
                              baseColor: Color.fromARGB(255, 104, 102, 102)!,
                              highlightColor:
                                  const Color.fromARGB(255, 202, 200, 200)!,
                              child: Text(
                                'Loading...',
                                style: CustomText.TextArvo(
                                  24,
                                  CustomColors.whiteColor,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: detailUser['email'] != null
                          ? Align(
                              alignment: Alignment.center,
                              child: Text(
                                detailUser['email'],
                                overflow: TextOverflow.ellipsis,
                                style: CustomText.TextArvo(
                                  12,
                                  CustomColors.whiteColor,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            )
                          : Shimmer.fromColors(
                              baseColor: Color.fromARGB(255, 104, 102, 102)!,
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
                                  style: CustomText.TextArvo(
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
                                            style: CustomText.TextArvoBold(
                                              12,
                                              CustomColors.whiteColor,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      : Shimmer.fromColors(
                                          baseColor: Color.fromARGB(
                                              255, 104, 102, 102)!,
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
                                  style: CustomText.TextArvo(
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
                                            style: CustomText.TextArvoBold(
                                              12,
                                              CustomColors.whiteColor,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      : Shimmer.fromColors(
                                          baseColor: Color.fromARGB(
                                              255, 104, 102, 102)!,
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
                                  style: CustomText.TextArvo(
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
                                            style: CustomText.TextArvoBold(
                                              12,
                                              CustomColors.whiteColor,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      : Shimmer.fromColors(
                                          baseColor: Color.fromARGB(
                                              255, 104, 102, 102)!,
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
                                  style: CustomText.TextArvo(
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
                                            style: CustomText.TextArvoBold(
                                              12,
                                              CustomColors.whiteColor,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      : Shimmer.fromColors(
                                          baseColor: Color.fromARGB(
                                              255, 104, 102, 102)!,
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
          Container(
              alignment: Alignment.topCenter,
              margin: EdgeInsets.only(top: 15),
              child: detailUser.isNotEmpty
                  ? CircleAvatar(
                      foregroundColor: CustomColors.whiteColor,

                      backgroundColor:
                          CustomColors.secondaryColor, // Inner circle color
                      radius: 70.0,
                      child: CircleAvatar(
                        backgroundColor: CustomColors.whiteColor,
                        radius: 65,
                        child: CircleAvatar(
                            foregroundColor: CustomColors.secondaryColor,
                            radius: 55, // Ubah ukuran avatar
                            backgroundImage: NetworkImage(
                                Server.urlLaravelImageUser(detailUser[
                                    'image'])) // Ganti URL gambar sesuai kebutuhan
                            ),
                      ),
                    )
                  :  CircleAvatar(
                          // Gunakan AssetImage untuk gambar lokal
                          radius: 70,
                              backgroundColor: CustomColors.secondaryColor,
                          child: CircleAvatar(
                              backgroundColor: CustomColors.whiteColor,
                              radius: 65,
                              child: Shimmer.fromColors(
                      baseColor: CustomColors.secondaryColor!,
                      highlightColor: Color.fromARGB(255, 255, 254, 254)!,
                      child:CircleAvatar(
                                foregroundColor: CustomColors.secondaryColor,
                                radius: 55,
                                backgroundImage: AssetImage(
                                    Server.urlGambar("default2.png")),
                              ))),)
                    ),
        ],
      ),
    );
  }
}
