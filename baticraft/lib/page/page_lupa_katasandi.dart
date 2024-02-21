import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/page/page_kodeotp.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';

class page_lupa_katasandi extends StatefulWidget {
  const page_lupa_katasandi({super.key});

  @override
  State<page_lupa_katasandi> createState() => _page_lupa_katasandiState();
}

class _page_lupa_katasandiState extends State<page_lupa_katasandi> {
  FocusNode emailFocusNode = FocusNode();

  bool isEmailFocused = false;
  String statusKeyboard = "tidak aktif";
  bool isKeyboardActive = false;
  bool isWrong = false;
    String errorText = "";


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
                          CustomText.TextArvoBold(40, CustomColors.whiteColor),
                    ),
                  ),
                   Align(
                                alignment: Alignment.center,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(30, 20, 30, 10),
                                  child: Visibility(
                                    visible: isWrong,
                                    child: Text(errorText,
                                        textAlign: TextAlign.center,
                                        style: CustomText.TextArvoBold(
                                            16, CustomColors.redColor)),
                                  ),
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
                                            32, CustomColors.blackColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(5, 45, 5, 0),
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
                                        focusNode: emailFocusNode,
                                        onTap: () {
                                          setState(() {
                                            statusKeyboard = "aktif";
                                            emailFocusNode.requestFocus();
                                            isEmailFocused = true;
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
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        page_kodeotp(),
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
}
