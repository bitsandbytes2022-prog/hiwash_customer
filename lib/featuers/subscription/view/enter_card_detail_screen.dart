import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
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
import '../controller/subscription_controller.dart';
import '../widgets/payment_methods.dart';

class EnterCardDetailScreen extends StatelessWidget {
  EnterCardDetailScreen({super.key});

  DashboardController dashboardController = Get.find();
  WashStatusController washStatusController = Get.find();
  SubscriptionController subscriptionController = Get.find();

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments;

    final carNumber = args?["carNumber"];
    final subscriptionId = args?["subscriptionId"];
    final subscriptionIndex = args?["subscriptionIndex"];
    final source = args?["source"];
    final customerId=args?["customerId"];

    final userData =
        washStatusController.getCustomerData.value?.data?.customerDetails;
    return AppHomeBg(
      iconLeft: SizedBox(width: 50,),
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
              Obx(
                 () {
                   return subscriptionController.isLoading.value
                       ? Center(child: CircularProgressIndicator())
                       :  Center(
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
                     /*   onSwipe: () {
                          if (source == 'SubscriptionScreen') {
                            if (subscriptionIndex != null && carNumber != null) {
                              subscriptionController.getSubscriptionMembership(
                                subscriptionIndex.toString(),
                                "demo_transaction_id",
                                carNumber,
                                "success",
                              ).then((value){
                                washStatusController.getWashSummary();
                                washStatusController.getCustomerDataById(customerId);
                              });
                              Get.toNamed(RouteStrings.paymentSuccessScreen);
                            } else {
                              Get.snackbar("Error", "Missing subscription details (SubscriptionScreen)");
                            }
                          } else if (source == 'SubscriptionPlanScreen') {
                            if (subscriptionId != null && carNumber != null) {
                              subscriptionController.getSubscriptionMembership(
                                subscriptionId.toString(),
                                "demo_transaction_id",
                                carNumber,
                                "success",
                              ).then((value){
                                washStatusController.getWashSummary();
                                washStatusController.getCustomerDataById(customerId);
                              });
                              Get.toNamed(RouteStrings.paymentSuccessScreen);
                            } else {
                              Get.snackbar("Error", "Missing subscription details (PlanScreen)");
                            }
                          } else {
                            Get.snackbar("Error", "Unknown source");
                          }
                        },*/
                          onSwipe: () async {
                            if (source == 'SubscriptionScreen') {
                              if (subscriptionIndex != null && carNumber != null) {
                                await subscriptionController.getSubscriptionMembership(
                                  subscriptionIndex.toString(),
                                  "demo_transaction_id",
                                  carNumber,
                                  "success",
                                );

                                await washStatusController.getWashSummary();
                                await washStatusController.getCustomerDataById(customerId);

                                Get.offAllNamed(RouteStrings.paymentSuccessScreen);
                              } else {
                                Get.snackbar("Error", "Missing subscription details (SubscriptionScreen)");
                              }
                            } else if (source == 'SubscriptionPlanScreen') {
                              if (subscriptionId != null && carNumber != null) {
                                await subscriptionController.getSubscriptionMembership(
                                  subscriptionId.toString(),
                                  "demo_transaction_id",
                                  carNumber,
                                  "success",
                                );

                                await washStatusController.getWashSummary();
                                await washStatusController.getCustomerDataById(customerId);

                                Get.offAllNamed(RouteStrings.paymentSuccessScreen);
                              } else {
                                Get.snackbar("Error", "Missing subscription details (PlanScreen)");
                              }
                            } else {

                              Get.snackbar("Error", "Unknown source");
                            }
                          }



                      ),
                    ),
                  );
                }
              ),

              71.heightSizeBox,
            ],
          ),
        ),
      ),
    );
  }
}


