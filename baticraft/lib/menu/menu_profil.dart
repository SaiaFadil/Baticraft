import 'package:flutter/material.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';

class menu_profil extends StatefulWidget {
  const menu_profil({super.key});

  @override
  State<menu_profil> createState() => _menu_profilState();
}

class _menu_profilState extends State<menu_profil> {
  String profil = "", nama = "", email = "", alamat = "";
  String jsonProfil = "{}";
  Map<String, dynamic> listProfil = {};

  // Future getDetailProfil() async {
  //   final response = await http.post(Server.url("ShowDetailProfil.php"),
  //       body: {"id_user": page_login.id_user});
  //   setState(() {
  //     jsonProfil = response.body.toString();
  //     listProfil = Map<String, dynamic>.from(json.decode(jsonProfil));
  //     nama = listProfil['nama'];
  //     email = listProfil['email'];
  //     alamat = listProfil['alamat'];
  //     print(response.body);
  //     profil = Server.urlGambar(listProfil['foto']);});
  // }

  @override
  void initState() {
    super.initState();
    // getDetailProfil();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            "Profil",
            style: CustomText.TextArvoBold(40, CustomColors.blackColor),
          ),
        ),
      ),
    );
  }
}
