import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/styling/app_font_poppins.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/components/doted_horizontal_line.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_text_field.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import 'second_drawer_controller/second_drawer_controller.dart';

class FaqScreen extends StatelessWidget {
  FaqScreen({super.key});

  final SecondDrawerController secondDrawerController = Get.put(
    SecondDrawerController(),
  );

  @override
  Widget build(BuildContext context) {
    return AppHomeBg(
      headingText: "FAQ’s",
      iconRight: SizedBox(),
      child: Column(
        children: [
          15.heightSizeBox,

          Container(
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: TextFormField(
              maxLines: 1,
              style: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.9)),
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ImageView(
                    path: Assets.iconsIcSearch,
                    height: 20,
                    width: 20,
                  ),
                ),
                hintText: "Search.....",
                filled: true,
                fillColor: AppColor.white,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                hintStyle: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.40)),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          20.heightSizeBox,
          Container(
            //padding: EdgeInsets.all(15),
            width: Get.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: AppColor.white,
              boxShadow: [
                BoxShadow(
                  color: AppColor.c142293.withOpacity(0.15),
                  blurRadius: 15,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Obx(
              () => ListView.separated(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: secondDrawerController.isExpanded.length,
                separatorBuilder: (context, index) {
                  return Column(
                    children: [
                      10.heightSizeBox,
                      Divider(color: AppColor.c142293.withOpacity(0.15)),
                      10.heightSizeBox,
                    ],
                  );
                },
                itemBuilder: (context, index) {
                  bool isOpen = secondDrawerController.isExpanded[index];
                  return GestureDetector(
                    onTap: () => secondDrawerController.toggleExpand(index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "How do I book a car wash?",
                                style: w600_12a(color: AppColor.c2C2A2A),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: ImageView(
                                  path:
                                      isOpen
                                          ? Assets.iconsIcUpWardArrow
                                          : Assets.iconsIcDropDown,
                                  height: 10,
                                  width: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isOpen) ...[
                          8.heightSizeBox,
                          Text(
                            "Go to the “Book Now” section, select your location, choose a service, and confirm your booking time.",
                            style: w400_12p(),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

