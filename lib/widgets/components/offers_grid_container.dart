import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/rewads/controller.dart';
import 'package:hiwash_customer/featuers/rewads/model/offer_response_model.dart';
import '../../generated/assets.dart';
import '../../styling/app_color.dart';

import '../../styling/app_font_anybody.dart';
import 'countdown_else_full_date.dart';
class OffersGridContainer extends StatelessWidget {
  final Offers offer;

  OffersGridContainer({super.key, required this.offer});

  final RewardController rewardController = Get.find();

  @override
  Widget build(BuildContext context) {
    final String imageUrl = (offer.image != null && offer.image!.isNotEmpty)
        ? offer.image!
        : '';

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
         /*   border: Border.all(
              color: offer.isUsed == 1
                  ? AppColor.red.withOpacity(0.4)
                  : AppColor.c5C6B72,
              width: 1,
            ),*/
            image: DecorationImage(
              image: imageUrl.isNotEmpty
                  ? NetworkImage(imageUrl)
                  : AssetImage(Assets.imagesImOffer) as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CountdownElseFullDate(
                  expiryDateStr: offer.expiryDate ?? '',
                ),
              ),
              if (offer.totalQty != null && offer.totalQty! > 1)
                Container(
                  margin: EdgeInsets.only(top: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColor.cC7F6E5,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "${(offer.totalQty)!-(offer.totalRedeemed??0)} Vouchers",
                    style: w500_7a(color: AppColor.c1F9D70),
                  ),
                )

              /*   Container(
                margin: EdgeInsets.only(top: 3),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColor.cC7F6E5,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text("${offer.qty.toString() ?? ''} Vouchers", style: w500_7a(color: AppColor.c1F9D70)),
              ),*/

            ],
          ),
        ),
        if (offer.isUsed == 1)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
      ],
    );
  }
}



