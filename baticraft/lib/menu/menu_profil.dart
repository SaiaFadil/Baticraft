import 'dart:convert';

import 'package:baticraft/menu/SubMenuProfil/page_detail_profil.dart';
import 'package:baticraft/menu/SubMenuProfil/page_edit_profil.dart';
import 'package:baticraft/menu/SubMenuProfil/page_ubah_kata_sandi.dart';
import 'package:baticraft/page/page_login.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class menu_profil extends StatefulWidget {
  const menu_profil({super.key});

  @override
  State<menu_profil> createState() => _menu_profilState();
}

class _menu_profilState extends State<menu_profil> {
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: -10,
                left: 0,
                right: 0,
                child: Image.asset(Server.urlGambar("lingkaran.png"))),
            Positioned(
              top: 70,
              left: 20,
              right: 20,
              child: Column(
                children: [
                  Card(
                    surfaceTintColor: CustomColors.whiteColor,
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: CustomColors.secondaryColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      detail_profil(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                            ));
                      },
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                detailUser.isNotEmpty
                                    ? CircleAvatar(
                                        radius: 30, // Ubah ukuran avatar
                                        backgroundImage: NetworkImage(
                                            Server.urlLaravelImage(detailUser[
                                                'image'])) // Ganti URL gambar sesuai kebutuhan
                                        )
                                    : Shimmer.fromColors(
                                        baseColor:
                                            Color.fromARGB(255, 42, 5, 146)!,
                                        highlightColor:
                                            Color.fromARGB(255, 255, 254, 254)!,
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              Server.urlGambar(
                                                  "default2.png")), // Gunakan AssetImage untuk gambar lokal
                                          radius: 30,
                                        ),
                                      ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    detailUser['nama'] != null
                                        ? Text(
                                            detailUser['nama'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: CustomText.TextArvoBold(
                                              16,
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
                                    detailUser['email'] != null
                                        ? Text(
                                            detailUser['email'],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: CustomText.TextArvo(
                                              12,
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
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: CustomColors.secondaryColor,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    edit_profil(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ));
                    },
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 3),
                          child: Image.asset(
                            Server.urlGambar("ic_editprofil.png"),
                            height: 25,
                            width: 25,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Edit Profil",
                          style: CustomText.TextArvoBold(
                              16, CustomColors.secondaryColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: CustomColors.secondaryColor,
                    margin: EdgeInsets.only(
                        top: 5, left: 10, right: 10, bottom: 10),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ubah_kata_sandi(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                          ));
                    },
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 3),
                          child: Image.asset(
                            Server.urlGambar("ic_gantipassword.png"),
                            height: 25,
                            width: 25,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Ganti Kata Sandi",
                          style: CustomText.TextArvoBold(
                              16, CustomColors.secondaryColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: CustomColors.secondaryColor,
                    margin: EdgeInsets.only(
                        top: 5, left: 10, right: 10, bottom: 10),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder:
                                  ((context, animation, secondaryAnimation) =>
                                      page_login())));
                      page_login.id_user = "";
                    },
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, bottom: 3),
                          child: Image.asset(
                            Server.urlGambar("ic_keluar.png"),
                            height: 25,
                            width: 25,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Keluar",
                          style: CustomText.TextArvoBold(
                              16, CustomColors.secondaryColor),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: CustomColors.secondaryColor,
                    margin: EdgeInsets.only(top: 5, left: 10, right: 10),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
