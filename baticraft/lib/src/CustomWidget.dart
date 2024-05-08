import 'package:baticraft/menu/SubMenuHome/subMenuInformasiToko/page_informasi_toko.dart';
import 'package:baticraft/navigation/utama.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';

class CustomWidget {
  static InkWell KolomPencarian(OnTap) {
    return InkWell(
        onTap: OnTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Cari",
                    style: CustomText.TextArvo(20, CustomColors.secondaryColor),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.search,
                    color: CustomColors.secondaryColor,
                    size: 35,
                  )),
            )
          ],
        ));
  }

  static Widget cardhome() {
    return Stack(
      fit: StackFit.loose,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 140, 20, 0),
          child: Card(
            surfaceTintColor: CustomColors.whiteColor,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Pendapatan Hari Ini',
                      style:
                          CustomText.TextArvoBold(16, CustomColors.blackColor),
                    ),
                  ),
                  subtitle: Text(
                    'RP 2.430.000',
                    style: CustomText.TextArvoBoldItalic(
                        25, CustomColors.blackColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Card(
                          color: CustomColors.secondaryColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Produk Terjual Hari Ini",
                                        style: CustomText.TextArvo(
                                            14, CustomColors.whiteColor)),
                                    Row(
                                      children: [
                                        Text("23",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style:
                                                CustomText.TextArvoBoldItalic(
                                                    30,
                                                    CustomColors.whiteColor)),
                                        SizedBox(width: 5),
                                        Text("pcs",
                                            style: CustomText.TextArvo(
                                                25, CustomColors.whiteColor)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Card(
                          color: CustomColors.secondaryColor,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Pembeli Hari Ini",
                                        style: CustomText.TextArvo(
                                            14, CustomColors.whiteColor)),
                                    Row(
                                      children: [
                                        Text("243",
                                            style:
                                                CustomText.TextArvoBoldItalic(
                                                    30,
                                                    CustomColors.whiteColor)),
                                        SizedBox(width: 5),
                                        Text("orang  ",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomText.TextArvo(
                                                25, CustomColors.whiteColor)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 100,
          right: 50,
          child: Image.asset(Server.urlGambar("koinhome.png")),
        )
      ],
    );
  }

  static void NotifBerhasilLogin(BuildContext context, Widget nextPage) {
    showDialog(
      context: context,

      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) => Stack(
        children: <Widget>[
          // Transparent background with a slight dimming effect
          ModalBarrier(color: Colors.black.withOpacity(0.3)),
          Center(
            child: Container(
              width: 300.0, // Adjust width as needed
              height: 200.0, // Adjust height as needed
              decoration: BoxDecoration(
                color: CustomColors.secondaryColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Animated checkmark
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: AlwaysStoppedAnimation(1),
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 60.0,
                      color: CustomColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Login success text
                  Text(
                    "Login Berhasil!",
                    style: CustomText.TextArvoBold(20, CustomColors.whiteColor),
                  ),
                  SizedBox(height: 20.0),
                  // "OK" button with navigation
                  // ElevatedButton(
                  //   onPressed: () => Navigator.pop(context), // Dismiss dialog
                  //   child: Text(
                  //     "Ok",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16.0,
                  //     ),
                  //   ),
                  //   style: CustomButton.DefaultButton(CustomColors.primaryColor)
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).then((_) => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => nextPage))); // Navigate after dismissal
  }

  static void NotifBerhasilEditInformasi(
      BuildContext context, Widget nextPage) {
    showDialog(
      context: context,

      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) => Stack(
        children: <Widget>[
          // Transparent background with a slight dimming effect
          ModalBarrier(color: Colors.black.withOpacity(0.3)),
          Center(
            child: Container(
              width: 300.0, // Adjust width as needed
              height: 200.0, // Adjust height as needed
              decoration: BoxDecoration(
                color: CustomColors.secondaryColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Animated checkmark
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: AlwaysStoppedAnimation(1),
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 60.0,
                      color: CustomColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Login success text
                  Text(
                    "Berhasil Mengubah Informasi!",
                    style: CustomText.TextArvoBold(20, CustomColors.whiteColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  // "OK" button with navigation
                  // ElevatedButton(
                  //   onPressed: () => , // Dismiss dialog
                  //   child: Text(
                  //     "Ok",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16.0,
                  //     ),
                  //   ),
                  //   style: CustomButton.DefaultButton(CustomColors.primaryColor)
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).then((_) => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                InformasiToko(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }))); 
  }
  static void NotifGagalEditInformasi(
      BuildContext context) {
    showDialog(
      context: context,

      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) => Stack(
        children: <Widget>[
          // Transparent background with a slight dimming effect
          ModalBarrier(color: Colors.black.withOpacity(0.3)),
          Center(
            child: Container(
              width: 300.0, // Adjust width as needed
              height: 200.0, // Adjust height as needed
              decoration: BoxDecoration(
                color: CustomColors.redColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Animated checkmark
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: AlwaysStoppedAnimation(1),
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 60.0,
                      color: CustomColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Login success text
                  Text(
                    "Gagal Mengubah Informasi!",
                    style: CustomText.TextArvoBold(16, CustomColors.whiteColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  // "OK" button with navigation
                  // ElevatedButton(
                  //   onPressed: () => , // Dismiss dialog
                  //   child: Text(
                  //     "Ok",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16.0,
                  //     ),
                  //   ),
                  //   style: CustomButton.DefaultButton(CustomColors.primaryColor)
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ); 
  }
  static void NotifBerhasilEditProfil(
      BuildContext context) {
    showDialog(
      context: context,

      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) => Stack(
        children: <Widget>[
          // Transparent background with a slight dimming effect
          ModalBarrier(color: Colors.black.withOpacity(0.3)),
          Center(
            child: Container(
              width: 300.0, // Adjust width as needed
              height: 200.0, // Adjust height as needed
              decoration: BoxDecoration(
                color: CustomColors.secondaryColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Animated checkmark
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: AlwaysStoppedAnimation(1),
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 60.0,
                      color: CustomColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Login success text
                  Text(
                    "Berhasil Mengubah Profil!",
                    style: CustomText.TextArvoBold(20, CustomColors.whiteColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  // "OK" button with navigation
                  // ElevatedButton(
                  //   onPressed: () => , // Dismiss dialog
                  //   child: Text(
                  //     "Ok",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16.0,
                  //     ),
                  //   ),
                  //   style: CustomButton.DefaultButton(CustomColors.primaryColor)
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).then((_) => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                utama(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }))); 
  }
  static void NotifBerhasilEditPassword(
      BuildContext context) {
    showDialog(
      context: context,

      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) => Stack(
        children: <Widget>[
          // Transparent background with a slight dimming effect
          ModalBarrier(color: Colors.black.withOpacity(0.3)),
          Center(
            child: Container(
              width: 300.0, // Adjust width as needed
              height: 200.0, // Adjust height as needed
              decoration: BoxDecoration(
                color: CustomColors.secondaryColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Animated checkmark
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: AlwaysStoppedAnimation(1),
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 60.0,
                      color: CustomColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Login success text
                  Text(
                    "Berhasil Ganti\nKata Sandi!",
                    style: CustomText.TextArvoBold(20, CustomColors.whiteColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  // "OK" button with navigation
                  // ElevatedButton(
                  //   onPressed: () => , // Dismiss dialog
                  //   child: Text(
                  //     "Ok",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16.0,
                  //     ),
                  //   ),
                  //   style: CustomButton.DefaultButton(CustomColors.primaryColor)
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).then((_) => Navigator.pop(context)); 
  }
  static void NotifGagalEditPassword(
      BuildContext context) {
    showDialog(
      context: context,

      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) => Stack(
        children: <Widget>[
          // Transparent background with a slight dimming effect
          ModalBarrier(color: Colors.black.withOpacity(0.3)),
          Center(
            child: Container(
              width: 300.0, // Adjust width as needed
              height: 200.0, // Adjust height as needed
              decoration: BoxDecoration(
                color: CustomColors.redColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Animated checkmark
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: AlwaysStoppedAnimation(1),
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 60.0,
                      color: CustomColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Login success text
                  Text(
                    "Konfirmasi Kata Sandi\nHarus Sesuai Dengan\nKata Sandi Baru!",
                    style: CustomText.TextArvoBold(16, CustomColors.whiteColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  static void NotifGagalBayar(
      BuildContext context) {
    showDialog(
      context: context,

      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) => Stack(
        children: <Widget>[
          // Transparent background with a slight dimming effect
          ModalBarrier(color: Colors.black.withOpacity(0.3)),
          Center(
            child: Container(
              width: 300.0, // Adjust width as needed
              height: 200.0, // Adjust height as needed
              decoration: BoxDecoration(
                color: CustomColors.redColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Animated checkmark
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: AlwaysStoppedAnimation(1),
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 60.0,
                      color: CustomColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Login success text
                  Text(
                    "PEMBAYARAN TIDAK MENCUKUPI!",
                    style: CustomText.TextArvoBold(15, CustomColors.whiteColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  static void NotifGagalEditPassword2(
      BuildContext context) {
    showDialog(
      context: context,

      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) => Stack(
        children: <Widget>[
          // Transparent background with a slight dimming effect
          ModalBarrier(color: Colors.black.withOpacity(0.3)),
          Center(
            child: Container(
              width: 300.0, // Adjust width as needed
              height: 200.0, // Adjust height as needed
              decoration: BoxDecoration(
                color: CustomColors.redColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Animated checkmark
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: AlwaysStoppedAnimation(1),
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 60.0,
                      color: CustomColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Login success text
                  Text(
                    "Kata Sandi Lama\nTidak Cocok!",
                    style: CustomText.TextArvoBold(16, CustomColors.whiteColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static void KolomKosong(
      BuildContext context) {
    showDialog(
      context: context,

      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) => Stack(
        children: <Widget>[
          // Transparent background with a slight dimming effect
          ModalBarrier(color: Colors.black.withOpacity(0.3)),
          Center(
            child: Container(
              width: 300.0, // Adjust width as needed
              height: 200.0, // Adjust height as needed
              decoration: BoxDecoration(
                color: CustomColors.redColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: AlwaysStoppedAnimation(1),
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 60.0,
                      color: CustomColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Login success text
                  Text(
                    "Isi Semua Kolom!",
                    style: CustomText.TextArvoBold(20, CustomColors.whiteColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


 static void NotifBerhasilTtransaaksi(
      BuildContext context) {
    showDialog(
      context: context,

      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) => Stack(
        children: <Widget>[
          // Transparent background with a slight dimming effect
          ModalBarrier(color: Colors.black.withOpacity(0.3)),
          Center(
            child: Container(
              width: 300.0, // Adjust width as needed
              height: 200.0, // Adjust height as needed
              decoration: BoxDecoration(
                color: CustomColors.secondaryColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Animated checkmark
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: AlwaysStoppedAnimation(1),
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 60.0,
                      color: CustomColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Login success text
                  Text(
                    "Transaksi Berhasil!",
                    style: CustomText.TextArvoBold(20, CustomColors.whiteColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  // "OK" button with navigation
                  // ElevatedButton(
                  //   onPressed: () => , // Dismiss dialog
                  //   child: Text(
                  //     "Ok",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16.0,
                  //     ),
                  //   ),
                  //   style: CustomButton.DefaultButton(CustomColors.primaryColor)
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ); 
  }

 static void NotifBerhasilTambahProduk(
      BuildContext context, Widget nextPage) {
    showDialog(
      context: context,

      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) => Stack(
        children: <Widget>[
          // Transparent background with a slight dimming effect
          ModalBarrier(color: Colors.black.withOpacity(0.3)),
          Center(
            child: Container(
              width: 300.0, // Adjust width as needed
              height: 200.0, // Adjust height as needed
              decoration: BoxDecoration(
                color: CustomColors.secondaryColor,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Animated checkmark
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: AlwaysStoppedAnimation(1),
                        curve: Curves.easeInOut,
                      ),
                    ),
                    child: Icon(
                      Icons.check,
                      size: 60.0,
                      color: CustomColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Login success text
                  Text(
                    "Berhasil Ditambahkan!",
                    style: CustomText.TextArvoBold(20, CustomColors.whiteColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  // "OK" button with navigation
                  // ElevatedButton(
                  //   onPressed: () => , // Dismiss dialog
                  //   child: Text(
                  //     "Ok",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontSize: 16.0,
                  //     ),
                  //   ),
                  //   style: CustomButton.DefaultButton(CustomColors.primaryColor)
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ).then((_) => Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                nextPage,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }))); 
  }


}
