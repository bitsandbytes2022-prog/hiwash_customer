import 'package:flutter/material.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_poppins.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/components/doted_horizontal_line.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHomeBg(

      headingText: "Language",
      iconRight:SizedBox(),
      child: Column(
        children: [
          15.heightSizeBox,
          countryRow(title: '🇸🇦 Arabic'),
          countryRow(title: '🇬🇧 English'),


        ],
      )
    );
  }

  countryRow({required String title}){
    return Column(
      children: [
        Row(
        children: [

          Text(title,style: w400_13p(color: AppColor.c6B6B6B),)
        ],
        ),
        12.heightSizeBox,
        DotedHorizontalLine(),
        12.heightSizeBox,

      ],
    );
  }
}
