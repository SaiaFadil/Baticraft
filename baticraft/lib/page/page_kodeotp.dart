import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/page/page_atur_ulang_sandi.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';

class page_kodeotp extends StatefulWidget {
  const page_kodeotp({super.key});

  @override
  State<page_kodeotp> createState() => page_kodeotpState();
}

class page_kodeotpState extends State<page_kodeotp> {
  bool isOtpFocused = false;
  String statusKeyboard = "tidak aktif";
  bool isKeyboardActive = false;
  bool isWrong = false;
  String errorText = "";

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("tombol kembali di tekan");
        setState(() {
          statusKeyboard = "tidak aktif";
          isOtpFocused = false;
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
              setState(() {
                isWrong = false;
                statusKeyboard = "tidak aktif";
                isOtpFocused = false;
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
                      "Yuk Cek\nEmail\nDulu",
                      style:
                          CustomText.TextArvoBold(40, CustomColors.whiteColor),
                    ),
                  ),
                  Positioned(
                      bottom: -5,
                      left: -5,
                      right: -5,
                      child: Container(
                        height: 400,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40))),
                          color: CustomColors.whiteColor,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Container(
                                padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(top: 60),
                                      child: Text(
                                        "Kode OTP",
                                        style: CustomText.TextArvoBold(
                                            30, CustomColors.blackColor),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Silahkan masukkan kode OTP\nyang dikirim melalui email anda",
                                        style: CustomText.TextArvo(
                                            25, CustomColors.blackColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 120),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            style: CustomButton.DefaultButton(
                                                CustomColors.secondaryColor),
                                            child: Text(
                                              "Konfirmasi",
                                              style: CustomText.TextArvoBold(
                                                  25, CustomColors.whiteColor),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        page_atur_ulang_sandi(),
                                                    transitionsBuilder:
                                                        (context,
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
                      top: (isOtpFocused) && statusKeyboard == "Aktif"
                          ? -190
                          : 130,
                      right: 20,
                      child: Image.asset(
                        Server.urlGambar("anim9.png"),
                        height: 320,
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
