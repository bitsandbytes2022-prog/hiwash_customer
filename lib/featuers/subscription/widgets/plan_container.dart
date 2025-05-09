import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../controller/subscription_controller.dart';

class PlansContainer extends StatelessWidget {
  final int index;
  final String? heading;
  final String? subHeading;
  final String? yearText;
  final String? numberText;
  final String? qarText;
  final String? image;
  final bool imageShow;
  final VoidCallback? onTap;
  final String? subscriptionId;
  final int? currentUserSubscriptionId;
  final bool isViewOnly;


  PlansContainer({
    super.key,
    required this.index,
    this.heading,
    this.subHeading,
    this.yearText,
    this.numberText,
    this.qarText,
    this.image,
    this.imageShow = false,
    this.onTap,
    this.subscriptionId,
    this.currentUserSubscriptionId,
    this.isViewOnly = false,
  });

  final SubscriptionController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    bool isDisabled = isViewOnly || currentUserSubscriptionId == 1 || currentUserSubscriptionId == 2;

    return GestureDetector(
      onTap: () {
        if (isDisabled) return;
        controller.selectPlan(index, subscriptionId ?? "");
        if (onTap != null) onTap!();
      },

      child: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color:isDisabled
                    ? Colors.transparent:
                    controller.selectedIndex.value == index
                        ? AppColor.cC31848.withOpacity(0.25)
                        : AppColor.c142293.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 12,
                offset: Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color:isDisabled
                  ? Colors.grey.shade400:
                  controller.selectedIndex.value == index
                      ? AppColor.cC31848
                      : AppColor.c5C6B72.withOpacity(0.6),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          heading ?? "One wash per week",
                          style: w600_14a(color: AppColor.c2C2A2A),
                        ),
                        5.widthSizeBox,
                        if (imageShow)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: ImageView(
                              path: Assets.iconsIcCrown,
                              height: 22,
                              width: 22,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      subHeading ?? "One wash per week",
                      style: w400_12a(color: AppColor.c455A64),
                    ),
                    SizedBox(height: 17),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: qarText ?? 'QAR ',
                            style: w400_24a(color: AppColor.c455A64),
                          ),
                          TextSpan(
                            text: " ",
                            style: w400_24a(color: AppColor.c455A64),
                          ),
                          TextSpan(
                            text: numberText ?? '900 ',
                            style: w800_24a(color: AppColor.c455A64),
                          ),
                          TextSpan(
                            text: " ",
                            style: w400_24a(color: AppColor.c455A64),
                          ),
                          TextSpan(
                            text: yearText ?? '/ Year',
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
                    color:
                        controller.selectedIndex.value == index
                            ? AppColor.c1F9D70
                            : AppColor.c5C6B72.withOpacity(0.4),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color:
                        controller.selectedIndex.value == index
                            ? AppColor.c1F9D70
                            : AppColor.c5C6B72.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Image.asset(Assets.iconsIcCheck, height: 7, width: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
