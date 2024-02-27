import 'package:flutter/material.dart';

class Responsifable {
  final BuildContext context;

  Responsifable(this.context);

  double get textScaleFactor => MediaQuery.of(context).textScaleFactor;
  Size get screenSize => MediaQuery.of(context).size;
  double get screenWidth => screenSize.width;
  double get screenHeight => screenSize.height;
}

// Penggunaan di dalam widget lain
class PageLupaKataSandi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsifable(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lupa Kata Sandi'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Silakan masukkan alamat email Anda di bawah ini. Kami akan mengirimkan tautan untuk mereset kata sandi Anda.',
              style: TextStyle(
                fontSize: 16 * responsive.textScaleFactor,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                labelText: 'Alamat Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk mengirim tautan reset kata sandi di sini
              },
              child: Text(
                'Kirim Tautan Reset Kata Sandi',
                style: TextStyle(
                  fontSize: 16 * responsive.textScaleFactor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
