import 'package:flutter/material.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';

class menu_profile extends StatefulWidget {
  const menu_profile({super.key});

  @override
  State<menu_profile> createState() => _menu_profileState();
}

class _menu_profileState extends State<menu_profile> {
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
