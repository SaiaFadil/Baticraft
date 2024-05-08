import 'package:baticraft/menu/TabTransaksi/subMenuTransaksi/transactionManager.dart';
import 'package:baticraft/navigation/utama.dart';
import 'package:baticraft/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  runApp(Fresh_Harvest());
}

class Fresh_Harvest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TransactionManager(), // Anda perlu mengganti TransactionManager dengan kelas yang sesuai
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(), // Ganti HomeScreen() dengan widget utama aplikasi Anda
      ),
    );
  }
}
