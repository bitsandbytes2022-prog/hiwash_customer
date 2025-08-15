import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../featuers/rewads/controller.dart';
import '../../generated/assets.dart';
import 'image_view.dart';

class CustomBottomSheet extends StatelessWidget {
  final Widget child;
 final EdgeInsets?padding;

   CustomBottomSheet({super.key, required this.child,this.padding});
RewardController rewardController = Get.isRegistered()?Get.find():Get.put(RewardController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:padding,
      height: Get.height / 1.2,
      width: Get.width,
      decoration: BoxDecoration(
        //color:AppColor.cF6F7FF,

        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            //  mainAxisAlignment: MainAxisAlignment.center,
            children: [
              30.heightSizeBox,
              Container(
                height: 4,
                width: 45,
                decoration: BoxDecoration(
                  color: AppColor.c455A64,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              child,
            ],
          ),
          GestureDetector(
            onTap: () {
              rewardController.getAllOffers();
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.only(right: 10, top: 6,bottom: 20),
              child: ImageView(
                path: Assets.iconsIcClose,
                height: 28,
                width: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
