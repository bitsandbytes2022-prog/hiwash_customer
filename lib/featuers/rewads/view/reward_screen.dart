import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/widgets/components/doted_line.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_button.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/app_dialog.dart';
import '../../../widgets/components/common_offer_bottom_sheet.dart';
import '../../../widgets/components/custom_bottomsheet.dart';
import '../../../widgets/components/date_time_widget.dart';
import '../../../widgets/components/doted_horizontal_line.dart';
import '../../../widgets/components/offers_grid_container.dart';
import '../../../widgets/components/profile_image_container.dart';
import '../../subscription/widgets/offer_card.dart';
import '../controller.dart';
import '../model/offer_response_model.dart';

class RewardScreen extends StatelessWidget {
  RewardScreen({super.key});

  RewardController rewardController = Get.put(RewardController());

  @override
  Widget build(BuildContext context) {
    rewardController.getAllOffers();
    rewardController.getOfferCategoriesMethod();
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              15.heightSizeBox,
              exclusiveOffer(),
              Obx(() {
                final List<Offers> data =
                    rewardController.offerResponseModel.value?.data?.offers ??
                    [];

                return data.isEmpty
                    ? Container(
                      padding: EdgeInsets.only(top: 150),
                      child: CircularProgressIndicator(),
                    )
                    : data.isNotEmpty
                    ? GridView.builder(
                      padding: EdgeInsets.only(bottom: 40),
                      shrinkWrap: true,
                      clipBehavior: Clip.hardEdge,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return OffersGridContainer(offer: data[index]);
                      },
                    )
                    : Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget exclusiveOffer() {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          width: Get.width,
          decoration: BoxDecoration(
            color: AppColor.cC31848,
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(Assets.imagesSubscriptionBg),
              fit: BoxFit.cover,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.cC31848.withOpacity(0.30),
                spreadRadius: 0,
                blurRadius: 15,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              17.heightSizeBox,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Explore All Exclusive Offers",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rumRaisin(
                    fontWeight: FontWeight.w400,
                    fontSize: 24,
                    color: AppColor.white,
                  ),
                ),
              ),
              13.heightSizeBox,
              GestureDetector(
                onTap: () {
                  print("888888888888------>");
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
                      return  BottomSheetWidget(
                        isVisible: true,

                      );
                    },

                  );
               // Get.back();
                },
                child: Container(
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColor.c142293,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: AppColor.white.withOpacity(.50),
                      width: 1.5,
                    ),
                  ),
                  child: Text(
                    "Check Now",
                    style: w600_14a(color: AppColor.white),
                  ),
                ),
              ),
              24.heightSizeBox,
            ],
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          child: ImageView(height: 68, width: 100, path: Assets.imagesCar),
        ),
        Positioned(
          bottom: 15,
          right: 0,
          child: ImageView(height: 71, width: 87, path: Assets.imagesJackpot),
        ),
      ],
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

  /*  Widget dropDownRow(String? title, VoidCallback onTap) {
    RxInt select = 0.obs;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            10.heightSizeBox,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title ?? "".tr, style: w600_12a(color: AppColor.c2C2A2A)),
                  ImageView(path: Assets.iconsIcDropDown, height: 6, width: 10),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: Text(" hjjsfdg guwejfguwj biewutyruywjh bvdujewgdjws gvdhwegfuw gwde7uwegje. nedbuewgdjen. egdujebnh eguejg egdvefnqew bvdwhefv "),
            ),
            10.heightSizeBox,
          ],
        ),
      ),
    );
  }*/

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
}
