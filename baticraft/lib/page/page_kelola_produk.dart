import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/List_Kelola_Produk.dart';
import 'package:flutter/material.dart';

class KelolaProduk extends StatefulWidget {
  const KelolaProduk({super.key});

  @override
  State<KelolaProduk> createState() => KelolaProdukState();
}

class KelolaProdukState extends State<KelolaProduk> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.whiteColor,
          elevation: 0,
          leading: Icon(Icons.arrow_back_ios),
          centerTitle: true,
          title: Text(
            "Kelola Produk",
            style: CustomText.TextArvo(16, CustomColors.secondaryColor),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
                height: 50,
                margin: EdgeInsets.all(10),
                child: Card(
                    surfaceTintColor: CustomColors.whiteColor,
                    borderOnForeground: true,
                    color: CustomColors.whiteColor,
                    semanticContainer: true,
                    shape: Border.all(color: CustomColors.secondaryColor),
                    elevation: 10,
                    child: CustomWidget.KolomPencarian(() {}))),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 150,
                child: Card(
                  color: CustomColors.fourtyColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 1,
                      color: CustomColors.HintColor,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: CustomColors.blackColor,
                  elevation: 15,
                  surfaceTintColor: CustomColors.whiteColor,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Image.asset(
                            "assets/images/ic_tambahproduk.png",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "TAMBAH\nPRODUK",
                            style: CustomText.TextArvoBold(
                                22, CustomColors.whiteColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ]),
                ),
              ),
            ),
            List_Kelola_Produk()
          ]),
        ),
      ),
    );
  }
}
