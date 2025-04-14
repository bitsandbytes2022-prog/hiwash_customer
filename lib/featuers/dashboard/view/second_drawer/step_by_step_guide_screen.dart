import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_poppins.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/components/doted_horizontal_line.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

class StepByStepGuideScreen extends StatelessWidget {
  const StepByStepGuideScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return AppHomeBg(
padding: EdgeInsets.zero,
        headingText: "Step-by-Step Guide",
        iconRight:SizedBox(),
        child: Column(
          children: [
            15.heightSizeBox,
            countryRow(title: 'Booking or Wash Issues'),


          ],
        )
    );
  }

  countryRow({required String title}){
    return GestureDetector(
      onTap: (){
        Get.toNamed(RouteStrings.stepByStepGuideDetailScreen);
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Text(title,style: w500_14p(color: AppColor.c2C2A2A),),
                ImageView(

                  path: Assets.iconsBlackForwardArrow,
                  height: 10,
                  width: 8,
                )

              ],
            ),
          ),
          12.heightSizeBox,
          DotedHorizontalLine(),
          12.heightSizeBox,

        ],
      ),
    );
  }
}
