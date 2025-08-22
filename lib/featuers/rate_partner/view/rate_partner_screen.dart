import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/app_dialog.dart';
import '../controller/rate_partner_controller.dart';

showRatingDialog(String id) {
  final RatePartnerController controller = Get.put(RatePartnerController());

  showDialog(
    barrierDismissible: false,
    context: Get.context!,
    builder: (BuildContext context) {
      return AppDialog(
        padding: EdgeInsets.zero,
        bottomVisible: false,
        remainingTextBottom: '',
        child: successDialog(controller, id),
      );
    },
  );
}

Widget successDialog(RatePartnerController controller, String id) {
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
                      path: Assets.imagesImSuccess,
                      width: Get.width,
                      fit: BoxFit.contain,
                      height: 180,
                    ),
                  ),
                ],
              ),
            ),
            21.heightSizeBox,
            Text(
              StringConstant.kOfferRedeemed.tr,
              style: w700_22a(color: AppColor.c2C2A2A),
            ),
            Text(
              StringConstant.kSharePartnerFeedback.tr,
              textAlign: TextAlign.center,
              style: w400_16p(),
            ),
            9.heightSizeBox,
            Obx(()=>RatingStars(
              value: controller.userRating.value.toDouble(),
              onValueChanged: (v) {
                controller.userRating.value = v.toInt();

              },
              starBuilder:
                  (index, color) => Icon(Icons.star, color: color, size: 28),
              starCount: 5,
              starSize: 28,
              valueLabelVisibility: false,
              starColor: AppColor.cFFC200,
              starOffColor: Colors.grey,

              animationDuration: Duration(milliseconds: 200),
              starSpacing: 2,
            )),

            15.heightSizeBox,

            TextFormField(
              controller: controller.commentController,
              maxLines: 3,
              style: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.9)),
              decoration: InputDecoration(
                fillColor: AppColor.white,
                hintText: StringConstant.kEnterYourCommentHere.tr,
                filled: true,
                labelStyle: w400_13a(color: AppColor.c455A64),
                hintStyle: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.40)),
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
                final ratingString = controller.userRating.toString();
                controller.rateOffer(ratingString, id).then((value) {
                  if (value != null && value) {
                    controller.commentController.clear();
                    controller.userRating = 0.obs;

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
                child: Text(
                  StringConstant.kSubmit.tr,
                  style: w500_14a(color: AppColor.white),
                ),
              ),
            ),

            18.heightSizeBox,
          ],
        ),
      ),
    ],
  );
}
