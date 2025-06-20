import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/rewads/controller.dart';
import 'package:hiwash_customer/featuers/rewads/model/offer_response_model.dart';
import '../../generated/assets.dart';
import '../../styling/app_color.dart';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: CountdownElseFullDate(
                  expiryDateStr: offer.expiryDate ?? '',
                ),
              ),
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



