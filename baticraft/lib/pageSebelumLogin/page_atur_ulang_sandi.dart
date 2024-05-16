import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/pageSebelumLogin/page_login.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class page_atur_ulang_sandi extends StatefulWidget {
  final String email;
  page_atur_ulang_sandi({super.key, required this.email});

  @override
  State<page_atur_ulang_sandi> createState() => _page_atur_ulang_sandiState();
}

class _page_atur_ulang_sandiState extends State<page_atur_ulang_sandi> {
  bool isObscured = true;
  bool konfisObscured = true;

  String errorText = "";
  bool isHovered = true;
  bool isKonfFocused = false;
  bool isPasswordFocused = false;
  bool isWrong = false;
  double sizeerror = 0;
  bool isKeyboardActive = false;
  String statusKeyboard = "tidak aktif";

  @override
  void initState() {
    setState(() {
      isWrong = false;
    });
    super.initState();
  }

  TextEditingController pw = TextEditingController();
  TextEditingController konfpw = TextEditingController();
  FocusNode KonfpasswordFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  @override
  void dispose() {
    KonfpasswordFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  Future sendDataToServer() async {
    final response = await http.post(
        Server.urlLaravel("updatePasswordLupaSandi"),
        body: {'email': widget.email, 'password_baru': pw.text});

    if (response.statusCode == 200) {
      Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                KonfirmasiAturUlang(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ));
    } else {
      CustomWidget.NotifGagal(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    isKeyboardActive = mediaQuery.viewInsets.bottom > 0;
    return WillPopScope(
      onWillPop: () async {
        print("tombol kembali di tekan");
        setState(() {
          statusKeyboard = "tidak aktif";
          isKonfFocused = false;
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
                statusKeyboard = "tidak aktif";
                isWrong = false;
                isKonfFocused = false;
                isPasswordFocused = false;
                FocusScope.of(context).unfocus();
              });
            },
            child: SafeArea(
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20, top: 20),
                    child: Text(
                      "Buat Sandi\nYang Mudah\nDiingat",
                      style:
                          CustomText.TextArvoBold(30, CustomColors.whiteColor),
                    ),
                  ),
                  Positioned(
                    bottom: -5,
                    left: -5,
                    right: -5,
                    child: Container(
                      height: 500,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        color: CustomColors.whiteColor,
                        child: Container(
                          margin: EdgeInsets.only(top: 30),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(top: 40),
                                    child: Text(
                                      "Atur Ulang Kata Sandi",
                                      style: CustomText.TextArvoBold(
                                          20, CustomColors.blackColor),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      "Silahkan masukkan kata sandi baru",
                                      style: CustomText.TextArvo(
                                          14, CustomColors.blackColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Visibility(
                                    visible: isWrong,
                                    child: Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        errorText,
                                        style: CustomText.TextArvoBold(
                                            14, CustomColors.redColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(5, 20, 5, 0),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text('Kata Sandi',
                                          textAlign: TextAlign.left,
                                          style: CustomText.TextArvoBold(
                                              18, CustomColors.blackColor)),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: TextField(
                                      controller: pw,
                                      keyboardType:
                                          TextInputType.visiblePassword,
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
                                      focusNode: passwordFocusNode,
                                      onTap: () {
                                        isWrong = false;
                                        setState(() {
                                          statusKeyboard = "aktif";
                                          passwordFocusNode.requestFocus();
                                          isPasswordFocused = true;
                                          isKonfFocused = false;
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
                                              18, CustomColors.blackColor)),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: TextField(
                                      controller: konfpw,
                                      focusNode: KonfpasswordFocusNode,
                                      onTap: () {
                                        isWrong = false;
                                        setState(() {
                                          statusKeyboard = "aktif";
                                          KonfpasswordFocusNode.requestFocus();
                                          isKonfFocused = true;
                                          isPasswordFocused = false;
                                        });
                                      },
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textAlign: TextAlign.start,
                                      textInputAction: TextInputAction.next,
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
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(top: 50),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: ElevatedButton(
                                          style: CustomButton.DefaultButton(
                                              CustomColors.secondaryColor),
                                          child: Text(
                                            "Ubah",
                                            style: CustomText.TextArvoBold(
                                                25, CustomColors.whiteColor),
                                          ),
                                          onPressed: () {
                                            if (pw.text.isEmpty ||
                                                konfpw.text.isEmpty) {
                                              CustomWidget.KolomKosong(context);
                                            } else if (pw.text.length < 8 ||
                                                konfpw.text.length < 8) {
                                              setState(() {
                                                isWrong = true;
                                                errorText =
                                                    "Kata Sandi Minimal 8";
                                                print("minimal " + errorText);
                                                print("minimal " +
                                                    isWrong.toString());
                                              });
                                            } else if (pw.text.length > 20 ||
                                                konfpw.text.length > 20) {
                                              setState(() {
                                                isWrong = true;
                                                errorText =
                                                    "Kata Sandi Maksimal 15";
                                                print("maksimal " + errorText);
                                              });
                                            } else if (pw.text != konfpw.text) {
                                              setState(() {
                                                isWrong = true;
                                                errorText =
                                                    "Konfirmasi Password Tidak Cocok!";
                                                print("maksimal " + errorText);
                                              });
                                            } else {
                                              sendDataToServer();
                                            }
                                          },
                                        ),
                                      )),
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
                    ),
                  ),
                  AnimatedPositioned(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.bounceOut,
                      top: (isKonfFocused && isPasswordFocused) ||
                              statusKeyboard == "Aktif"
                          ? -220
                          : 60,
                      right: 5,
                      child: Image.asset(Server.urlGambar('anim10.png'))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KonfirmasiAturUlang extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: CustomColors.secondaryColor,
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 30, top: 40),
                child: Text(
                  "YEY\nBERHASIL !",
                  style: CustomText.TextArvoBold(30, CustomColors.whiteColor),
                ),
              ),
              Positioned(
                  bottom: -5,
                  left: -5,
                  right: -5,
                  child: Container(
                    height: 390,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40))),
                      color: CustomColors.whiteColor,
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.only(top: 30),
                                child: Text(
                                  "Berhasil !!",
                                  style: CustomText.TextArvoBold(
                                      20, CustomColors.blackColor),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Kata sandi anda berhasil di ubah\nSilahkan masuk ke akun anda",
                                  style: CustomText.TextArvo(
                                      18, CustomColors.blackColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(top: 10),
                                child: Text(
                                  "Kata sandi anda berhasil di ubah\nSilahkan masuk ke akun anda",
                                  style: CustomText.TextArvo(
                                      18, CustomColors.blackColor),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 60),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: ElevatedButton(
                                      style: CustomButton.DefaultButton(
                                          CustomColors.secondaryColor),
                                      child: Text(
                                        "Halaman Login",
                                        style: CustomText.TextArvoBold(
                                            18, CustomColors.whiteColor),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  page_login(),
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
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
              Positioned(
                top: screenHeight * .135,
                right: 10,
                child: Image.asset(Server.urlGambar("anim11.png")),
                height: 350,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
