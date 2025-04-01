import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_font_poppins.dart';
import '../controller/wash_status_controller.dart';

class WashStatusScreen extends StatelessWidget {
  WashStatusScreen({super.key});

  final WashStatusController controller = Get.put(WashStatusController());

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
                height: 140,
                decoration: const BoxDecoration(
                  color: Color(0xFF002D9C),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.white, size: 24),
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
              Obx(
                () => Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.isWashSelected.value = true;
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            decoration: BoxDecoration(
                              color:
                                  controller.isWashSelected.value
                                      ? Colors.white
                                      : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              "kWash".tr,
                              style: w700_16a(
                                color:
                                    controller.isWashSelected.value
                                        ? AppColor.c2C2A2A
                                        : AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      30.widthSizeBox,
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            controller.isWashSelected.value = false;
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 30,
                            decoration: BoxDecoration(
                              color:
                                  !controller.isWashSelected.value
                                      ? Colors.white
                                      : Colors.transparent,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Text(
                              "kLocations".tr,
                              style: w700_16a(
                                color:
                                    !controller.isWashSelected.value
                                        ? AppColor.c2C2A2A
                                        : AppColor.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              children: [
                Obx(
                  () =>
                      controller.isWashSelected.value
                          ? SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  14.heightSizeBox,
                                  Container(
                                    height: 95,
                                    decoration: BoxDecoration(
                                      color: AppColor.cC31848,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColor.cC31848.withOpacity(
                                            0.30,
                                          ),
                                          spreadRadius: 0,
                                          blurRadius: 15,
                                          offset: Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                left: 14,
                                                top: 12,
                                              ),
                                              child: Text(
                                                "53",
                                                style: w700_27a(
                                                  color: AppColor.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                                bottom: 9,
                                              ),
                                              child: Text(
                                                "kTotalWashes".tr,
                                                style: w500_12p(
                                                  color: AppColor.white
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        ImageView(
                                          path: Assets.imagesCarWash,
                                          height: 59,
                                          width: 107,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                right: 14,
                                                top: 12,
                                              ),
                                              child: Text(
                                                "19",
                                                style: w700_27a(
                                                  color: AppColor.white,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                right: 15,
                                                bottom: 9,
                                              ),
                                              child: Text(
                                                "kRemaining".tr,
                                                style: w500_12p(
                                                  color: AppColor.white
                                                      .withOpacity(0.7),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  21.heightSizeBox,
                                  Text(
                                    "kCompleteWash".tr,
                                    style: w500_14a(color: AppColor.c2C2A2A),
                                  ),
                                  12.heightSizeBox,
                                  ListView.separated(
                                    padding: EdgeInsets.only(
                                      top: 0,
                                      bottom: 60,
                                    ),
                                    physics: NeverScrollableScrollPhysics(),
                                    separatorBuilder:
                                        (context, index) => 10.heightSizeBox,
                                    shrinkWrap: true,
                                    itemCount: 10,
                                    itemBuilder: (context, index) {
                                      return servicesContainer();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                          : Stack(
                            children: [
                              ImageView(
                                path: Assets.imagesMapImage,
                                width: Get.width,
                                fit: BoxFit.cover,
                              ),
                              Padding(
                                padding:  EdgeInsets.symmetric(horizontal: 15),
                                child: Column(
                                  children: [
                                    15.heightSizeBox,
                                    Container(
                                      padding: EdgeInsets.only(
                                        top: 8,
                                        left: 8,
                                        bottom: 7,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColor.white,
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColor.c142293.withOpacity(
                                              0.20,
                                            ),
                                            spreadRadius: 0,
                                            blurRadius: 15,
                                            offset: Offset(0, 5),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(10),

                                            decoration: BoxDecoration(
                                              color: AppColor.cC41948.withOpacity(
                                                0.1,
                                              ),
                                              borderRadius: BorderRadius.circular(
                                                15,
                                              ),
                                            ),
                                            child: ImageView(
                                              path: Assets.iconsMyLocation,
                                              height: 24,
                                              width: 24,
                                            ),
                                          ),
                                          10.widthSizeBox,
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "kYourCurrentLocation".tr,
                                                style: w400_12a(
                                                  color: AppColor.c455A64,
                                                ),
                                              ),
                                              Text(
                                                "2847 Poling Farm Road",
                                                style: w500_14p(
                                                  color: AppColor.c000000,
                                                ),
                                              ),
                                            ],
                                          ),

                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    servicesContainer(),
                                    82.heightSizeBox
                                  ],
                                ),
                              ),
                            ],
                          ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget servicesContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColor.c142293.withOpacity(0.15),
            spreadRadius: 0,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(15),
            child: ImageView(
              path: Assets.imagesDemoProfile,
              height: 70,
              width: 70,
            ),
          ),
          15.widthSizeBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Elite car wash service",
                style: w600_14a(color: AppColor.c2C2A2A),
              ),
              Text("09-May-2024", style: w400_12a(color: AppColor.c455A64)),
              13.heightSizeBox,
              Row(
                children: [
                  Icon(Icons.location_on),
                  Text(
                    "2847 Poling Farm Road",
                    style: w400_10p(color: AppColor.c455A64),
                  ),
                ],
              ),
            ],
          ),
          Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ImageView(path: Assets.iconsIcStar, height: 14, width: 14),
              Text("4.5", style: w400_10a(color: AppColor.c455A64)),
              25.heightSizeBox,
              Text(
                " Buy 1 Get 1 Free",
                style: w500_10a(color: AppColor.cC31848),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
