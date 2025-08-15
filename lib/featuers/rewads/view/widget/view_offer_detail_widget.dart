import 'package:cached_network_image/cached_network_image.dart' show CachedNetworkImage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hiwash_customer/featuers/rewads/controller.dart';
import 'package:hiwash_customer/featuers/rewads/view/widget/widgets.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/styling/app_font_poppins.dart';
import 'package:hiwash_customer/widgets/components/countdown_or_date_timer.dart';
import 'package:hiwash_customer/widgets/components/doted_line.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/components/profile_image_container.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import 'package:cached_network_image/cached_network_image.dart';


class OfferDetailBottomSheet extends StatelessWidget {
  final RewardController rewardController = Get.find();

  OfferDetailBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final rewardDetail = rewardController.getOffersByIdModel.value?.offerDetailList?.first;

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
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: AppColor.c2C2A2A.withOpacity(0.2)),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: CachedNetworkImage(
                          height: 120,
                          width: Get.width,
                          fit: BoxFit.fitWidth,
                          imageUrl: (rewardController.getOffersByIdModel.value?.offerDetailList?.first.bannerImageUrl?.isNotEmpty ?? false)
                              ? rewardController.getOffersByIdModel.value!.offerDetailList!.first.bannerImageUrl!
                              : Assets.imagesImOffer,
                          placeholder: (context, url) => const Center(
                            child: SizedBox(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(strokeWidth: 2,color: Colors.blue,),
                            ),
                          ),
                          errorWidget: (context, url, error) => Image.asset(
                            Assets.imagesImOffer,
                            height: 187,
                            width: Get.width,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileImageView(
                        radius: 20,
                        imagePath: rewardController.getOffersByIdModel.value?.offerDetailList?.first.businessImageUrl ?? "",
                        isVisibleStack: false,
                      ),
                      5.widthSizeBox,
                      Container(
                        padding: const EdgeInsets.only(top: 5),
                        alignment: Alignment.center,
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              rewardController.getOffersByIdModel.value?.offerDetailList?.first.businessName ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: w600_14a(color: AppColor.c2C2A2A),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ImageView(
                                  path: Assets.iconsIcPlaceMarker,
                                  height: 18,
                                  width: 18,
                                ),
                                Expanded(
                                  child: Text(
                                    rewardController.getOffersByIdModel.value?.offerDetailList?.first.businessAddress ?? "",
                                    style: w400_10p(color: AppColor.c455A64),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const DashedLineWidget(),

                15.heightSizeBox,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rewardDetail?.title ?? '', style: w700_16a(color: AppColor.c2C2A2A)),
                      Text(rewardDetail?.description ?? '', style: w400_12p()),
                      29.heightSizeBox,
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 110),
                            child: ImageView(
                              path: Assets.imagesCloudBg,
                              height: 150,
                              width: Get.width,
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            child: GestureDetector(
                              onTap: () {},
                              child: Builder(
                                builder: (_) {
                                  final base64String = rewardController.getOffersByIdModel.value?.offerDetailList?.first.qRCodeUrl;
                                  print("QR BASE64 big image: $base64String");
                                  return Base64ImageWidget(
                                    base64String: base64String,
                                    height: 230,
                                    width: 230,
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      CountdownOrDateTimer(
                        expiryDateStr: rewardController.getOffersByIdModel.value?.offerDetailList?.first.expiryDate ?? '',
                      ),
                      10.heightSizeBox,
/*
                      Text("${rewardController.getOffersByIdModel.value?.offerDetailList?.first.qty.toString()??''} Vouchers available", style: w400_14a(color: AppColor.c2C2A2A)),
*/
                      if ((rewardController.getOffersByIdModel.value?.offerDetailList?.first.qty ?? 0) > 0)
                        Text(
                          "${rewardController.getOffersByIdModel.value?.offerDetailList?.first.qty} Vouchers available",
                          style: w400_14a(color: AppColor.c2C2A2A),
                        ),
                      if ((rewardController.getOffersByIdModel.value?.offerDetailList?.first.redeemed ?? 0) != 0)
                        Text(
                          "Redeemed ${rewardController.getOffersByIdModel.value?.offerDetailList?.first.redeemed} available",
                          style: w400_12a(
                            color: AppColor.c2C2A2A.withOpacity(0.7),
                          ),
                        ),

                      10.heightSizeBox,
                      Container(
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColor.c142293.withOpacity(0.20)),
                        ),
                        child: Column(
                          children: [
                            5.heightSizeBox,
                            dropDownRow(
                              index: 0,
                              title: StringConstant.kOfferDetails.tr,
                              content: rewardDetail?.offerDetails ?? '',
                            ),
                            Divider(color: AppColor.c142293.withOpacity(0.20)),
                            dropDownRow(
                              index: 1,
                              title: StringConstant.kHowToRedeem.tr,
                              content: rewardDetail?.howToRedeem ?? '',
                            ),
                            Divider(color: AppColor.c142293.withOpacity(0.20)),
                            dropDownRow(
                              index: 2,
                              title: StringConstant.kTermsAndCondition.tr,
                              content: rewardDetail?.termsAndConditions ?? '',
                            ),
                            5.heightSizeBox,
                          ],
                        ),
                      ),
                      25.heightSizeBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageView(height: 18, width: 18, path: Assets.imagesIcInfo),
                          3.widthSizeBox,
                          Text(StringConstant.kReportAnIssue.tr, style: w600_12a(color: AppColor.c142293)),
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

  Widget dropDownRow({required int index, required String? title, required String content}) {
    return Obx(() {
      final isExpanded = rewardController.selectedDropDownIndex.value == index;

      return GestureDetector(
        onTap: () {
          rewardController.selectedDropDownIndex.value = isExpanded ? -1 : index;
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
                      path: isExpanded ? Assets.iconsIcUpWardArrow : Assets.iconsIcDropDown,
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
}


