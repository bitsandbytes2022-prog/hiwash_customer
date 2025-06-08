import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/profile/controller/drawer_profile_controller.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import '../../../widgets/components/app_home_bg.dart';

class TermsAndConditionScreen extends StatelessWidget {
   TermsAndConditionScreen({super.key});
  DrawerProfileController drawerProfileController=Get.find();
  @override
  Widget build(BuildContext context) {
    drawerProfileController.getTermsAndConditions();

    return AppHomeBg(
      headingText: StringConstant.kTermsAndCondition.tr,
      iconRight: SizedBox(),

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

            15.heightSizeBox,
            Obx(
               () {
                return Text(drawerProfileController.termsAndConditionsResponseModel.value?.data?.first.content??"".tr,);
              }
            )]),
    );
  }
}
