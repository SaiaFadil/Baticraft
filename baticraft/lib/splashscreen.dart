import 'package:baticraft/navigation/utama.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => utama(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Image.network(
                    "https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.facebook.com%2Fp%2FGriya-Batik-Sri-Siji-Nganjuk-100069487599975%2F&psig=AOvVaw0smJpgrh2TwIMLsY0PZqWx&ust=1707919019409000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKCAj6a8qIQDFQAAAAAdAAAAABAE",
                    alignment: Alignment.center,
                    width: double.infinity,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
