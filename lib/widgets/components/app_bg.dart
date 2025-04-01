import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

class AppBg extends StatelessWidget {
  final String headingText;
  final String subText;
  final Widget child;

  const AppBg({
    super.key,
    required this.headingText,
    required this.subText,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return  Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.imagesWelcomeBg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 11, top: 40),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 13,
                      ),
                    ),
                  ),
                  12.widthSizeBox,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(headingText, style: w400_22a(color: AppColor.white)),
                      Text(subText, style: w800_40a(color: AppColor.white)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 150),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  margin: EdgeInsets.only(top: 70),
                  child: child,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  height: 155,
                  width: 155,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(77.5),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.blue.withOpacity(0.2),
                        blurRadius: 30,
                        spreadRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(child: Image.asset(Assets.imagesAppLogo)),
                ),
              ],
            ),
          ),
        ),

        //  Text("Skip"),
      ],
    );
  }
}
