import 'dart:async';

import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/Server.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/pageSebelumLogin/page_atur_ulang_sandi.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/otp_field.dart';
import 'package:baticraft/src/style.dart';

class page_kodeotp extends StatefulWidget {
  final String email;
  final EmailOTP myauth;
  page_kodeotp({super.key, required this.email, required this.myauth});

  @override
  State<page_kodeotp> createState() => page_kodeotpState();
}

class page_kodeotpState extends State<page_kodeotp> {
  bool isOtpFocused = false;
  String statusKeyboard = "tidak aktif";
  bool isKeyboardActive = false;
  bool isWrong = false;
  String errorText = "";
  Timer? _timer;
  int _waitTime = 30; // Waktu tunggu awal dalam detik
  int _remainingTime = 30;
  bool _isButtonEnabled = false;
  void _startTimer() {
    setState(() {
      _isButtonEnabled = false;
      _remainingTime = _waitTime;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _isButtonEnabled = true;
          _timer?.cancel();
        }
      });
    });
  }

  EmailOTP myauth = EmailOTP();
  Future SendOtp() async {
    myauth.setConfig(
        appEmail: "dappganzzshop@gmail.com",
        userEmail: widget.email,
        appName: "Baticraft",
        otpLength: 5,
        otpType: OTPType.digitsOnly);

    if (await myauth.sendOTP() == true) {
      print("BERHASIL");
      Navigator.pop(context); // Close loading dialog
    } else {
      Navigator.pop(context); // Close loading dialog

      CustomWidget.NotifGagal(context);
      print("GAGAL");

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Oops, OTP send failed"),
      ));
    }
  }

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
                Text("Sedang Mengirim Ulang Otp..."),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onButtonPressed() {
    // Logika untuk mengirim ulang kode OTP
    showLoadingDialog(context);
    SendOtp();

    // Atur waktu tunggu untuk klik berikutnya
    _waitTime = _waitTime == 30 ? 60 : 60;
    _startTimer();
  }

  @override
  void initState() {
    print(widget.email);
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String otp = "";
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
                          CustomText.TextArvoBold(30, CustomColors.whiteColor),
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
                                            20, CustomColors.blackColor),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 10),
                                      child: Text(
                                        "Silahkan masukkan kode OTP\nyang dikirim melalui email anda",
                                        style: CustomText.TextArvo(
                                            16, CustomColors.blackColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (isKeyboardActive) {
                                          // Jika keyboard aktif
                                          _keyboardActiveFunction();
                                        } else {
                                          // Jika keyboard tidak aktif
                                          _keyboardInactiveFunction();
                                        }
                                        setState(() {
                                          isOtpFocused = true;
                                          isWrong = false;
                                          statusKeyboard = "aktif";
                                          isOtpFocused = true;
                                        });
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: OTPTextField(
                                          length: 5,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          fieldWidth: 50,
                                          style: TextStyle(fontSize: 17),
                                          textFieldAlignment:
                                              MainAxisAlignment.spaceAround,
                                          fieldStyle: FieldStyle.underline,
                                          onCompleted: (value) {
                                            setState(() {
                                              otp = value;
                                            });
                                          },
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
                                              "Konfirmasi",
                                              style: CustomText.TextArvoBold(
                                                  18, CustomColors.whiteColor),
                                            ),
                                            onPressed: () async {
                                              if (await widget.myauth
                                                      .verifyOTP(otp: otp) ||
                                                  myauth.verifyOTP(otp: otp) ==
                                                      true) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content:
                                                      Text("OTP is verified"),
                                                ));
                                                Navigator.push(
                                                    context,
                                                    PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          page_atur_ulang_sandi(
                                                              email:
                                                                  widget.email),
                                                    ));
                                                print("OTP BENAR");
                                              } else {
                                                print(otp);
                                                CustomWidget.NotifGagal(
                                                    context);
                                                print("OTP SALAH");
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content: Text("Invalid OTP"),
                                                ));
                                              }
                                            },
                                          ),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        onPressed: _isButtonEnabled
                                            ? _onButtonPressed
                                            : null,
                                        child: Text(
                                          _isButtonEnabled
                                              ? 'Kirim Ulang Kode OTP'
                                              : 'Kirim ulang setelah $_remainingTime detik',
                                          style: CustomText.TextArvoBold(
                                              16,
                                              _isButtonEnabled
                                                  ? CustomColors.blackColor
                                                  : CustomColors.redColor),
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

  void _keyboardActiveFunction() {
    print('Keyboard aktif');
  }

  void _keyboardInactiveFunction() {
    print('Keyboard tidak aktif');
  }
}
