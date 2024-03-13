import 'package:baticraft/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/navigation/utama.dart';

void main() {
  runApp(Fresh_Harvest());
}

class Fresh_Harvest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) =>
            // SplashScreen(), 
            utama()
      },
    );
  }
}