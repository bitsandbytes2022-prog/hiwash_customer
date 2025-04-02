import 'package:flutter/material.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_anybody.dart';

class OffersGridContainer extends StatelessWidget {
  const OffersGridContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColor.c5C6B72.withOpacity(0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              //margin: EdgeInsets.only(top: 10, right: 10),
              padding: EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: AppColor.cF6DBE2,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '0:1 HRS - 15 MINS',
                style: w500_7a(color: AppColor.cC31848),
              ),
            ),
          ),

          Image.asset(
            Assets.imagesDemo2,
            height: 87,
            fit: BoxFit.cover,
          ),
          Text(
            "Flat 30% off",
            style: w900_14a(color: AppColor.c2C2A2A),
          ),
        ],
      ),
    );
  }
}
