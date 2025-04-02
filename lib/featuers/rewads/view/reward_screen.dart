import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_button.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/offers_grid_container.dart';

class RewardScreen extends StatelessWidget {
  const RewardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColor.c142293,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    Text(
                      "Offers For You",
                      style: w700_16a(color: AppColor.white),
                    ),
                    ImageView(
                      height: 23,
                      width: 23,
                      path: Assets.iconsIcMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
          30.heightSizeBox,
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    exclusiveOffer(),
                    SizedBox(
                      height: Get.height,
                      child: GridView.builder(
                        // padding: EdgeInsets.symmetric(horizontal: 10),
                        clipBehavior: Clip.hardEdge,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                          //  mainAxisExtent: Get.height * 0.22,
                        ),
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return OffersGridContainer();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget exclusiveOffer() {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: AppColor.cC31848,

              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(Assets.imagesSubscriptionBg),
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColor.cC31848.withOpacity(0.30),
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                17.heightSizeBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    "Explore All Exclusive Offers",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.rumRaisin(
                      fontWeight: FontWeight.w400,
                      fontSize: 24,
                      color: AppColor.white,
                    ),
                  ),
                ),
                13.heightSizeBox,
                Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColor.c142293,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: AppColor.white.withOpacity(.50),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    "Check Now",
                    style: w600_14a(color: AppColor.white),
                  ),
                ),
                24.heightSizeBox,
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Positioned(
                bottom: 0,
                child: ImageView(
                  height: 68,
                  width: 100,
                  path: Assets.imagesCar,
                ),
              ),
              Container(
                margin: EdgeInsets.only(),
                child: ImageView(
                  height: 71,
                  width: 87,
                  path: Assets.imagesJackpot,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
