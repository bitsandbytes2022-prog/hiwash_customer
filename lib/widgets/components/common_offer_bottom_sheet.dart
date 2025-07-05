import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/widgets/components/profile_image_container.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../featuers/rewads/controller.dart';
import '../../featuers/rewads/model/offer_response_model.dart';
import '../../featuers/rewads/view/widget/view_offer_detail_widget.dart'
    show OfferDetailBottomSheet;
import '../../featuers/rewads/view/widget/widgets.dart';
import '../../featuers/subscription/widgets/offer_card.dart';
import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';
import '../../styling/app_font_poppins.dart';
import 'app_dialog.dart';
import 'countdown_or_date_timer.dart';
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
      height: Get.height / 1.1,
      width: Get.width,
      decoration: BoxDecoration(
        color: AppColor.cF6F7FF,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              21.heightSizeBox,
              Text(
                StringConstant.kSeeAllExclusiveOffers.tr,
                style: w700_16a(color: AppColor.c2C2A2A),
              ),

              27.heightSizeBox,
              OfferCardWidget(
                padding: EdgeInsets.symmetric(horizontal: 20),
                onTapOne: () => rewardController.filterByCategory(0),
                onTapTwo: () => rewardController.filterByCategory(1),
                onTapThree: () => rewardController.filterByCategory(2),
              ),

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
                          rewardController.sortByText.value.tr,
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

              Expanded(
                child: Obx(() {
                  final List<Offers> data =
                      rewardController.filteredOffers.isNotEmpty
                          ? rewardController.filteredOffers
                          : rewardController
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
                        // physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async {
                              if (isVisible) {
                                Get.back();
                                await rewardController.getOffersById(
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
                                      child: OfferDetailBottomSheet(),
                                    );
                                  },
                                );
                              }
                            },
                            child: OffersGridContainer(
                              /// key to force rebuild
                              key: ValueKey(data[index].expiryDate),
                              offer: data[index],
                            ),
                          );
                        },
                      )
                      : Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Text(
                          StringConstant.kDateIsNotFound.tr,
                          style: TextStyle(fontSize: 18, color: Colors.black),
                        ),
                      );
                }),
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
                                child: Text(StringConstant.kAscendingOrder.tr),
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
                                child: Text(StringConstant.kDescendingOrder.tr),
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
                rewardController.sortByText.value =
                    StringConstant.kSortByExpiry.tr;
                rewardController.isAscending.value = true;
                rewardController.applySortingToCurrentData();
                rewardController.clearCategoryFilter();
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
                StringConstant.kCongratulations.tr,
                style: w700_22a(color: AppColor.c2C2A2A),
              ),
              Text(
                StringConstant.kYourRewardHasBeen.tr,
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
