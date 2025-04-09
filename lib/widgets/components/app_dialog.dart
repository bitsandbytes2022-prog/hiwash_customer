import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_poppins.dart';
import 'image_view.dart';

class AppDialog extends StatelessWidget {
  Widget? child;
  String? remainingTextBottom;
  String? remainingTextTop;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  bool? topVisible = false;
  bool? bottomVisible = false;

  AppDialog({super.key, this.child, this.margin, this.padding,this.topVisible,

    this.bottomVisible,this.remainingTextBottom,this.remainingTextTop
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,

        child: Stack(
          alignment: Alignment.topCenter,
          children: [

            Stack(
              alignment: Alignment.bottomCenter,
              children: [

                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      margin:
                      margin ??
                          EdgeInsets.only(left: 16, right: 16, bottom: 11,top: 11),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: padding ?? EdgeInsets.symmetric(horizontal: 27),
                      child: child,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 22, top: 20),
                        child: ImageView(
                          path: Assets.iconsIcClose,
                          height: 28,
                          width: 32,
                        ),
                      ),
                    ),
                  ],
                ),

                if(bottomVisible==true) Container(
                  padding: EdgeInsets.only(bottom: 0),
                  margin: EdgeInsets.only(left: 50, right: 50, top: 40),

                  /*  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(Assets.imagesDialogBottom),
                    ),*/
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(Assets.imagesDialogBottom),
                      RichText(
                        text: TextSpan(
                          text: 'Remaining Washes: ',
                          style: w500_14p(color: AppColor.c2C2A2A),
                          children: <TextSpan>[
                            TextSpan(
                                text: '35',
                                style: w400_16p(color: AppColor.cC31848)
                            ),
                          ],
                        ),
                      ),
                      /* Text(
                        remainingTextTop ?? ''.tr,
                        style: w500_14p(color: AppColor.c2C2A2A),
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
            if(topVisible==true)  Container(

              padding: EdgeInsets.only(top: 0),
              margin: EdgeInsets.only(left: 50, right: 50,),

              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(Assets.imagesDiloagBgTop),


                  RichText(
                    text: TextSpan(
                      text: 'Remaining Washes: ',
                      style: w500_14p(color: AppColor.c2C2A2A),
                      children: <TextSpan>[
                        TextSpan(
                            text: '19',
                            style: w400_16p(color: AppColor.cC31848)
                        ),
                      ],
                    ),
                  ),
                  /* Text(
                    remainingTextBottom ?? ''.tr,
                    style: w500_14p(color: AppColor.c2C2A2A),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*class AppDialog extends StatelessWidget {
  Widget? child;
  String? remainingText;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  AppDialog({super.key, this.child, this.margin, this.padding});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,

        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
          */ /*  Container(
                padding: EdgeInsets.only(bottom: 0),
                margin: EdgeInsets.only(left: 50,right: 50,top: 40),
                */ /**/ /*  decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Assets.imagesDialogBottom),
                ),*/ /**/ /*

                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(Assets.imagesDiloagBgTop),
                    Text(remainingText??''.tr,style:w500_14p(color: AppColor.c2C2A2A) ,)
                  ],
                )

            ),*/ /*
            Stack(
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      margin:margin?? EdgeInsets.only(left: 16, right: 16,bottom: 11),
                      width: Get.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)
                      ),
                      padding: padding??EdgeInsets.symmetric(horizontal: 27),
                      child: child
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 18,top: 10),
                        child: ImageView(
                          path: Assets.iconsIcClose,
                          height: 28,
                          width: 32,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),

          */ /*  Container(
                padding: EdgeInsets.only(bottom: 0),
                margin: EdgeInsets.only(left: 50,right: 50,top: 40),
                */ /**/ /*  decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Assets.imagesDialogBottom),
                ),*/ /**/ /*

                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(Assets.imagesDialogBottom),
                    Text(remainingText??''.tr,style:w500_14p(color: AppColor.c2C2A2A) ,)
                  ],
                )

            )*/ /*
          ],
        ),
      ),
    );
  }
}*/

/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';
import '../../styling/app_font_poppins.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,

        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [

                Container(
                  margin: EdgeInsets.only(left: 21, right: 21, top: 30,bottom: 11),
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 27),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      40.heightSizeBox,
                      Image.asset(Assets.iconsIcCrown, height: 25, width: 27),
                      7.heightSizeBox,
                      Text("Success!", style: w700_22a(color: AppColor.c2C2A2A)),

                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Your payment is complete, and your ",
                              style: w400_12p(color: AppColor.c455A64),
                            ),
                            TextSpan(
                              text: "Unlimited Washes",
                              style: w500_12p(color: AppColor.c2C2A2A),
                            ),
                            TextSpan(
                              text: " plan is now activated.",
                              style: w400_12p(color: AppColor.c455A64),
                            ),
                          ],
                        ),
                      ),
                      15.heightSizeBox,
                      Image.asset(Assets.imagesDemo, height: 215, width: 215),
                      31.heightSizeBox,
                      Text(
                        "Congratulations!",
                        style: w600_14a(color: AppColor.c2C2A2A),
                      ),
                      9.heightSizeBox,
                      Text(
                        "Scan to unlock weekly washes,\nexclusive offers, and amazing deals!",
                        textAlign: TextAlign.center,
                        style: w400_12p(color: AppColor.c455A64),
                      ),
                      33.heightSizeBox,
                    ],
                  ),
                ),
                Container(
                  height: 59,
                  width: 59,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.c1F9D70.withOpacity(0.4),
                        spreadRadius: 0,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(7),

                  child: Image.asset(Assets.iconsIcVerify, height: 49, width: 49),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(bottom: 0),
                margin: EdgeInsets.only(left: 50,right: 50,top: 40),
              */
/*  decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(Assets.imagesDialogBottom),
                ),*/ /*


                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(Assets.imagesDialogBottom),
                    Text("jmshfjgfuyweg jefghujyx")
                  ],
                )

            )
          ],
        ),
      ),
    );
  }
}
*/
