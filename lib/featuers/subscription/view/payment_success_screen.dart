import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/dashboard/controller/dashboard_controller.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
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
  PaymentSuccessScreen({super.key});

  DashboardController dashboardController = Get.find();
  WashStatusController washStatusController = Get.find();

  @override
  Widget build(BuildContext context) {
    final userData =
        washStatusController.getCustomerData.value?.data?.customerDetails;
    return AppHomeBg(
      padding: EdgeInsets.zero,
      centerHeading: Container(
        margin: EdgeInsets.only(left: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userData?.fullName ?? '',
              style: w400_16a(color: AppColor.white),
            ),
            Text(
              "Full access subscription",
              style: w400_12a(color: AppColor.white.withOpacity(0.5)),
            ),
          ],
        ),
      ),
      childAppBar: Positioned(
        left: 46,
        bottom: -10,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.cF6F7FF,
            // border: Border.symmetric(horizontal: BorderSide.none),
            border: Border.all(color: AppColor.cF6F7FF, width: 10),
          ),
          child: Obx(() {
            final profilePicUrl = washStatusController
                .getCustomerData
                .value
                ?.data
                ?.customerDetails
                ?.profilePicUrl;

            final hasValidUrl = profilePicUrl?.isNotEmpty ?? false;

            return CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: hasValidUrl ? profilePicUrl! : '',
                  fit: BoxFit.cover,
                  height: 56, // radius * 2
                  width: 56,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    Assets.imagesDemoProfile,
                    fit: BoxFit.cover,
                    height: 56,
                    width: 56,
                  ),
                ),
              ),
            );
          }),

        ),
      ),
      child: Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 40),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: ImageView(path: Assets.imagesSuccessBg),
              ),
              Column(
                children: [
                  19.heightSizeBox,
                  QrDialog(),
                  30.heightSizeBox,
                  GetStartButton(
                    text: "kGetStarted",
          
                    onTap: () {
                      Get.toNamed(RouteStrings.dashboardScreen);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
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
