import 'dart:convert';

import 'package:baticraft/pageSebelumLogin/page_lupa_katasandi.dart';
import 'package:baticraft/src/CustomWidget.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/navigation/utama.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
    try {
      CustomWidget.NotifLoading(context);
      final response = await http.post(Server.urlLaravel("LoginMobile"), body: {
        "email": emailController.text,
        "password": passwordController.text
      });
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        setState(() {
          Navigator.pop(context);
          isWrong = true;
          sizeerror = 14;
          errorText = "Masukkan Email dan Password\ndengan benar!";
        });
      } else {
        String jsonData = "[]";
        if (response.statusCode == 200) {
          jsonData = response.body.toString();
          if (jsonData != "[]") {
            Navigator.pop(context);
            Map<String, dynamic> detailUser = json.decode(response.body);
            print("JsonData = " + jsonData);
            isWrong = false;
            CustomWidget.NotifBerhasilLogin(context, utama());
            page_login.id_user = detailUser['id'].toString();
            print("id user = " + detailUser['id'].toString());
            print("id user = " + response.body);
          } else {
            Navigator.pop(context);
            setState(() {
              print("kesalahan");
              isWrong = true;
              errorText = "Email atau Password Salah!";
              sizeerror = 18;
              print("JsonData = " + jsonData);
            });
          }
        } else {
          print("Status code = " + response.statusCode.toString());
          print("Response = " + response.body.toString());
        }
      }
    } catch (e) {
      Navigator.pop(context);
      CustomWidget.NotifGagal(context);
      // Tangani kesalahan koneksi atau kesalahan lainnya
      print("Error: $e");
    }
  }

// Future<Map<String, dynamic>> checkEmail(String email) async { // Ganti dengan URL Anda

//   try {
//     final response = await http.post(
//       Server.url("loginGoogle.php"),
//       body: {'email': email},
//     );

//     if (response.statusCode == 200) {
//       final userData = json.decode(response.body);

//           page_login.id_user = userData['id'].toString();
//           print("id user = " + userData['id'].toString());
//           print("id user = " + response.body);
// CustomWidget.NotifBerhasilLogin(context, utama());
//       // Jika respons berhasil
//       return userData;

//     } else {
//       _googleSignIn.disconnect();
//       // Jika respons gagal
//       throw Exception('Gagal memeriksa email');
//     }
//   } catch (e) {
//     // Jika terjadi kesalahan
//     throw Exception('Error: $e');
//   }
// }

  // late GoogleSignIn _googleSignIn;
  // GoogleSignInAccount? currentUser;
  // List<String> scopes = <String>[
  //   'email',
  //   'https://www.googleapis.com/auth/contacts.readonly',
  // ];
  bool isAuthorized = false;
  String contactText = '';

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

        return true;
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
                              mediaQuery.textScaler.scale(30),
                              CustomColors.whiteColor),
                        ),
                        Text(
                          "Selamat Datang",
                          style: CustomText.TextArvoBold(
                              mediaQuery.textScaler.scale(22),
                              CustomColors.whiteColor),
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
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9@.a-zA-Z]')),
                                  ],
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
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
                                        print("Login presseedd");
                                        try {
                                          _ceklogin();
                                          print("press");
                                        } catch ($e) {
                                          CustomWidget.NotifGagal(context);
                                          print("ERRORRR " + $e.toString());
                                        }
                                      });
                                    },
                                    child: Text("Masuk",
                                        style: CustomText.TextArvoBold(
                                            20, CustomColors.whiteColor)),
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
                          ? -150
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

//   // Metode untuk menangani masuk dengan akun Google
//   Future<void> _handleSignIn() async {
//   try {
//     await _googleSignIn.signIn();
//     if (_googleSignIn.currentUser != null) {
//       String email = _googleSignIn.currentUser!.email;
//       print('Email yang dipilih: $email');
//       checkEmail(email);
//       // Lakukan sesuatu dengan email yang dipilih di sini
//       // Contoh: Kirim email ke server Anda untuk verifikasi atau tindakan lainnya
//     }
//     print('Fadil sedang memilih Akun....');
//   } catch (error) {
//     print('Error signing in with Google: $error');
//   }
// }

//   Future<void> _handleGetContact(GoogleSignInAccount user) async {
//     setState(() {
//       print("Email yang dipilih : " + user.email);
//       contactText = 'Loading contact info...';
//     });
//     final http.Response response = await http.get(
//       Uri.parse('https://people.googleapis.com/v1/people/me/connections'
//           '?requestMask.includeField=person.names'),
//       headers: await user.authHeaders,
//     );
//     if (response.statusCode != 200) {
//       setState(() {
//         contactText = 'People API gave a ${response.statusCode} '
//             'response. Check logs for details.';
//       });
//       // print('People API ${response.statusCode} response: ${response.body}');
//       return;
//     }
//     final Map<String, dynamic> data =
//         json.decode(response.body) as Map<String, dynamic>;
//     final String? namedContact = _pickFirstNamedContact(data);
//     setState(() {
//       if (namedContact != null) {
//         contactText = 'I see you know $namedContact!';
//       } else {
//         contactText = 'No contacts to display.';
//       }
//     });
//   }

  // String? _pickFirstNamedContact(Map<String, dynamic> data) {
  //   final List<dynamic>? connections = data['connections'] as List<dynamic>?;
  //   final Map<String, dynamic>? contact = connections?.firstWhere(
  //     (dynamic contact) => (contact as Map<Object?, dynamic>)['names'] != null,
  //     orElse: () => null,
  //   ) as Map<String, dynamic>?;
  //   if (contact != null) {
  //     final List<dynamic> names = contact['names'] as List<dynamic>;
  //     final Map<String, dynamic>? name = names.firstWhere(
  //       (dynamic name) =>
  //           (name as Map<Object?, dynamic>)['displayName'] != null,
  //       orElse: () => null,
  //     ) as Map<String, dynamic>?;
  //     if (name != null) {
  //       return name['displayName'] as String?;
  //     }
  //   }
  //   return null;
  // }
}
