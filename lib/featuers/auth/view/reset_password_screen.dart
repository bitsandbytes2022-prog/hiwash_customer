import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/app_bg.dart';
import '../../../widgets/components/hi_wash_button.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import 'auth_controller/auth_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key});

  AuthController controller =
      Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        headingText: "kReset".tr,
        subText: 'kPassword'.tr,
        child: Column(
          children: [
            110.heightSizeBox,
            Text(
              "kCreateNewPassword".tr,
              style: w700_22a(color: AppColor.c2C2A2A),
            ),
            14.heightSizeBox,
            Text(
              "kYourNewPasswordMust".tr,
              textAlign: TextAlign.center,
              style: w400_12p(color: AppColor.c455A64),
            ),
            23.heightSizeBox,
            HiWashTextField(
              hintText: "kPassword".tr,
              labelText: "kPassword".tr,
              obscure: true,
              obscuringCharacter: '*',
            ),
            12.heightSizeBox,
            HiWashTextField(
              hintText: "kConfirmPassword".tr,
              labelText: "kConfirmPassword".tr,
              obscure: true,
              obscuringCharacter: '*',
            ),
            105.heightSizeBox,
            HiWashButton(
              text: 'kSave'.tr,
              onTap: () {
                Get.offNamedUntil(RouteStrings.loginScreen, (route) => false);
              },
            ),

            60.heightSizeBox,
          ],
        ),
      ),
    );
  }
}
