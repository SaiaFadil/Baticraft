import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/Server.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/pageSebelumLogin/page_kodeotp.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class page_lupa_katasandi extends StatefulWidget {
  const page_lupa_katasandi({super.key});

  @override
  State<page_lupa_katasandi> createState() => _page_lupa_katasandiState();
}

class _page_lupa_katasandiState extends State<page_lupa_katasandi> {
  FocusNode emailFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();

  bool isEmailFocused = false;
  String statusKeyboard = "tidak aktif";
  bool isKeyboardActive = false;
  bool isWrong = false;
  String errorText = "";
  String message = '';

  EmailOTP myauth = EmailOTP();

  Future<void> showLoadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text("Sedang Mengirim Otp..."),
              ],
            ),
          ),
        );
      },
    );
  }

  Future SendOtp() async {
    myauth.setConfig(
        appEmail: "dappganzzshop@gmail.com",
        userEmail: emailController.text,
        appName: "Baticraft",
        otpLength: 5,
        otpType: OTPType.digitsOnly);

    if (await myauth.sendOTP() == true) {
      print("BERHASIL");
      Navigator.pop(context); // Close loading dialog

      Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                page_kodeotp(email: emailController.text, myauth: myauth),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ));
    } else {
      Navigator.pop(context); // Close loading dialog

      CustomWidget.NotifGagal(context);
      print("GAGAL");

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Oops, OTP send failed"),
      ));
    }
  }

  Future<void> checkEmail(String email) async {
    showLoadingDialog(context);
    final response = await http.post(
      Server.urlLaravel('checkEmail'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );
    message = "";
    if (response.statusCode == 200) {
      print("Email : " + emailController.text);
      SendOtp();
    } else if (response.statusCode == 404) {
      Navigator.pop(context); // Close loading dialog
      setState(() {
        isWrong = true;
        message = 'Email belum terdaftar';
        errorText = "Email Belum Terdaftar!";
      });
    } else {
      Navigator.pop(context); // Close loading dialog
      setState(() {
        isWrong = true;
        message = 'Gagal memeriksa email';
      });
    }
    print(message);
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
          isEmailFocused = false;
        });
        isWrong = false;
        FocusScope.of(context).unfocus();

        return true;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: CustomColors.secondaryColor,
          body: GestureDetector(
            onTap: () {
              if (isKeyboardActive) {
                // Jika keyboard aktif
                _keyboardActiveFunction();
              } else {
                // Jika keyboard tidak aktif
                _keyboardInactiveFunction();
              }
              setState(() {
                isWrong = false;
                statusKeyboard = "tidak aktif";
                isEmailFocused = false;
                FocusScope.of(context).unfocus();
              });
            },
            child: SafeArea(
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30, top: 40),
                    child: Text(
                      "Lupa\nKata\nSandi?",
                      style:
                          CustomText.TextArvoBold(30, CustomColors.whiteColor),
                    ),
                  ),
                  Positioned(
                      bottom: -5,
                      left: -5,
                      right: -5,
                      child: Container(
                        height: 450,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          color: CustomColors.whiteColor,
                          child: Container(
                            margin: EdgeInsets.only(top: 15),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(27, 0, 27, 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 60),
                                      child: Text(
                                        "Silahkan atur ulang\nkata sandi anda !",
                                        style: CustomText.TextArvo(
                                            22, CustomColors.blackColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Visibility(
                                      visible: isWrong,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Text(
                                          errorText,
                                          style: CustomText.TextArvoBold(
                                              14, CustomColors.redColor),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(5, 25, 5, 0),
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
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'[0-9a-z@.A-Z]')),
                                        ],
                                        controller: emailController,
                                        focusNode: emailFocusNode,
                                        onTap: () {
                                          if (isKeyboardActive) {
                                            // Jika keyboard aktif
                                            _keyboardActiveFunction();
                                          } else {
                                            // Jika keyboard tidak aktif
                                            _keyboardInactiveFunction();
                                          }
                                          setState(() {
                                            isWrong = false;
                                            statusKeyboard = "aktif";
                                            isEmailFocused = true;
                                            emailFocusNode.requestFocus();
                                          });
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
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
                                              "Lanjut",
                                              style: CustomText.TextArvoBold(
                                                  20, CustomColors.whiteColor),
                                            ),
                                            onPressed: () {
                                              print("PRESSED");
                                              if (emailController.text
                                                      .endsWith("@gmail.com") &&
                                                  emailController
                                                      .text.isNotEmpty) {
                                                checkEmail(
                                                    emailController.text);
                                                print("eksekusi");
                                              } else {
                                                setState(() {
                                                  isWrong = true;
                                                  errorText =
                                                      "Email Tidak Valid!";
                                                });
                                                FocusScope.of(context)
                                                    .requestFocus(
                                                        emailFocusNode);
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
                      )),
                  AnimatedPositioned(
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.bounceOut,
                      top: (isEmailFocused) && statusKeyboard == "Aktif"
                          ? -190
                          : 90,
                      right: 20,
                      child: Image.asset(
                        Server.urlGambar("anim8.png"),
                        height: 350,
                      )),
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
}
