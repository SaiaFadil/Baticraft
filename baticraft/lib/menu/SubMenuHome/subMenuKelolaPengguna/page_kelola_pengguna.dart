import 'dart:convert';

import 'package:baticraft/menu/SubMenuHome/subMenuKelolaPengguna/page_detail_pengguna.dart';
import 'package:baticraft/menu/SubMenuHome/subMenuKelolaPengguna/tambah_admin.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class KelolaPengguna extends StatefulWidget {
  const KelolaPengguna({Key? key}) : super(key: key);

  @override
  State<KelolaPengguna> createState() => _KelolaPenggunaState();
}

class _KelolaPenggunaState extends State<KelolaPengguna> {
  String jsonProdukUser = "{}";
  List<Map<String, dynamic>> listUser = [];
  final TextEditingController cariController = TextEditingController();
  Future<void> showData(String role) async {
    final response = await http
        .post(Server.urlLaravel("getKelolaPenguna"), body: {'search': role});
    jsonProdukUser = response.body.toString();
    setState(() {
      listUser = List<Map<String, dynamic>>.from(json.decode(jsonProdukUser));
    });
  }

  @override
  void initState() {
    showData("admin");
    // TODO: implement initState
    super.initState();
  }

  Future showPencarian(String searchText, String nama) async {
    final response = await http.post(Server.urlLaravel("getCariPengguna"),
        body: {'search': searchText, 'searchNama': nama});
    jsonProdukUser = response.body.toString();
    setState(() {
      listUser = List<Map<String, dynamic>>.from(json.decode(jsonProdukUser));
    });
    print(jsonProdukUser);
  }

  bool admin = true;
  bool customer = false;
  Color active = CustomColors.threertyColor;
  Color deactive = CustomColors.HintColor;

  Color gantiWarnaAdmin() {
    setState(() {
      admin = true;
      customer = false;
    });
    cariController.clear();
    showData("admin");
    return admin ? active : deactive;
  }

  Color gantiWarnaCustomer() {
    setState(() {
      admin = false;
      customer = true;
    });
    cariController.clear();
    showData("pembeli");
    return customer ? active : deactive;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 10,
          surfaceTintColor: CustomColors.whiteColor,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: CustomColors.threertyColor,
            ), // Icon panah di platform iOS
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {});
                  gantiWarnaAdmin();
                },
                child: Text("Admin",
                    style: CustomText.TextArvoBold(
                        16, admin == true ? active : deactive)),
              ),
              Text(" | ",
                  style:
                      CustomText.TextArvoBold(16, CustomColors.threertyColor)),
              InkWell(
                onTap: () {
                  setState(() {});
                  gantiWarnaCustomer();
                },
                child: Text("Customer",
                    style: CustomText.TextArvoBold(
                        16, customer == true ? active : deactive)),
              ),
              SizedBox(
                width: 40,
              ),
            ],
          )),
      body: admin == true ? _buildAdminBody() : _buildCustomerBody(),
    );
  }

  int nomor = 1;
  Widget KumpulanUser() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: listUser.isEmpty
            ? List.empty()
            : List.generate(
                listUser.length,
                (index) => Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: 20,
                              child: Text(
                                (index + 1).toInt().toString(),
                                textAlign: TextAlign.left,
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor),
                              ),
                            ),
                            Container(
                              width: 90,
                              child: Text(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                "${listUser[index]['nama']}",
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor),
                              ),
                            ),
                            Container(
                              width: 110,
                              child: Text(
                                listUser[index]['email'],
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: CustomText.TextArvoBold(
                                    14, CustomColors.blackColor),
                              ),
                            ),
                            Container(
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () {
                                  detail_kelola_pengguna.id_user =
                                      listUser[index]['id'].toString();
                                  print(
                                      "id user ${detail_kelola_pengguna.id_user}");
                                  Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                                secondaryAnimation) =>
                                            detail_kelola_pengguna(),
                                        transitionsBuilder: (context, animation,
                                            secondaryAnimation, child) {
                                          return FadeTransition(
                                              opacity: animation, child: child);
                                        },
                                      ));
                                },
                                style: CustomButton.miniButton(
                                    CustomColors.greenColor),
                                child: Text(
                                  "Lihat",
                                  textAlign: TextAlign.left,
                                  style: CustomText.TextArvoBold(
                                      14, CustomColors.whiteColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: CustomColors.HintColor,
                          height: 1,
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }

  Widget _buildAdminBody() {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  tambah_admin(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                        ));
                  },
                  style: CustomButton.miniButton(CustomColors.secondaryColor),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_add_alt_1,
                        color: CustomColors.whiteColor,
                      ),
                      Text(
                        "    Tambah admin",
                        style: CustomText.TextArvoBold(
                            14, CustomColors.whiteColor),
                      )
                    ],
                  )),
              Container(
                  width: 170,
                  height: 50,
                  margin: EdgeInsets.all(10),
                  child: Card(
                    surfaceTintColor: CustomColors.whiteColor,
                    borderOnForeground: true,
                    color: CustomColors.whiteColor,
                    semanticContainer: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                            color: CustomColors.secondaryColor,
                            strokeAlign: 1)),
                    elevation: 0,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: TextField(
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.start,
                        textInputAction: TextInputAction.next,
                        controller: cariController,
                        onChanged: (value) {
                          showData("admin");
                          if (value.isNotEmpty) {
                            showPencarian("admin", value);
                          } else {
                            showData("admin");
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Cari User...',
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: 10.0),
                        ),
                        style: CustomText.TextArvo(14, CustomColors.blackColor),
                      ),
                    ),
                  )),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: CustomColors.secondaryColor,
            height: 2,
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "No.",
                  style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                ),
                Text(
                  "Nama",
                  style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                ),
                Text(
                  "Email",
                  style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                ),
                SizedBox(
                  width: 100,
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: CustomColors.secondaryColor,
            height: 2,
          ),
          SizedBox(
            height: 10,
          ),
          listUser.isNotEmpty ? KumpulanUser() : SizedBox()
        ]),
      ),
    );
  }

  Widget _buildCustomerBody() {
    return Container(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              height: 50,
              margin: EdgeInsets.all(10),
              child: Card(
                surfaceTintColor: CustomColors.whiteColor,
                borderOnForeground: true,
                color: CustomColors.whiteColor,
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                        color: CustomColors.secondaryColor, strokeAlign: 1)),
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    textInputAction: TextInputAction.next,
                    controller: cariController,
                    onChanged: (value) {
                      showData("pembeli");
                      if (value.isNotEmpty) {
                        showPencarian("pembeli", value);
                      } else {
                        showData("pembeli");
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Cari User...',
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
                    ),
                    style: CustomText.TextArvo(14, CustomColors.blackColor),
                  ),
                ),
              )),
          SizedBox(
            height: 20,
          ),
          Container(
            color: CustomColors.secondaryColor,
            height: 2,
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "No.",
                  style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                ),
                Container(
                  child: Text(
                    "Nama",
                    style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                  ),
                ),
                Text(
                  "Email",
                  style: CustomText.TextArvoBold(14, CustomColors.blackColor),
                ),
                SizedBox(
                  width: 100,
                )
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            color: CustomColors.secondaryColor,
            height: 2,
          ),
          SizedBox(
            height: 10,
          ),
          listUser.isNotEmpty ? KumpulanUser() : SizedBox()
        ]),
      ),
    );
  }
}
