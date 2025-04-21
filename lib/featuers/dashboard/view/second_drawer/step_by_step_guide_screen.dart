import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/dashboard/view/second_drawer/second_drawer_controller/second_drawer_controller.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_poppins.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/components/doted_horizontal_line.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

class StepByStepGuideScreen extends StatelessWidget {
  StepByStepGuideScreen({super.key});

  SecondDrawerController secondDrawerController = Get.find();

  @override
  Widget build(BuildContext context) {
    secondDrawerController.getGuides();

    return AppHomeBg(
        padding: EdgeInsets.zero,
        headingText: "Step-by-Step Guide",
        iconRight: SizedBox(),
        child: Column(
          children: [
            15.heightSizeBox,
            ListView.separated(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),

              shrinkWrap: true,
              itemCount: secondDrawerController.guidesResponseModel.value?.data
                  ?.length ?? 0,

              separatorBuilder: (context, index) {
                print("hjgjh=====>${secondDrawerController.guidesResponseModel.value?.data
                    ?.length ?? 0}");
                return  DotedHorizontalLine();
              },
              itemBuilder: (context, index) {
                final item = secondDrawerController.guidesResponseModel.value?.data?[index];
                return countryRow(
                  title: item?.category ?? "",
                  description: item?.description ?? "",
                );
              },
            )



          ],
        )
    );
  }

  countryRow({required String title,required String description}) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(RouteStrings.stepByStepGuideDetailScreen, arguments: {
          'title': title,
          'description': description,
        });
      },
      child: Container(
        margin: EdgeInsets.only(top: 5,bottom: 5),
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(title, style: w500_14p(color: AppColor.c2C2A2A),),
              ImageView(

                path: Assets.iconsBlackForwardArrow,
                height: 10,
                width: 8,
              )

            ],
          ),
        ),
      ),
    );
  }
}
