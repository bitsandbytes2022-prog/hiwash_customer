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
import '../../../widgets/components/app_home_bg.dart';
import '../../../widgets/components/custom_swipe_button.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../widgets/payment_methods.dart';

class EnterCardDetailScreen extends StatelessWidget {
  EnterCardDetailScreen({super.key});

  DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    final userData =
        dashboardController.getCustomerData.value?.data?.customerDetails;
    return AppHomeBg(
      centerHeading: Container(
        margin: EdgeInsets.only(left: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userData?.fullName ?? "",
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
          child: CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage(Assets.imagesDemoProfile),
          ),
        ),
      ),

      child: Expanded(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              16.heightSizeBox,
              Text(
                "kEnterYourPaymentDetails".tr,
                textAlign: TextAlign.center,
                style: w700_22a(color: AppColor.c2C2A2A),
              ),
              10.heightSizeBox,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PaymentMethods(),
                  PaymentMethods(),

                  PaymentMethods(
                    checkBoxShow: true,
                    height: 70,
                    width: 70,
                    borderColor: AppColor.cC31848,
                  ),
                  PaymentMethods(),
                  PaymentMethods(),
                ],
              ),
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
                    child: HiWashTextField(hintText: "kCVC".tr, labelText: "123"),
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomSwipeButton(
                    thumbPadding: EdgeInsets.all(3),
                    activeThumbColor: AppColor.c1F9D70,
                    thumb: Icon(Icons.chevron_right, color: Colors.white),
                    elevationThumb: 2,
                    elevationTrack: 2,
                    child: Text(
                      "Swipe to confirm".toUpperCase(),
                      style: TextStyle(
                        color: AppColor.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onSwipe: () {
                      Get.toNamed(RouteStrings.paymentSuccessScreen);
                      /*  ScaffoldMessenger.of(Get.context!).showSnackBar(
                                  SnackBar(
                                    content: Text("Swiped!"),
                                    backgroundColor: Colors.green,
                                  ),
                                );*/
                      /*   Get.back();
                                showDialog(
                                  barrierDismissible: false,
                                  context: Get.context!,
                                  builder: (BuildContext context) {
                                    return AppDialog(
                                      topVisible: true,

                                      padding: EdgeInsets.zero,

                                      child: ownerDetailsDialog(),
                                    );
                                  },
                                );*/
                    },
                  ),
                ),
              ),
              /*  HiWashButton(
                          text: "kSwipeToConfirm".tr,
                          color: AppColor.c1F9D70,
                          boxShadowColor: AppColor.c1F9D70.withOpacity(0.2),
                          onTap: () {
                            Get.toNamed(RouteStrings.paymentSuccessScreen);
                          },
                        ),*/
              71.heightSizeBox,
            ],
          ),
        ),
      ),
    );
  }
}

/* Column(
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
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: CustomSwipeButton(
                          thumbPadding: EdgeInsets.all(3),
                          activeThumbColor: AppColor.c1F9D70,
                          thumb: Icon(Icons.chevron_right, color: Colors.white),
                          elevationThumb: 2,
                          elevationTrack: 2,
                          child: Text(
                            "Swipe to Complete Wash ".toUpperCase(),
                            style: TextStyle(
                              color: AppColor.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onSwipe: () {
                            Get.toNamed(RouteStrings.paymentSuccessScreen);
                            /*  ScaffoldMessenger.of(Get.context!).showSnackBar(
                              SnackBar(
                                content: Text("Swiped!"),
                                backgroundColor: Colors.green,
                              ),
                            );*/
                            /*   Get.back();
                            showDialog(
                              barrierDismissible: false,
                              context: Get.context!,
                              builder: (BuildContext context) {
                                return AppDialog(
                                  topVisible: true,

                                  padding: EdgeInsets.zero,

                                  child: ownerDetailsDialog(),
                                );
                              },
                            );*/
                          },
                        ),
                      ),
                    ),
                  /*  HiWashButton(
                      text: "kSwipeToConfirm".tr,
                      color: AppColor.c1F9D70,
                      boxShadowColor: AppColor.c1F9D70.withOpacity(0.2),
                      onTap: () {
                        Get.toNamed(RouteStrings.paymentSuccessScreen);
                      },
                    ),*/
                    71.heightSizeBox,
                  ],
                ),
*/
