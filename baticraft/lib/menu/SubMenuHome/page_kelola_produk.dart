import 'package:baticraft/menu/SubMenuHome/page_tambah_produk.dart';
import 'package:baticraft/src/CustomButton.dart';
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
          elevation: 5,
          title: Text("Kelola Produk",
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(
                            color: CustomColors.secondaryColor, strokeAlign: 1)),
                    elevation: 10,
                    child: CustomWidget.KolomPencarian(() {}))),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 150,
                child: ElevatedButton(
                  onPressed: (){

 Navigator.pushReplacement(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  Tambah_Produk(),
                                              transitionsBuilder: (context,
                                                  animation,
                                                  secondaryAnimation,
                                                  child) {
                                                return FadeTransition(
                                                  opacity: animation,
                                                  child: child,
                                                );
                                              }));


                  },
                  style: CustomButton.DefaultButton(CustomColors.fourtyColor),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/images/ic_tambahproduk.png",
                          fit: BoxFit.contain,
                        ),
                        Text(
                          "TAMBAH\nPRODUK",
                          style: CustomText.TextArvoBold(
                              22, CustomColors.whiteColor),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 30,
                        ),
                      ]),
                ),
              ),
            ),
            SizedBox(height: 20,),
            List_Kelola_Produk()
          ]),
        ),
      ),
    );
  }
}
