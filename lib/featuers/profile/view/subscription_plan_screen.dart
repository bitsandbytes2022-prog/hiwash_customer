import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/get_start_button.dart';
import '../../../widgets/components/image_view.dart';
import '../../subscription/widgets/plan_container.dart';

class SubscriptionPlanScreen extends StatelessWidget {
  const SubscriptionPlanScreen({super.key});

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
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: ImageView(
                        path: Assets.iconsIcArrow,

                        height: 15,
                        width: 15,
                      ),
                    ),
                    Text(
                      "Subscription Plan",
                      style: w700_16a(color: AppColor.white),
                    ),
                    Text(""),
                  ],
                ),
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
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
                        Text("Ibrahim Bafqia"),
                        42.heightSizeBox,
                        subscriptionRowWidget(
                          title: 'Pack Name',
                          packName: ' Unlimited Washes',
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

                        PlansContainer(index: 1),
                        15.heightSizeBox,
                        PlansContainer(index: 2),
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
              )
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
