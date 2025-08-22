import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/network_manager/local_storage.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_poppins.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/components/doted_horizontal_line.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../rate_partner/view/rate_partner_screen.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHomeBg(
      headingText: StringConstant.kLanguage.tr,
      iconRight: SizedBox(),
      child: Column(
        children: [
          15.heightSizeBox,
          countryRow(
            title: '🇸🇦 ${"العربية"}',
            languageCode: 'ar',
            countryCode: 'SA',
          ),
          countryRow(
            title: '🇬🇧 English',
            languageCode: 'en',
            countryCode: 'US',
          ),
        ],
      ),
    );
  }

  Widget countryRow({
    required String title,
    required String languageCode,
    required String countryCode,
  }) {
    return GestureDetector(
      onTap: () async {
         Locale selectedLocale = Locale(languageCode, countryCode);
        await LocalStorage().saveLocale(languageCode);
        Get.updateLocale(selectedLocale);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [Text(title, style: w500_18p(color: AppColor.c6B6B6B))],
            ),
          ),
          20.heightSizeBox,
          DotedHorizontalLine(),
          20.heightSizeBox,
        ],
      ),
    );
  }
}
