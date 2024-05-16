import 'package:baticraft/navigation/utama.dart';
import 'package:baticraft/pageSebelumLogin/page_login.dart';
import 'package:baticraft/pageSebelumLogin/page_wellcome.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.secondaryColor,
      body: AnimatedSplashScreen(
            duration: 3000,
            splash: Image.asset(Server.urlGambar("logo_baticraft.png")),
            nextScreen: page_login.id_user.isEmpty?
         SliderP():utama(),
         splashIconSize: 100,
            splashTransition: SplashTransition.slideTransition,
            backgroundColor: Colors.blue));
  }
}
