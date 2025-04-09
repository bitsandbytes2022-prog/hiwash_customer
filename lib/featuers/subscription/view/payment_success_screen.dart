import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/widgets/components/get_start_button.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../widgets/components/app_home_bg.dart';
import '../../../widgets/components/qr_dialog.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHomeBg(

      centerHeading: Container(
        margin: EdgeInsets.only(left: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                "Hello, Ibrahim",
                style: w400_16a(color: AppColor.white)
            ),
            Text(
                "Full access subscription",
                style:  w400_12a(color: AppColor.white)

            )
          ],
        ),
      ),
      childAppBar:  Positioned(
        left: 46,
        bottom: -10,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.symmetric(horizontal: BorderSide.none),
          ),
          child: CircleAvatar(
            radius: 38,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(Assets.imagesDemoProfile),
            ),
          ),
        ),
      ) ,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: ImageView(path: Assets.imagesSuccessBg,)
          ),
          Column(
            children: [
              19.heightSizeBox,
              QrDialog(),
              20.heightSizeBox,
              GetStartButton(text: "kGetStarted",

                onTap: (){
                  Get.toNamed(RouteStrings.dashboardScreen);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}


/*Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Lottie.network(
                      'https://assets1.lottiefiles.com/private_files/lf30_QLsD8M.json',
                      height: 200,
                      fit: BoxFit.cover,
                      repeat: true,
                      reverse: false,
                      animate: true,
                    ),
                  ),
                  Column(
                    children: [
                      19.heightSizeBox,
                      QrDialog(),
                      20.heightSizeBox,
                      GetStartButton(text: "kGetStarted",

                      onTap: (){
                        Get.toNamed(RouteStrings.dashboardScreen);
                      },
                      ),
                    ],
                  ),
                ],
              ),*/