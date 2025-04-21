import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/rewads/controller.dart';
import 'package:hiwash_customer/featuers/rewads/model/offer_response_model.dart';
import 'package:hiwash_customer/widgets/components/date_time_widget.dart';
import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';
import '../../widgets/sized_box_extension.dart';

class OffersGridContainer extends StatelessWidget {
  final Data offer;

  OffersGridContainer({super.key, required this.offer});

  final RewardController rewardController = Get.find();

  @override
  Widget build(BuildContext context) {
    final String imageUrl = (offer.image != null && offer.image!.isNotEmpty)
        ? offer.image!
        : '';

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.c5C6B72.withOpacity(0.4)),
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
            child: DateTimeWidget(
              title: rewardController.timeUntilExpiry(
                  offer.expiryDate ?? "No Expiry"),
            ),
          ),
          Spacer(),
          Text(
            "${offer.discountValue ?? 0}% Off",
            style: w900_14a(color: AppColor.c2C2A2A),
          ),
        ],
      ),
    );
  }
}
/*
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.c5C6B72.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: DateTimeWidget(
              title: rewardController.timeUntilExpiry(offer.expiryDate ?? "No Expiry"),
            ),
          ),
          Image(
            image: (offer.image != null && offer.image!.isNotEmpty)
                ? NetworkImage(offer.image!)
                : AssetImage(Assets.imagesImOffer),
            fit: BoxFit.cover,
          ),

          5.heightSizeBox,
          Text(
            "${offer.discountValue ?? 0}% Off",
            style: w900_14a(color: AppColor.c2C2A2A),
          ),
        ],
      ),
    );
  }
}*/
