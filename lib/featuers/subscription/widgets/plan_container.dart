import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../controller/subscription_controller.dart';

class PlansContainer extends StatelessWidget {
  final int index;

  PlansContainer({super.key, required this.index});

  final SubscriptionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.selectPlan(index),
      child: Obx(() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: controller.selectedIndex.value == index
                  ? AppColor.cC31848.withOpacity(0.25)
                  : AppColor.c142293.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 12,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color:controller.selectedIndex.value==index?AppColor.cC31848: AppColor.c5C6B72.withOpacity(0.6),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 20,
                left: 15,
                right: 11,
                bottom: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "One wash per week",
                    style: w600_14a(color: AppColor.c2C2A2A),
                  ),
                  Text(
                    "One wash per week",
                    style: w400_12a(color: AppColor.c455A64),
                  ),
                  SizedBox(height: 17),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'QAR ',
                          style: w400_24a(color: AppColor.c455A64),
                        ),
                        TextSpan(
                          text: '900 ',
                          style: w800_24a(color: AppColor.c455A64),
                        ),
                        TextSpan(
                          text: '/ Year',
                          style: w400_14a(color: AppColor.c455A64),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 30,
              width: 30,
              margin: EdgeInsets.only(right: 11, top: 11),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color:controller.selectedIndex.value == index ? AppColor.c1F9D70 : AppColor.c5C6B72.withOpacity(0.4),
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: controller.selectedIndex.value == index ? AppColor.c1F9D70 : AppColor.c5C6B72.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Image.asset(
                  Assets.iconsIcCheck,
                  height: 7,
                  width: 12,
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}