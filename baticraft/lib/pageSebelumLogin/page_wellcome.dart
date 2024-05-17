import 'dart:io';
import 'dart:typed_data';

import 'package:baticraft/pageSebelumLogin/page_login.dart';
import 'package:baticraft/src/CustomButton.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';
import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_controller.dart';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:provider/provider.dart';
import 'package:pdf/src/widgets/document.dart';
import 'dart:math';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SliderP extends StatefulWidget {
  SliderP({Key? key}) : super(key: key);

  @override
  State<SliderP> createState() => _SliderPState();
}

class _SliderPState extends State<SliderP> {
  int activeIndex = 0;
  final controller = CarouselController();
  final urlImages = [
    Server.urlGambar("wellcome1.png"),
    Server.urlGambar("wellcome2.png"),
    Server.urlGambar("wellcome3.png"),
  ];
  final judul = [
    "KELOLA\nDATA PRODUK",
    "TRANSAKSI\nDAN PESANAN",
    "LAPORAN\nPENJUALAN"
  ];
 

 

  Future<void> Pindah() async {
    await Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration:
            Duration(milliseconds: 1500), // Durasi transisi 1.5 detik
        pageBuilder: (context, animation, secondaryAnimation) => page_login(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
    print("Transisi Selesai"); // Ini akan dicetak setelah transisi selesai
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 40, 35),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: CustomColors.whiteColor,
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.only(left: 30, top: 80),
                child: Text(
                  "Temukan\nkemudahan\ndalam berbisnis",
                  style: CustomText.TextArvoBold(25, CustomColors.blackColor),
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * .6,
            bottom: -5,
            left: -5,
            right: -5,
            child: Container(
              height: double.infinity,
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                color: CustomColors.secondaryColor,
                child: Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style:
                          CustomButton.DefaultButton(CustomColors.primaryColor),
                      onPressed: (){
                          Pindah();

                        print(" presseedd");
                      },
                      child: Text("Mulai",
                          style: CustomText.TextArvoBold(
                              20, CustomColors.whiteColor)),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: screenHeight * .08,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CarouselSlider.builder(
                      carouselController: controller,
                      itemCount: urlImages.length,
                      itemBuilder: (context, index, realIndex) {
                        final urlImage = urlImages[index];
                        final judulnya = judul[index];

                        return buildImage(urlImage, judulnya, index);
                      },
                      options: CarouselOptions(
                          height: 380,
                          autoPlay: true,
                          enableInfiniteScroll: false,
                          autoPlayAnimationDuration: Duration(seconds: 2),
                          enlargeCenterPage: true,
                          onPageChanged: (index, reason) =>
                              setState(() => activeIndex = index))),
                  SizedBox(height: 20),
                  buildIndicator()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
            dotColor: CustomColors.whiteColor,
            dotHeight: 10,
            dotWidth: 10,
            activeDotColor: CustomColors.primaryColor),
        activeIndex: activeIndex,
        count: urlImages.length,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}

Widget buildImage(String urlImage, String Judul, int index) => Container(
    padding: EdgeInsets.all(0),
    child: Container(
      child: Card(
        color: CustomColors.whiteColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 2, color: CustomColors.primaryColor),
          borderRadius: BorderRadius.circular(35),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                urlImage,
                height: 270,
                width: double.infinity,
              ),
              Text(
                Judul,
                style: CustomText.TextArvoBold(25, CustomColors.blackColor),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    ));
