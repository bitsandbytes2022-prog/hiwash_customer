import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/dashboard/controller/dashboard_controller.dart';
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
//DashboardController dashboardController=Get.isRegistered<DashboardController>()?Get.find():Get.put(DashboardController());
  @override
  Widget build(BuildContext context) {
//dashboardController.getCustomerDataById(dashboardController.getCustomerData.value?.data?.customerDetails?.id??0);
  //  controller. getWashSummary();
    return Stack(
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
                          18.heightSizeBox,
                          Container(
                            height: 95,
                            decoration: BoxDecoration(
                              color: AppColor.cC31848,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.cC31848.withOpacity(0.30),
                                  spreadRadius: 0,
                                  blurRadius: 15,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 14,
                                        top: 12,
                                      ),
                                      child: Text(
                                        "${controller.washSummaryModel.value?.data?.summary?.totalWashes ?? ""}",
                                        style: w700_27a(color: AppColor.white),
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
                                          color: AppColor.white.withOpacity(
                                            0.7,
                                          ),
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
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.topRight,
                                        width: 100,
                                        padding: EdgeInsets.only(
                                          right: 14,
                                          top: 12,
                                        ),
                                        child: Text(
                                          "${controller.washSummaryModel.value?.data?.summary?.remainingWashes ?? ""}",
                                          style: w700_27a(
                                            color: AppColor.white,
                                          ),
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
                                          color: AppColor.white.withOpacity(
                                            0.7,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          24.heightSizeBox,
                          Text(
                            "kCompleteWash".tr,
                            style: w500_14a(color: AppColor.c2C2A2A),
                          ),
                          18.heightSizeBox,
                          (controller
                                      .washSummaryModel
                                      .value
                                      ?.data
                                      ?.completedWash
                                      ?.isEmpty ??
                                  true)
                              ? Container(
                                alignment: Alignment.center,
                                child: Text("Not Found"),
                              )
                              : ListView.separated(
                                padding: EdgeInsets.only(top: 0, bottom: 60),
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder:
                                    (context, index) => 14.heightSizeBox,
                                shrinkWrap: true,
                                itemCount:
                                    controller
                                        .washSummaryModel
                                        .value!
                                        .data!
                                        .completedWash!
                                        .length,
                                itemBuilder: (context, index) {
                                  return servicesContainer(index);
                                },
                              ),
                        ],
                      ),
                    ),
                  )

                  : Stack(
                    children: [
                      ImageView(
                        path: Assets.imagesImMap,
                        width: Get.width,
                        height: Get.height / 1.5,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
                          height: Get.height / 1.38,
                          // color: Colors.red,
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
                                      color: AppColor.c142293.withOpacity(0.20),
                                      spreadRadius: 0,
                                      blurRadius: 15,
                                      offset: Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),

                                      decoration: BoxDecoration(
                                        color: AppColor.cC41948.withOpacity(
                                          0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: ImageView(
                                        path: Assets.iconsMyLocation,
                                        height: 24,
                                        width: 24,
                                      ),
                                    ),
                                    10.widthSizeBox,
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "kYourCurrentLocation".tr,
                                            style: w400_12a(
                                              color: AppColor.c455A64,
                                            ),
                                          ),
                                          Obx(() => Text(
                                            controller.currentAddress.value.isEmpty
                                                ? "Fetching location..."
                                                : controller.currentAddress.value,
                                            style: w500_14p(
                                              color: AppColor.c000000,
                                            ),
                                          )),
                                        /*  Text(
                                            "2847 Poling Farm Road",
                                            style: w500_14p(
                                              color: AppColor.c000000,
                                            ),
                                          ),*/
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              //Spacer(),
                               /* servicesContainer(con),*/
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
        ),
      ],
    );
  }

  Widget servicesContainer(int index) {
    var washData =
        controller.washSummaryModel.value?.data?.completedWash![index];

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            clipBehavior: Clip.hardEdge,
            borderRadius: BorderRadius.circular(15),
            child: CachedNetworkImage(
              imageUrl: washData?.locationImage ?? '',
              placeholder: (context, url) => Image.asset(
                Assets.imagesDemoProfile,
                fit: BoxFit.fill,
                width: 70,
              ),
              errorWidget: (context, url, error) => Image.asset(
                Assets.imagesDemoProfile,
                fit: BoxFit.fill,
                width: 70,
              ),
              fit: BoxFit.fill,
              width: 70,
            ),
          ),
          15.widthSizeBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      washData?.locationName ?? '',
                      style: w600_14a(color: AppColor.c2C2A2A),
                    ),
                    Text(
                      washData?.comment ?? '',
                      style: w400_12a(color: AppColor.c455A64),
                    ),
                    13.heightSizeBox,
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageView(
                      path: Assets.iconsIcPlaceMarker,
                      height: 18,
                      width: 18,
                    ),

                    Text(
                      washData?.address ?? '',
                      style: w400_10p(color: AppColor.c455A64),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            child:
                washData?.rating == 0
                    ? SizedBox()
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ImageView(
                          path: Assets.iconsIcStar,
                          height: 14,
                          width: 14,
                        ),
                        Text(
                          washData?.rating.toString() ?? '',
                          style: w400_10a(color: AppColor.c455A64),
                        ),
                        13.heightSizeBox,
                        /* Text(
                  "Buy 1 Get 1 Free",
                  style: w500_10a(color: AppColor.cC31848),
                ),*/
                      ],
                    ),
          ),
        ],
      ),
    );
  }
}
