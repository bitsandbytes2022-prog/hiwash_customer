import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/subscription/controller/subscription_controller.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/widgets/components/custom_bottomsheet.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_button.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_text_field.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/components/qr_dialog.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../route/route_strings.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/app_dialog.dart';
import '../../../widgets/components/offers_grid_container.dart';
import '../widgets/offer_card.dart';
import '../widgets/plan_container.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({super.key});

  SubscriptionController controller = Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            Assets.imagesSubscriptionBg,
            height: 260,
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Column(
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
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: 40,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
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
                        17.heightSizeBox,
                        Text(
                          "kChooseAPlan".tr,
                          style: w700_22a(color: AppColor.c2C2A2A),
                        ),

                        8.heightSizeBox,
                        Text(
                          "kGetBenefitsAcrossAll".tr,
                          textAlign: TextAlign.center,
                          style: w400_12p(color: AppColor.c455A64),
                        ),
                        12.heightSizeBox,
                        OfferCardWidget(),
                        viewOfferButton(() {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return CustomBottomSheet(child: bottomSheet());
                            },
                          );
                        }),

                        29.heightSizeBox,

                        PlansContainer(index: 1),
                        15.heightSizeBox,
                        PlansContainer(index: 2),
                        18.heightSizeBox,
                        Obx(() {
                          if (controller.selectedIndex.value == 1) {
                            return Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColor.cFF973B.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: AppColor.cFF973B.withOpacity(0.4),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    Assets.iconsIcTAndC,
                                    height: 35,
                                    width: 35,
                                  ),
                                  10.widthSizeBox,

                                  Expanded(
                                    child: Text(
                                      "WashYourCarOnce".tr,
                                      style: w400_12p(color: AppColor.c455A64),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else if (controller.selectedIndex.value == 2) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 0,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "kCarRegistrationNumber".tr,
                                    style: w500_12p(color: AppColor.c455A64),
                                  ),
                                  Text(
                                    "kUnlimitedWashesPlan".tr,
                                    style: w500_12p(color: AppColor.c2C2A2A),
                                  ),
                                  10.heightSizeBox,
                                  HiWashTextField(
                                    hintText: "kEnterCarNumber".tr,
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        }),
                        30.heightSizeBox,
                        HiWashButton(
                          onTap: () {
                            Get.toNamed(RouteStrings.enterCardDetailScreen);
                          },
                          text: "kSubscribe".tr,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                        ),
                        60.heightSizeBox,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget viewOfferButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        decoration: BoxDecoration(
          color: AppColor.cC31848,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: AppColor.cC31848.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Text("View All Offers", style: w600_14a(color: AppColor.white)),
      ),
    );
  }

  Widget bottomSheet() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            21.heightSizeBox,
            Text(
              "See All Exclusive Offers.",
              style: w700_16a(color: AppColor.c2C2A2A),
            ),

            17.heightSizeBox,
            OfferCardWidget(),
            Container(
              width: 158,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                //color: AppColor.c5C6B72.withOpacity(0.3),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColor.c5C6B72.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Text(
                    "Sort by Expiry",
                    style: w400_12p(color: AppColor.c2C2A2A),
                  ),
                  Spacer(),
                  ImageView(
                    path: Assets.iconsIcDropDown,
                    height: 5,
                    width: 9,
                    color: AppColor.c2C2A2A,
                  ),
                  //Icon(Icons.arrow_drop_down, size: 20),
                ],
              ),
            ),
            20.heightSizeBox,
            SizedBox(
              height: Get.height,
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                clipBehavior: Clip.hardEdge,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  mainAxisExtent: Get.height * 0.22,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return OffersGridContainer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
