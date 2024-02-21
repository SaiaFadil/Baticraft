import 'package:baticraft/page/page_lupa_katasandi.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/navigation/utama.dart';
import 'package:flutter/services.dart';

import 'dart:async';

import 'dart:convert';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

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
        errorText = "Masukkan Email dan Password\ndengan benar!";
      });
    } else {
      if (emailController.text == email &&
          passwordController.text == password) {
        Navigator.push(
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
                }));
      } else {
        setState(() {
          isWrong = true;
          errorText = "Email atau Password Salah!";
          sizeerror = 18;
        });
      }
    }
  }

  String errorText = "";
  bool isObscured = true;
  bool isHovered = true;
  bool isEmailFocused = false;
  bool isPasswordFocused = false;
  bool isWrong = false;
  double sizeerror = 0;
  bool isKeyboardActive = false;
  String statusKeyboard = "tidak aktif";
  @override
  void initState() {
    super.initState();

    RawKeyboard.instance.addListener(_handleKeyEvent);
  }

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    RawKeyboard.instance.removeListener(_handleKeyEvent);

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    isKeyboardActive = mediaQuery.viewInsets.bottom > 0;
    return WillPopScope(
      onWillPop: () async {
        print("tombol kembali di tekan");
        setState(() {
          if (isKeyboardActive) {
            // Jika keyboard aktif
            _keyboardActiveFunction();
          } else {
            // Jika keyboard tidak aktif
            _keyboardInactiveFunction();
          }
          statusKeyboard = "tidak aktif";
          isEmailFocused = false;
          isPasswordFocused = false;
        });
        isWrong = false;
        FocusScope.of(context).unfocus();

        return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: CustomColors.secondaryColor,
          body: GestureDetector(
            onTap: () {
              setState(() {
                if (isKeyboardActive) {
                  // Jika keyboard aktif
                  _keyboardActiveFunction();
                } else {
                  // Jika keyboard tidak aktif
                  _keyboardInactiveFunction();
                }
                statusKeyboard = "tidak aktif";
                isWrong = false;
                isEmailFocused = false;
                isPasswordFocused = false;
                FocusScope.of(context).unfocus();
              });
            },
            child: SafeArea(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: 20,
                    left: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Halo..",
                          style: CustomText.TextArvoBold(
                              50, CustomColors.whiteColor),
                        ),
                        Text(
                          "Selamat Datang",
                          style: CustomText.TextArvoBold(
                              25, CustomColors.whiteColor),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -3,
                    left: -3,
                    right: -3,
                    child: Container(
                      height: 440,
                      child: Card(
                        color: CustomColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30, 70, 30, 10),
                                  child: Visibility(
                                    visible: isWrong,
                                    child: Text(errorText,
                                        textAlign: TextAlign.center,
                                        style: CustomText.TextArvoBold(
                                            16, CustomColors.redColor)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
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
                                    if (isKeyboardActive) {
                                      // Jika keyboard aktif
                                      _keyboardActiveFunction();
                                    } else {
                                      // Jika keyboard tidak aktif
                                      _keyboardInactiveFunction();
                                    }
                                    isWrong = false;
                                    setState(() {
                                      statusKeyboard = "aktif";
                                      passwordFocusNode.requestFocus();
                                      isPasswordFocused = true;
                                      isEmailFocused = false;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: ((context, animation,
                                                    secondaryAnimation) =>
                                                page_lupa_katasandi()),
                                            transitionsBuilder: (context,
                                                animation,
                                                secondaryAnimation,
                                                child) {
                                              return FadeTransition(
                                                  opacity: animation,
                                                  child: child);
                                            },
                                          ));
                                    },
                                    child: Text("Lupa Kata Sandi",
                                        style: CustomText.TextArvoItalic(
                                            16, CustomColors.blackColor)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5, bottom: 20),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: ElevatedButton(
                                    style: CustomButton.DefaultButton(
                                        CustomColors.secondaryColor),
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
                                padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        height: 1,
                                        color: CustomColors.blackColor,
                                      ),
                                    ),
                                    Text('atau',
                                        style: CustomText.TextArvo(
                                            16, CustomColors.blackColor)),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        height: 1,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 10, 30, 25),
                                child: OutlinedButton(
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
                                        Server.urlGambar(
                                            'icons8-google-480.svg'),
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
                              ),
                              Text(
                                'Status Keyboard: ${isKeyboardActive ? statusKeyboard = 'Aktif' : statusKeyboard = "tidak aktif"}' +
                                    statusKeyboard,
                                style: TextStyle(
                                  fontSize: 0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedPositioned(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.bounceOut,
                      top: (isEmailFocused && isPasswordFocused) ||
                              statusKeyboard == "Aktif"
                          ? -190
                          : 90,
                      right: 20,
                      child: Image.asset(Server.urlGambar('anim12.png'))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _keyboardActiveFunction() {
    print('Keyboard aktif');
  }

  void _keyboardInactiveFunction() {
    print('Keyboard tidak aktif');
  }

  // Fungsi untuk menangani peristiwa keyboard
  void _handleKeyEvent(RawKeyEvent event) {
    if (event is RawKeyUpEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      // Memastikan bahwa peristiwa tombol kembali terjadi
      print('Tombol kembali ditekan');
      // Mengubah variabel boolean menjadi true
      setState(() {
        isKeyboardActive = true;
      });
    }
  }
}
