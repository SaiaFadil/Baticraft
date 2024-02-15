import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/navigation/utama.dart';
import 'package:baticraft/page/page_registrasi.dart';


import 'dart:async';

class page_login extends StatefulWidget {
  static String id_user = "";
  @override
  State<page_login> createState() => _page_login();
}

class _page_login extends State<page_login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future _ceklogin() async {
    String email = "fadil@gmail.com";
    String password = "gatau123";
if (emailController.text.isEmpty || passwordController.text.isEmpty) {
  setState(() {
    isWrong = true;
    sizeerror = 14;
    errorText = "isi Email dan Password dengan benar!";
  });
}else{
    if (emailController.text == email && passwordController.text == password) {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => utama(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              }));
    } else {
      setState(() {
        isWrong = true;
        errorText = "Email atau Password Salah!";
        sizeerror = 18;
      });
    }
  }}

  String errorText = "";
  bool isObscured = true;
  bool isHovered = true;
  bool isEmailFocused = false;
  bool isPasswordFocused = false;
  bool isWrong = false;
  double sizeerror = 0;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        isWrong = false;
        isEmailFocused = false;
        isPasswordFocused = false;
        FocusScope.of(context).unfocus();

        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: CustomColors.secondaryColor,
          body: GestureDetector(
            onTap: () {
              setState(() {
                isWrong = false;
                isEmailFocused = false;
                isPasswordFocused = false;
                FocusScope.of(context).unfocus();
              });
            },
            child: Center(
              child: Container(
                  margin: EdgeInsets.all(10),
                  height: 650,
                  child: Card(
                    elevation: 100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: Text('Masuk dan lakukan aktifitas',
                                      textAlign: TextAlign.center,
                                      style: CustomText.TextArvoBold(
                                          20, CustomColors.blackColor)),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text('BATICRAFT',
                                        maxLines: 1,
                                        textAlign: TextAlign.center,
                                        style: CustomText.TextArvoBold(
                                            25, CustomColors.blackColor)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(30, 40, 30, 0),
                              child: Visibility(
                                visible: isWrong,
                                child: Text(errorText,
                                    textAlign: TextAlign.center,
                                    style: CustomText.TextArvoBold(
                                        sizeerror, CustomColors.redColor)),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                            child: Text('Email',
                                textAlign: TextAlign.left,
                                style: CustomText.TextArvoBold(
                                    20, CustomColors.blackColor)),
                          ),
                          Container(
                            height: 55,
                            padding: EdgeInsets.fromLTRB(30, 5, 30, 10),
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              textAlign: TextAlign.start,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: "Masukkan Email Anda",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: CustomColors
                                        .primaryColor, // Warna border saat aktif
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                                isWrong = false;
                                setState(() {
                                  emailFocusNode.requestFocus();
                                  isEmailFocused = true;
                                  isPasswordFocused = false;
                                });
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Text('Kata Sandi',
                                textAlign: TextAlign.left,
                                style: CustomText.TextArvoBold(
                                    20, CustomColors.blackColor)),
                          ),
                          Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(30, 5, 30, 5),
                            child: TextField(
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              textAlign: TextAlign.start,
                              textInputAction: TextInputAction.next,
                              obscureText: isObscured,
                              decoration: InputDecoration(
                                hintText: "Masukkan Kata Sandi Anda",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: isPasswordFocused
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                    color: CustomColors
                                        .primaryColor, // Warna border saat aktif
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
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
                              focusNode: passwordFocusNode,
                              onTap: () {
                                isWrong = false;
                                setState(() {
                                  passwordFocusNode.requestFocus();
                                  isPasswordFocused = true;
                                  isEmailFocused = false;
                                });
                              },
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 30),
                          //   child: Align(
                          //     alignment: Alignment.centerRight,
                          //     child: TextButton(
                          //       onPressed: () {},
                          //       child: Text("Lupa Kata Sandi",
                          //           style: CustomText.TextArvoItalic(
                          //               16, CustomColors.blackColor)),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: EdgeInsets.only(top: 70),
                            child: Align(
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: CustomButton.DefaultButton(
                                    CustomColors.primaryColor),
                                onPressed: () {
                                  setState(() {
                                    _ceklogin();
                                  });
                                  print("Login presseedd");
                                },
                                child: Text("Masuk",
                                    style: CustomText.TextArvoBold(
                                        20, CustomColors.whiteColor)),
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('Belum Punya Akun?',
                                      style: CustomText.TextArvo(
                                          16, CustomColors.blackColor)),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation,
                                                    secondaryAnimation) =>
                                                page_registrasi(),
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
                                    child: Text("Daftar Disini",
                                        style: CustomText.TextArvoBold(
                                            16, CustomColors.redColor)),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    height: 1,
                                    color: CustomColors.blackColor,
                                  ),
                                ),
                                Text('atau',
                                    style: CustomText.TextArvo(
                                        16, CustomColors.blackColor)),
                                Expanded(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(30, 10, 30, 0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: CustomColors
                                    .whiteColor, // Warna latar belakang tombol
                                onPrimary:
                                    CustomColors.blackColor, // Warna teks
                                padding: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/icons8-google-480.svg',
                                    height: 24,
                                    width: 24,
                                  ),
                                  SizedBox(width: 12),
                                  Text(
                                    'Masuk dengan akun Google',
                                    style: CustomText.TextArvo(
                                        14, CustomColors.blackColor),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
