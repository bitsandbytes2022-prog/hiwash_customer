import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_button.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_text_field.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../widgets/payment_methods.dart';

class EnterCardDetailScreen extends StatelessWidget {
  const EnterCardDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 140,
                decoration: const BoxDecoration(
                  color: Color(0xFF002D9C), // Dark Blue Color
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 111),
                    Text(
                      "Hello, Ibrahim",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 46,
                bottom: -17,
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
              ),
            ],
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    18.heightSizeBox,
                    Text(
                      "kEnterYourPaymentDetails".tr,
                      style: w700_22a(color: AppColor.c2C2A2A),
                    ),
                    4.heightSizeBox,
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "kByContinuingYouAgree".tr,
                            style: w400_12p(color: AppColor.c455A64),
                          ),
                          TextSpan(
                            text: 'kTerms'.tr,
                            style: w500_14p(color: AppColor.c142293).copyWith(
                              decoration: TextDecoration.underline,
                              decorationColor: AppColor.c142293,
                            ),
                          ),
                        ],
                      ),
                    ),
                    32.heightSizeBox,
                    PaymentMethods(),
                    39.heightSizeBox,
                    HiWashTextField(
                      hintText: "kEnterCardholderName".tr,
                      labelText: "kCardholderName".tr,
                    ),
                    20.heightSizeBox,
                    HiWashTextField(
                      hintText: "**** **** **** 1234",
                      labelText: "kCardNumber",
                    ),
                    20.heightSizeBox,
                    Row(
                      children: [
                        Expanded(
                          child: HiWashTextField(
                            hintText: "12",
                            labelText: "kExpMonth".tr,
                          ),
                        ),
                        20.widthSizeBox,
                        Expanded(
                          child: HiWashTextField(
                            hintText: "12",
                            labelText: "kExpYear".tr,
                          ),
                        ),
                      ],
                    ),
                    20.heightSizeBox,
                    Row(
                      children: [
                        Expanded(
                          child: HiWashTextField(
                            hintText: "kCVC".tr,
                            labelText: "123",
                          ),
                        ),
                        40.widthSizeBox,
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "kPay".tr,
                                  style: w400_14a(color: AppColor.c455A64),
                                ),
                                TextSpan(
                                  text: 'QAR 1,200',
                                  style: w700_18a(color: AppColor.c2C2A2A),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    71.heightSizeBox,
                    HiWashButton(
                      text: "kSwipeToConfirm".tr,
                      color: AppColor.c1F9D70,
                      boxShadowColor: AppColor.c1F9D70.withOpacity(0.2),
                      onTap: () {
                        Get.toNamed(RouteStrings.paymentSuccessScreen);
                      },
                    ),
                    71.heightSizeBox,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
