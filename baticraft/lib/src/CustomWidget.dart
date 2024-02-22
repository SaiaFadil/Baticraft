import 'package:baticraft/src/Server.dart';
import 'package:flutter/material.dart';
import 'package:baticraft/src/CustomColors.dart';
import 'package:baticraft/src/CustomText.dart';

class CustomWidget {
  // static InkWell KolomPencarian(OnTap) {
  //   return InkWell(
  //       onTap: OnTap,
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Padding(
  //             padding: EdgeInsets.only(left: 15),
  //             child: Align(
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   "Cari",
  //                   style: CustomText.TextArvo(20, CustomColors.primaryColor),
  //                 )),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.only(right: 15),
  //             child: Align(
  //                 alignment: Alignment.centerRight,
  //                 child: Image.asset("assets/images/ic_cari.png")),
  //           )
  //         ],
  //       ));
  // }

  static Widget cardhome() {
    return Stack(
      fit: StackFit.loose,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 140, 20, 0),
          child: Card(
            surfaceTintColor: CustomColors.whiteColor,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      'Pendapatan Hari Ini',
                      style:
                          CustomText.TextArvoBold(16, CustomColors.blackColor),
                    ),
                  ),
                  subtitle: Text(
                    'RP 2.430.000',
                    style: CustomText.TextArvoBoldItalic(
                        25, CustomColors.blackColor),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Card(
                          color: CustomColors.secondaryColor,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Produk Terjual Hari Ini",
                                        style: CustomText.TextArvo(
                                            14, CustomColors.whiteColor)),
                                    Row(
                                      children: [
                                        Text("23",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomText.TextArvoBoldItalic(
                                                30, CustomColors.whiteColor)),
                                        SizedBox(width: 5),
                                        Text("pcs",
                                            style: CustomText.TextArvo(
                                                25, CustomColors.whiteColor)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Card(
                          color: CustomColors.secondaryColor,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Pembeli Hari Ini",
                                        style: CustomText.TextArvo(
                                            14, CustomColors.whiteColor)),
                                    Row(
                                      children: [
                                        Text("243",
                                            style: CustomText.TextArvoBoldItalic(
                                                30, CustomColors.whiteColor)),
                                        SizedBox(width: 5),
                                        Text("orang  ",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: CustomText.TextArvo(
                                                25, CustomColors.whiteColor)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          top: 100,
          right: 50,
          child: Image.asset(Server.urlGambar("koinhome.png")),
        )
      ],
    );
  }

}
