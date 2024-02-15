import 'package:flutter/material.dart';
import 'package:baticraft/page/page_login.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'dart:async';

class page_registrasi extends StatefulWidget {
  const page_registrasi({super.key});

  @override
  State<page_registrasi> createState() => _page_registrasiState();
}

class _page_registrasiState extends State<page_registrasi> {
  bool isObscured = true;
  bool konfisObscured = true;

  bool isNameFocused = false;
  bool isNoFocused = false;
  bool isEmailFocused = false;
  bool isPassFocused = false;
  bool isKonfPassFocused = false;

  FocusNode nameFocusNode = FocusNode();
  FocusNode noFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passFocusNode = FocusNode();
  FocusNode konfpassFocusNode = FocusNode();

  bool _isBackPressed = false;

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    nameFocusNode.dispose();
    noFocusNode.dispose();
    emailFocusNode.dispose();
    passFocusNode.dispose();
    konfpassFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isBackPressed) {
          return false;
        } else {
          setState(() {
            isNameFocused = false;
            isNoFocused = false;
            isEmailFocused = false;
            isPassFocused = false;
            isKonfPassFocused = false;
            FocusScope.of(context).unfocus();
          });

          _isBackPressed = true;
          Future.delayed(Duration(seconds: 1), () {
            _isBackPressed = false;
          });
          return false;
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: CustomColors.secondaryColor,
          body:  Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(5),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                        elevation: 100,
                        color: CustomColors.whiteColor,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 30),
                                child: Text(
                                  "Daftarkan Akun Anda",
                                  style: CustomText.TextArvoBold(
                                      24, CustomColors.blackColor),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Silahkan lengkapi data berikut",
                                  style: CustomText.TextArvo(
                                      16, CustomColors.blackColor),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(35, 35, 35, 10),
                                child: Column(children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Nama Lengkap",
                                        style: CustomText.TextArvoBold(
                                            20, CustomColors.blackColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: TextField(
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: "Masukkan Nama Anda",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            color: CustomColors
                                                .primaryColor, // Warna border saat aktif
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            color: CustomColors
                                                .blackColor, // Warna border saat tidak aktif
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                        hintStyle: CustomText.TextArvo(
                                            14, CustomColors.HintColor),
                                      ),
                                      style: CustomText.TextArvo(
                                        16,
                                        CustomColors.blackColor,
                                      ),
                                      focusNode: nameFocusNode,
                                      onTap: () {
                                        setState(() {
                                          nameFocusNode.requestFocus();
                                          isNameFocused = true;
                                          isNoFocused = false;
                                          isEmailFocused = false;
                                          isPassFocused = false;
                                          isKonfPassFocused = false;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "No Handphone",
                                        style: CustomText.TextArvoBold(
                                            20, CustomColors.blackColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: TextField(
                                      keyboardType: TextInputType.phone,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: "+62",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            color: CustomColors
                                                .primaryColor, // Warna border saat aktif
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            color: CustomColors
                                                .blackColor, // Warna border saat tidak aktif
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                        hintStyle: CustomText.TextArvo(
                                            14, CustomColors.HintColor),
                                      ),
                                      style: CustomText.TextArvo(
                                        16,
                                        CustomColors.blackColor,
                                      ),
                                      focusNode: noFocusNode,
                                      onTap: () {
                                        setState(() {
                                          noFocusNode.requestFocus();
                                          isNameFocused = false;
                                          isNoFocused = true;
                                          isEmailFocused = false;
                                          isPassFocused = false;
                                          isKonfPassFocused = false;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Email",
                                        style: CustomText.TextArvoBold(
                                            20, CustomColors.blackColor),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      decoration: InputDecoration(
                                        hintText: "Masukkan Email Anda",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            color: CustomColors
                                                .primaryColor, // Warna border saat aktif
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            color: CustomColors
                                                .blackColor, // Warna border saat tidak aktif
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                        hintStyle: CustomText.TextArvo(
                                            14, CustomColors.HintColor),
                                      ),
                                      style: CustomText.TextArvo(
                                        16,
                                        CustomColors.blackColor,
                                      ),
                                      focusNode: emailFocusNode,
                                      onTap: () {
                                        setState(() {
                                          emailFocusNode.requestFocus();
                                          isNameFocused = false;
                                          isNoFocused = false;
                                          isEmailFocused = true;
                                          isPassFocused = false;
                                          isKonfPassFocused = false;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Kata Sandi',
                                          textAlign: TextAlign.left,
                                          style: CustomText.TextArvoBold(
                                              20, CustomColors.blackColor)),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: TextField(
                                      keyboardType: TextInputType.visiblePassword,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
                                      obscureText: isObscured,
                                      decoration: InputDecoration(
                                        hintText: "Masukkan Kata Sandi Anda",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            color: CustomColors
                                                .primaryColor, // Warna border saat aktif
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            color: CustomColors
                                                .blackColor, // Warna border saat tidak aktif
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                        hintStyle: CustomText.TextArvo(
                                            14, CustomColors.HintColor),
                                        suffixIcon: IconButton(
                                          alignment: Alignment.center,
                                          onPressed: () {
                                            setState(() {
                                              isObscured = !isObscured;
                                            });
                                          },
                                          icon: Icon(
                                            isObscured
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                          iconSize: 25,
                                        ),
                                      ),
                                      style: CustomText.TextArvo(
                                        16,
                                        CustomColors.blackColor,
                                      ),
                                      focusNode: passFocusNode,
                                      onTap: () {
                                        setState(() {
                                          passFocusNode.requestFocus();
                                          isNameFocused = false;
                                          isNoFocused = false;
                                          isEmailFocused = false;
                                          isPassFocused = true;
                                          isKonfPassFocused = false;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 15, 5, 0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Konfirmasi Kata Sandi',
                                          textAlign: TextAlign.left,
                                          style: CustomText.TextArvoBold(
                                              20, CustomColors.blackColor)),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: TextField(
                                      keyboardType: TextInputType.visiblePassword,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.done,
                                      obscureText: konfisObscured,
                                      decoration: InputDecoration(
                                        hintText:
                                            "Masukkan Ulang Kata Sandi Anda",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            color: CustomColors
                                                .primaryColor, // Warna border saat aktif
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                            color: CustomColors
                                                .blackColor, // Warna border saat tidak aktif
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10.0),
                                        hintStyle: CustomText.TextArvo(
                                            14, CustomColors.HintColor),
                                        suffixIcon: IconButton(
                                          alignment: Alignment.center,
                                          onPressed: () {
                                            setState(() {
                                              konfisObscured = !konfisObscured;
                                            });
                                          },
                                          icon: Icon(
                                            konfisObscured
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: Colors.grey,
                                          ),
                                          iconSize: 25,
                                        ),
                                      ),
                                      style: CustomText.TextArvo(
                                        16,
                                        CustomColors.blackColor,
                                      ),
                                      focusNode: konfpassFocusNode,
                                      onTap: () {
                                        setState(() {
                                          konfpassFocusNode.requestFocus();
                                          isNameFocused = false;
                                          isNoFocused = false;
                                          isEmailFocused = false;
                                          isPassFocused = false;
                                          isKonfPassFocused = true;
                                        });
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(20, 30, 20, 5),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: ElevatedButton(
                                        style: CustomButton.DefaultButton(
                                            CustomColors.primaryColor),
                                        child: Text(
                                          "Daftar",
                                          style: CustomText.TextArvoBold(
                                              20, CustomColors.whiteColor),
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.zero,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text('Sudah Punya Akun?',
                                              style: CustomText.TextArvo(
                                                  16, CustomColors.blackColor)),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        page_login(),
                                                    transitionsBuilder: (context,
                                                        animation,
                                                        secondaryAnimation,
                                                        child) {
                                                      return FadeTransition(
                                                        opacity: animation,
                                                        child: child,
                                                      );
                                                    },
                                                  ));
                                            },
                                            child: Text("Masuk Disini",
                                                style: CustomText.TextArvoBold(
                                                    16, CustomColors.redColor)),
                                          ),
                                        ],
                                      )),
                                ]),
                              )
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
