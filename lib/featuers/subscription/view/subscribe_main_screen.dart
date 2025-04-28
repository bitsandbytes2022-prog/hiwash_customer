import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/styling/app_font_poppins.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_button.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../widgets/components/image_view.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../rewads/controller.dart';

class SubscribeMainScreen extends StatelessWidget {
   SubscribeMainScreen({super.key});
  DashboardController dashboardController = Get.find();
    RewardController rewardController = Get.find<RewardController>();

   @override
  Widget build(BuildContext context) {
    final userData =
        dashboardController.getCustomerData.value?.data?.customerDetails;
    return AppHomeBg(
      padding: EdgeInsets.zero,

      centerHeading: Container(
        margin: EdgeInsets.only(left: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( userData?.fullName ?? '', style: w400_16a(color: AppColor.white)),
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
            border: Border.symmetric(horizontal: BorderSide.none),
          ),
          child: CircleAvatar(
            radius: 38,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 50,
              backgroundImage:
              (dashboardController
                  .getCustomerData
                  .value
                  ?.data
                  ?.customerDetails
                  ?.profilePicUrl
                  ?.isNotEmpty ??
                  false)
                  ? NetworkImage(
                dashboardController
                    .getCustomerData
                    .value
                    ?.data
                    ?.customerDetails
                    ?.profilePicUrl ??
                    "",
              )
                  : AssetImage(Assets.imagesDemoProfile)
              as ImageProvider,
            ),
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ImageView(
            path: Assets.imagesImMap,
            width: Get.width,
            height:Get.height/1.4,
            fit: BoxFit.cover,
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ImageView(
                path: Assets.imagesSubscribeBottome,
                width: Get.width,
                //height:Get.height/1.4,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Wash & Win!",style: w700_22a(color: AppColor.c2C2A2A),),
                 15.heightSizeBox,
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Get your car washed at ',
                          style: w400_16p(color: AppColor.c455A64),
                        ),
                        TextSpan(
                          text: '100+\nlocations ',
                          style: w400_16p(color: AppColor.c2C2A2A),
                        ),
                        TextSpan(
                          text: '& unlock',
                          style: w400_16p(color: AppColor.c455A64),
                        ),
                        TextSpan(
                          text: ' exclusive offers.',
                          style: w400_16p(color: AppColor.c2C2A2A),
                        ),
                      ],
                    ),
                  ),
                  24.heightSizeBox,
                  HiWashButton(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    text: 'subscribe Now',
                    onTap: (){
                      Get.toNamed(RouteStrings.subscriptionScreen);
                    },
                  ),
                  20.heightSizeBox,
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
