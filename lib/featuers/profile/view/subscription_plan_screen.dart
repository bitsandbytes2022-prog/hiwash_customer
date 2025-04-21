import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/get_start_button.dart';
import '../../subscription/widgets/plan_container.dart';

class SubscriptionPlanScreen extends StatelessWidget {
   SubscriptionPlanScreen({super.key});
  WashStatusController washStatusController = Get.find();


  @override
  Widget build(BuildContext context) {
    final userData = washStatusController.getCustomerData?.data?.first;
    return AppHomeBg(
      padding: EdgeInsets.zero,
      headingText: "Subscription Plan",
      iconRight:SizedBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          Container(
            padding: EdgeInsets.only(top: 20,left: 16,right: 16),
            color: AppColor.white,

            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColor.blue.withOpacity(0.2)),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(Assets.imagesDemoProfile),
                  ),
                ),

                10.heightSizeBox,
                Text(userData?.fullName??"",style:w700_16a(color: AppColor.c2C2A2A) ,),
                42.heightSizeBox,
                subscriptionRowWidget(
                  title: 'Pack Name ',
                  packName: userData?.subscriptionName??'',
                ),
                10.heightSizeBox,
                DashedLineWidget(),
                10.heightSizeBox,
                subscriptionRowWidget(title: 'Remaining wash', packName: '1'),
                10.heightSizeBox,
                DashedLineWidget(),
                10.heightSizeBox,
                subscriptionRowWidget(
                  title: 'Expiry date ',
                  packName: '02 Apr 2025',
                  color: AppColor.cC41949,
                ),
                40.heightSizeBox,
              ],
            ),
          ),

          DashedLineWidget(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),

            width: Get.width,
            color: AppColor.cF6F7FF,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                26.heightSizeBox,
                Text(
                  "upgrade your Plan now",
                  style: w600_14a(color: AppColor.c2C2A2A),
                ),
                16.heightSizeBox,

                PlansContainer(index: 1, heading: "One wash per week",


                  subHeading: "Any of the 100 locations.",
                  qarText: "QAR",
                  numberText: "900",
                  yearText: "/ Year",
                ),
                15.heightSizeBox,
                PlansContainer(index: 2, heading: "Unlimited washes",
                  imageShow: true,


                  subHeading: "Any of the 100 locations.",
                  qarText: "QAR",
                  numberText: "1200",
                  yearText: "/ Year",
                ),
                20.heightSizeBox,
                GetStartButton(text: "Renew Now",
                  color: AppColor.c1F9D70,
                  boxShadowColor:AppColor.c1F9D70.withOpacity(0.30),

                ),
                60.heightSizeBox,

              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget subscriptionRowWidget({
    required String title,
    Color? color,
    required String packName,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title.tr, style: w400_12p(color: AppColor.c455A64)),
        Text(packName.tr, style: w500_12p(color: color ?? AppColor.c2C2A2A)),
      ],
    );
  }
}
