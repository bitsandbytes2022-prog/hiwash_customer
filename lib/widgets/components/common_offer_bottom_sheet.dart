import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../featuers/rewads/controller.dart';
import '../../featuers/rewads/model/offer_response_model.dart';
import '../../featuers/subscription/widgets/offer_card.dart';
import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';
import '../../styling/app_font_poppins.dart';
import 'app_dialog.dart';
import 'custom_bottomsheet.dart';
import 'date_time_widget.dart';
import 'doted_line.dart';
import 'image_view.dart';
import 'offers_grid_container.dart';

class BottomSheetWidget extends StatelessWidget {
  Widget? child;
  VoidCallback? onTap;
  bool isVisible;

  BottomSheetWidget({Key? key, this.child, this.isVisible = false, this.onTap})
    : super(key: key);

  final RewardController rewardController = Get.find<RewardController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding:padding,
      height: Get.height / 1.2,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColor.cF6F7FF,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                21.heightSizeBox,
                Text(
                  "See All Exclusive Offers.",
                  style: w700_16a(color: AppColor.c2C2A2A),
                ),

                27.heightSizeBox,
                OfferCardWidget(padding: EdgeInsets.symmetric(horizontal: 20)),
                25.heightSizeBox,
                GestureDetector(
                  onTap: () {
                    rewardController.isVisible.value =
                        !rewardController.isVisible.value;
                  },
                  child: Container(
                    width: 158,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                    decoration: BoxDecoration(
                      //color: AppColor.c5C6B72.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(28),
                      border: Border.all(
                        color: AppColor.c5C6B72.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      children: [
                        Obx(
                          () => Text(
                            rewardController.sortByText.value,
                            style: w400_12p(color: AppColor.c2C2A2A),
                          ),
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
                ),
                25.heightSizeBox,
                Column(
                  children: [
                    Obx(() {
                      final List<Offers> data =
                          rewardController
                              .offerResponseModel
                              .value
                              ?.data
                              ?.offers ??
                          [];

                      return data.isNotEmpty
                          ? GridView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.only(
                              left: 16,
                              right: 15,
                              bottom: 60,
                            ),
                            clipBehavior: Clip.hardEdge,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 15,
                                ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () async {
                                  if (isVisible) {
                                    print("04444444444------>");
                                    Get.back();
                                    //rewardController.update();
                                    await rewardController.getOffersById(
                                      data[index].id!,
                                    );
                                    //rewardController.update();
                                    print("0000000000------>");
                                    // Get.back();
                                    showModalBottomSheet(
                                      context: Get.context!,
                                      isScrollControlled: true,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15),
                                          topRight: Radius.circular(15),
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return CustomBottomSheet(
                                          child: viewOfferDetailBottomSheet(),
                                        );
                                      },
                                    );
                                  }
                                  // Get.back();
                                },

                                child: OffersGridContainer(offer: data[index]),
                              );
                            },
                          )
                          : Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Text(
                              'Data is not found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          );
                    }),
                  ],
                ),
              ],
            ),
            Obx(
              () =>
                  rewardController.isVisible.value
                      ? Positioned(
                        top: Get.height / 2.99,
                        child: Container(
                          alignment: Alignment.center,

                          width: 180,
                          height: 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.deepPurple.withOpacity(0.3),
                                blurRadius: 10,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          //   color: Colors.white,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  rewardController.toggleSortOrder();
                                  rewardController.isVisible.value =
                                      false; // Hide popup
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text("Ascending order"),
                                ),
                              ),

                              GestureDetector(
                                onTap: () {
                                  rewardController.toggleSortOrder();
                                  rewardController.isVisible.value =
                                      false; // Hide popup
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Text("Descending order"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      : Container(),
            ),
            Positioned(
              top: 5,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.only(right: 10, top: 6),
                  child: ImageView(
                    path: Assets.iconsIcClose,
                    height: 28,
                    width: 32,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget viewOfferDetailBottomSheet() {
    return GetBuilder(
      init: RewardController(),

      builder: (controller) {
        return Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                13.heightSizeBox,
                Container(
                  margin: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: AppColor.c2C2A2A.withOpacity(0.2)
                    border: Border.all(
                      color: AppColor.c2C2A2A.withOpacity(0.2),
                    ),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          height: 187,
                          width: Get.width,
                          fit: BoxFit.fitWidth,
                          imageUrl:
                              (rewardController
                                          .getOffersByIdModel
                                          .value
                                          ?.data
                                          ?.first
                                          .image
                                          ?.isNotEmpty ??
                                      false)
                                  ? rewardController
                                      .getOffersByIdModel
                                      .value!
                                      .data!
                                      .first
                                      .image!
                                  : Assets.imagesImOffer,
                          placeholder:
                              (context, url) => Center(
                                child: SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                          errorWidget:
                              (context, url, error) => Image.asset(
                                Assets.imagesImOffer,
                                height: 187,
                                width: Get.width,
                                fit: BoxFit.fitWidth,
                              ),
                        ),
                      ),

                      /*  ClipRRect(
                       borderRadius: BorderRadius.circular(15),
                       child: ImageView(
                         height: 187,
                         path:
                         rewardController
                             .getOffersByIdModel
                             .value
                             ?.data
                             ?.first
                             .image
                             ?.isNotEmpty ==
                             true
                             ? rewardController
                             .getOffersByIdModel
                             .value
                             ?.data!
                             .first
                             .image
                             : Assets.imagesImOffer,
                         width: Get.width,
                         fit: BoxFit.fitWidth,
                       ),
                     ),*/
                      Positioned(
                        top: 35,
                        left: 14,

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DateTimeWidget(
                              title: rewardController.timeUntilExpiry(
                                rewardController
                                        .getOffersByIdModel
                                        .value
                                        ?.data
                                        ?.first
                                        .expiryDate ??
                                    "No Expiry",
                              ),
                            ),
                            /* DateTimeWidget(
                            title: "0:3 HRS - 34 MINS",
                            textColor: AppColor.c000000,
                            color: AppColor.white.withOpacity(0.5),
                          ),*/
                            13.heightSizeBox,
                            Text(
                              "${rewardController.getOffersByIdModel.value?.data?.first.title ?? ""}",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.rumRaisin(
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                                color: AppColor.white,
                              ),
                            ),
                            /* Text("FREE Accessories",
                             textAlign: TextAlign.center,
                             style: GoogleFonts.rumRaisin(
                               fontWeight: FontWeight.w400,
                               fontSize: 24,
                               color: AppColor.white,
                             ),
                           ),*/
                          ],
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: 17,

                        child: Container(
                          padding: EdgeInsets.only(top: 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: CachedNetworkImage(
                              height: 40,
                              width: 40,
                              fit: BoxFit.fitWidth,
                              imageUrl:
                              (rewardController
                                  .getOffersByIdModel
                                  .value
                                  ?.data
                                  ?.first
                                  .qRCodeUrl
                                  ?.isNotEmpty ??
                                  false)
                                  ? rewardController
                                  .getOffersByIdModel
                                  .value!
                                  .data!
                                  .first
                                  .qRCodeUrl!
                                  : Assets.imagesDemo,
                              placeholder:
                                  (context, url) => Center(
                                child: SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              ),
                              errorWidget:
                                  (context, url, error) => Image.asset(
                                Assets.imagesDemo,
                                height: 40,
                                width: 40,
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),

                          /*ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: ImageView(
                              path:
                                  rewardController
                                              .getOffersByIdModel
                                              .value
                                              ?.data
                                              ?.first
                                              .image
                                              ?.isNotEmpty ==
                                          true
                                      ? rewardController
                                          .getOffersByIdModel
                                          .value
                                          ?.data!
                                          .first
                                          .qRCodeUrl
                                      : Assets.imagesDemo,
                              height: 40,
                              width: 40,
                            ),
                          ),*/
                        ),
                      ),
                    ],
                  ),
                ),
                profileView(),
                DashedLineWidget(),
                15.heightSizeBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Exclusive Products.",
                        style: w700_16a(color: AppColor.c2C2A2A),
                      ),

                      Text(
                        "Special Offers & FREE Coupons – Grab Yours Today!",
                        style: w400_12p(),
                      ),
                      29.heightSizeBox,
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 80),
                            child: ImageView(
                              path: Assets.imagesCloudBg,
                              height: 96,
                              width: Get.width,
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            // left: Get.width/2,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
                                showDialog(
                                  barrierDismissible: false,
                                  context: Get.context!,
                                  builder: (BuildContext context) {
                                    return AppDialog(
                                      padding: EdgeInsets.zero,

                                      child: scanDialog(),
                                    );
                                  },
                                );
                              },
                              child: CachedNetworkImage(
                                height: 157,
                                width: 157,
                                fit: BoxFit.fitWidth,
                                imageUrl:
                                (rewardController
                                    .getOffersByIdModel
                                    .value
                                    ?.data
                                    ?.first
                                    .qRCodeUrl
                                    ?.isNotEmpty ??
                                    false)
                                    ? rewardController
                                    .getOffersByIdModel
                                    .value!
                                    .data!
                                    .first
                                    .qRCodeUrl!
                                    : Assets.imagesDemo,
                                placeholder:
                                    (context, url) => Center(
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                ),
                                errorWidget:
                                    (context, url, error) => Image.asset(
                                  Assets.imagesDemo,
                                  height: 157,
                                  width: 157,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),

                              /*ImageView(
                                path:
                                    rewardController
                                                .getOffersByIdModel
                                                .value
                                                ?.data
                                                ?.first
                                                .qRCodeUrl
                                                ?.isNotEmpty ==
                                            true
                                        ? rewardController
                                            .getOffersByIdModel
                                            .value
                                            ?.data!
                                            .first
                                            .qRCodeUrl
                                        : Assets.imagesImQr,
                                height: 157,
                                width: 157,
                              ),*/
                            ),
                          ),
                        ],
                      ),

                      13.heightSizeBox,

                      rewardController.countdown.isNotEmpty
                          ? Text("${rewardController.countdown}")
                          : SizedBox(),
                      Align(
                        alignment: Alignment.center,
                        child: ImageView(
                          path: Assets.imagesTimeView,
                          height: 37,
                        ),
                      ),
                      28.heightSizeBox,
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.white,

                          borderRadius: BorderRadius.circular(10),

                          border: Border.all(
                            color: AppColor.c142293.withOpacity(0.20),
                          ),
                        ),
                        child: Column(
                          children: [
                            5.heightSizeBox,
                            dropDownRow(
                              index: 0,
                              title: "Offer Details",
                              content: "Details about the offer go here...",
                            ),
                            Divider(color: AppColor.c142293.withOpacity(0.20)),

                            dropDownRow(
                              index: 1,
                              title: "How to redeem",
                              content: "Redemption process explained here...",
                            ),
                            Divider(color: AppColor.c142293.withOpacity(0.20)),

                            dropDownRow(
                              index: 2,
                              title: "Terms & conditions",
                              content: "All the fine print goes here...",
                            ),

                            5.heightSizeBox,
                          ],
                        ),
                      ),
                      25.heightSizeBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageView(
                            height: 18,
                            width: 18,
                            path: Assets.imagesIcInfo,
                          ),
                          3.widthSizeBox,
                          Text(
                            "Report an issue",
                            style: w600_12a(color: AppColor.c142293),
                          ),
                        ],
                      ),
                      50.heightSizeBox,
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget profileView() {
    return Padding(
      padding: EdgeInsets.only(left: 16, top: 14, right: 16, bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: AppColor.c142293.withOpacity(0.2)),
            ),
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.circular(100),
              child: ImageView(
                path: Assets.imagesDemoProfile,
                fit: BoxFit.fill,

                width: 40,
                height: 40,
              ),
            ),
          ),
          5.widthSizeBox,
          Container(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Elite car wash service Elite car wash service Elite car wash service",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: w600_14a(color: AppColor.c2C2A2A),
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
                      "2847 Poling Farm Road",
                      style: w400_10p(color: AppColor.c455A64),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
          Container(
            width: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ImageView(path: Assets.iconsIcStar, height: 14, width: 14),
                Text("4.5(200)", style: w400_10a(color: AppColor.c455A64)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget dropDownRow({
    required int index,
    required String? title,
    required String content,
  }) {
    return Obx(() {
      final isExpanded = rewardController.selectedDropDownIndex.value == index;

      return GestureDetector(
        onTap: () {
          rewardController.selectedDropDownIndex.value =
              isExpanded ? -1 : index; // Toggle
        },
        child: Container(
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              10.heightSizeBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title ?? "", style: w600_12a(color: AppColor.c2C2A2A)),
                    ImageView(
                      path:
                          isExpanded
                              ? Assets.iconsIcUpWardArrow
                              : Assets.iconsIcDropDown,
                      height: 6,
                      width: 10,
                    ),
                  ],
                ),
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(content, style: w400_12p()),
                ),
              10.heightSizeBox,
            ],
          ),
        ),
      );
    });
  }

  Widget successDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
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
              Text(
                "Congratulations!",
                style: w700_22a(color: AppColor.c2C2A2A),
              ),
              Text(
                "Your Reward Has Been\nSuccessfully Redeemed!",
                textAlign: TextAlign.center,
                style: w400_16p(),
              ),
              30.heightSizeBox,
            ],
          ),
        ),
      ],
    );
  }

  Widget scanDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        37.heightSizeBox,

        Text("Redeem Wash!", style: w700_22a(color: AppColor.c2C2A2A)),
        Text(
          "Scan Your QR Code to\nEnjoy Your Wash.",
          style: w400_16p(color: AppColor.c455A64),
          textAlign: TextAlign.center,
        ),

        15.heightSizeBox,
        GestureDetector(
          onTap: () {
            Get.back();
            showDialog(
              barrierDismissible: false,
              context: Get.context!,
              builder: (BuildContext context) {
                return AppDialog(
                  padding: EdgeInsets.zero,

                  child: successDialog(),
                );
              },
            );
          },
          child: Image.asset(Assets.imagesImQr, height: 261, width: 261),
        ),

        46.heightSizeBox,
      ],
    );
  }
}

