import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../../styling/app_font_poppins.dart';

class StepByStepGuideDetailScreen extends StatelessWidget {
  const StepByStepGuideDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments ?? {};
    final String title = args['title'] ?? StringConstant.kNoTitle.tr;
    final String description = args['description'] ?? StringConstant.kNoDescription.tr;

    return AppHomeBg(


      headingText: StringConstant.kStepByStepGuideDetail.tr,
      iconRight: SizedBox(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            15.heightSizeBox,
            Text(title.trim().tr, style: w600_16p()),
            10.heightSizeBox,
            Text(description.trim().tr, style: w400_14p()),
          ],
        ),
      ),
    );
  }
}
