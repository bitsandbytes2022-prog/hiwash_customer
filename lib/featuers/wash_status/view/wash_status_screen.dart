import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/dashboard/controller/dashboard_controller.dart';
import 'package:hiwash_customer/featuers/wash_status/model/get_location_model.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/widgets/components/data_formet.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/app_dialog.dart';
import '../../../widgets/components/doted_horizontal_line.dart';
import '../../../widgets/components/profile_image_container.dart';
import '../controller/wash_status_controller.dart';
import '../model/wash_summry.dart';

class WashStatusScreen extends StatelessWidget {
  WashStatusScreen({super.key});

  final WashStatusController controller = Get.put(WashStatusController());
  DashboardController dashboardController =
      Get.isRegistered<DashboardController>()
          ? Get.find<DashboardController>()
          : Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.isWashSelected.value
              ? Expanded(
                child: SingleChildScrollView(
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
                                    padding: EdgeInsets.only(left: 14, top: 12),
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
                                        color: AppColor.white.withOpacity(0.7),
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
                                        style:
                                            (controller
                                                        .washSummaryModel
                                                        .value
                                                        ?.data
                                                        ?.summary
                                                        ?.remainingWashes ==
                                                    1)
                                                ? w700_27a(
                                                  color: AppColor.white,
                                                )
                                                : w700_15a(
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
                                        color: AppColor.white.withOpacity(0.7),
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
                              padding: EdgeInsets.only(top: 0, bottom: 150),
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
                                return servicesContainer(index, () {
                                  print("index complete wash====${index}");
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AppDialog(
                                        padding: EdgeInsets.zero,
                                        bottomVisible: true,

                                        remainingTextBottom:
                                            controller
                                                .washSummaryModel
                                                .value
                                                ?.data
                                                ?.summary
                                                ?.remainingWashes ??
                                            '',
                                        child: successDialog(
                                          controller
                                              .washSummaryModel
                                              .value!
                                              .data!
                                              .completedWash![index],
                                        ),
                                      );
                                    },
                                  );
                                });
                              },
                            ),
                      ],
                    ),
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
                      child: SingleChildScrollView(
                        // Wrap with SingleChildScrollView
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
                                      color: AppColor.cC41948.withOpacity(0.1),
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
                                        Obx(
                                          () => Text(
                                            controller
                                                    .currentAddress
                                                    .value
                                                    .isEmpty
                                                ? "Fetching location..."
                                                : controller
                                                    .currentAddress
                                                    .value,
                                            style: w500_14p(
                                              color: AppColor.c000000,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Obx(() {
                              if (controller.locationList.isEmpty) {
                                return Text("No nearby locations found");
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                // Prevents scroll conflict
                                itemCount: controller.locationList.length,
                                itemBuilder: (context, index) {
                                  final location =
                                      controller.locationList[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: locationContainer(location),
                                  );
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
    );
  }

  Widget servicesContainer(int index, VoidCallback? onTap) {
    var washData =
        controller.washSummaryModel.value?.data?.completedWash![index];

    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                placeholder:
                    (context, url) => Image.asset(
                      Assets.imagesDemoProfile,
                      fit: BoxFit.fill,
                      width: 70,
                    ),
                errorWidget:
                    (context, url, error) => Image.asset(
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
                        formatDate(washData?.redeemedAt ?? ''),
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
              width: 30,
              child:
                  washData?.rating == 0
                      ? SizedBox()
                      : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
      ),
    );
  }

  Widget successDialog(CompletedWash completedWashData) {
    // controller.washSummaryModel.value=null;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              30.heightSizeBox,
              Container(
                width: Get.width,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ImageView(
                        path: Assets.imagesImSussess,
                        width: Get.width,
                        fit: BoxFit.cover,
                        height: 180,
                      ),
                    ),
                  ],
                ),
              ),
              21.heightSizeBox,
              Text("Wash Complete!", style: w700_22a(color: AppColor.c2C2A2A)),
              Text(
                "Share your feedback and\nrate the Customer.",
                textAlign: TextAlign.center,
                style: w400_16p(),
              ),
              9.heightSizeBox,
              GetBuilder<DashboardController>(
                builder: (controller) {
                  return RatingStars(
                    value: controller.userRating.toDouble(),
                    onValueChanged: (v) {
                      controller.userRating = v.toInt();
                      controller.update();
                    },
                    starBuilder:
                        (index, color) =>
                            Icon(Icons.star, color: color, size: 28),
                    starCount: 5,
                    starSize: 28,
                    valueLabelVisibility: false,
                    starColor: AppColor.cFFC200,
                    starOffColor: Colors.grey,

                    animationDuration: Duration(milliseconds: 200),
                    starSpacing: 2,
                  );
                },
              ),

              15.heightSizeBox,

              TextFormField(
                controller: dashboardController.commentController,
                maxLines: 3,
                style: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.9)),
                decoration: InputDecoration(
                  fillColor: AppColor.white,
                  hintText: "Enter your comment here...",
                  filled: true,
                  labelStyle: w400_13a(color: AppColor.c455A64),
                  hintStyle: w400_14p(
                    color: AppColor.c2C2A2A.withOpacity(0.40),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.c5C6B72.withOpacity(0.30),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.c5C6B72.withOpacity(0.30),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              15.heightSizeBox,

              GestureDetector(
                onTap: () {
                  final comment =
                      dashboardController.commentController.text.trim();
                  final ratingString =
                      dashboardController.userRating.toString();

                  dashboardController
                      .getRating(
                        ratingString,
                        completedWashData.id.toString(),
                        comment,
                      )
                      .then((value) {
                        if (value != null) {
                          dashboardController.commentController.clear();
                          dashboardController.userRating = 0;
                          controller.getWashSummary();
                          Get.back();
                        }
                      });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColor.c142293,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.c142293.withOpacity(0.30),
                        blurRadius: 15,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Text("Submit", style: w500_14a(color: AppColor.white)),
                ),
              ),

              18.heightSizeBox,
            ],
          ),
        ),

        // Bottom profile section stays same
        Container(
          decoration: BoxDecoration(
            color: AppColor.cF6F7FF,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              DotedHorizontalLine(),
              Padding(
                padding: EdgeInsets.only(top: 23, left: 19, bottom: 40),
                child: Row(
                  children: [
                    ProfileImageView(
                      imagePath: completedWashData.locationImage,
                      radius: 20,
                      radiusStack: 4,
                      isVisibleStack: false,
                    ),
                    9.widthSizeBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          completedWashData.locationName ?? "",
                          style: w600_14a(color: AppColor.c2C2A2A),
                        ),
                        5.widthSizeBox,
                        Row(
                          children: [
                            ImageView(
                              path: Assets.iconsIcPlaceMarker,
                              height: 18,
                              width: 18,
                            ),
                            Text(
                              formatDate(completedWashData.redeemedAt),
                              style: w400_12a(color: AppColor.c455A64),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget locationContainer(LocationData locationList) {
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
            child: Image.asset(
              Assets.imagesImMap,
              fit: BoxFit.fill,
              width: 70,
              height: 70,
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
                    Row(
                      children: [
                        Text(
                          locationList.name ?? '',
                          style: w600_14a(color: AppColor.c2C2A2A),
                        ),
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
                          "${locationList.distanceInKm?.toStringAsFixed(2) ?? "0.00"} km",
                          style: w400_12a(color: AppColor.c455A64),
                        ),
                      ],
                    ),

                    13.heightSizeBox,
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ImageView(
                      path: Assets.iconsIcTimeMachine,
                      height: 18,
                      width: 18,
                    ),
                    5.widthSizeBox,
                    Text(
                      "Open 9:00 AM to 8:00 PM Static",
                      style: w400_10p(color: AppColor.c455A64),
                    ),
                  ],
                ),
              ],
            ),
          ),
          /*  Container(
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
                                       " washData?.rating.toString() ?? ''",
                                        style: w400_10a(color: AppColor.c455A64),
                                      ),
                                      13.heightSizeBox,

                                    ],
                                  ),
                                ),*/
        ],
      ),
    );
  }
}