/*
Widget bottomSheet() {
  return Expanded(
    child: SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(Get.context!).viewInsets.bottom,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              Text(
                "See All Exclusive Offers.",
                style: w700_16a(color: AppColor.c2C2A2A),
              ),

              27.heightSizeBox,
              OfferCardWidget(padding: EdgeInsets.symmetric(horizontal: 20)),
              25.heightSizeBox,
              GestureDetector(
                onTap: () {
                  rewardController.isVisible.value =
                  !rewardController.isVisible.value;
                },
                child: Container(
                  width: 158,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                  decoration: BoxDecoration(
                    //color: AppColor.c5C6B72.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: AppColor.c5C6B72.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Obx(
                            () => Text(
                          rewardController.sortByText.value,
                          style: w400_12p(color: AppColor.c2C2A2A),
                        ),
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
              ),
              25.heightSizeBox,
              Column(
                children: [
                  Obx(() {
                    final List<Offers> data =
                        rewardController
                            .offerResponseModel
                            .value
                            ?.data
                            ?.offers ??
                            [];

                    if (data == null) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return data.isNotEmpty
                        ? GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          left: 16,
                          right: 15,
                          bottom: 60
                      ),
                      clipBehavior: Clip.hardEdge,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.back();
                            rewardController.getOffersById(
                              data[index].id!,
                            );
                            showModalBottomSheet(
                              context: Get.context!,
                              isScrollControlled: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return CustomBottomSheet(
                                  child:
                                  viewOfferDetailBottomSheet(),
                                );
                              },
                            );
                          },
                          child: OffersGridContainer(
                            offer: data[index],
                          ),
                        );
                      },
                    )
                        : Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        'Data is not found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
          Obx(
                () =>
            rewardController.isVisible.value
                ? Positioned(
              top: Get.height / 2.99,
              child: Container(
                alignment: Alignment.center,

                width: 180,
                height: 110,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                //   color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        rewardController.toggleSortOrder();
                        rewardController.isVisible.value =
                        false; // Hide popup
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Ascending order"),
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        rewardController.toggleSortOrder();
                        rewardController.isVisible.value =
                        false; // Hide popup
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Descending order"),
                      ),
                    ),
                  ],
                ),
              ),
            )
                : Container(),
          ),
        ],
      ),
    ),
  );
}*/
