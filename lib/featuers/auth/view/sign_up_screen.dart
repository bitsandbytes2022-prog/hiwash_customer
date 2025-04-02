import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/auth/view/auth_controller/auth_controller.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/widgets/components/app_bg.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../widgets/components/bottom_sheet_bg.dart';
import '../../../widgets/components/hi_wash_button.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import 'auth_widgets/or_widget.dart';
import 'auth_widgets/social_media.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  AuthController controller =
      Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(
        headingText: "kHello".tr,
        subText: "SignUp".tr,
        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            130.heightSizeBox,
            HiWashTextField(
              keyboardType: TextInputType.name,
              hintText: "kName".tr,
              labelText: "kEnterYourFullName".tr,
            ),
            20.heightSizeBox,
            HiWashTextField(
              keyboardType: TextInputType.emailAddress,
              hintText: "kEmail".tr,
              labelText: "kEnterYourEmail".tr,
            ),
            20.heightSizeBox,
            HiWashTextField(
              keyboardType: TextInputType.phone,
              hintText: "kPhone".tr,
              labelText: "kEnterPhoneNumber".tr,
            ),
            20.heightSizeBox,
            HiWashTextField(
              keyboardType: TextInputType.visiblePassword,
              hintText: "kPassword".tr,
              labelText: "kPassword".tr,
              obscure: true,
              obscuringCharacter: "*",
            ),
            20.heightSizeBox,
            HiWashTextField(
              hintText: "kConfirmPassword".tr,
              labelText: "kConfirmPassword".tr,
              obscure: true,
              obscuringCharacter: '*',
            ),

            35.heightSizeBox,

            HiWashButton(
              text: "signUp".tr,
              onTap: () {
                Get.toNamed(RouteStrings.subscriptionScreen);
              },
            ),
            25.heightSizeBox,
            Center(
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "Already have an account ",
                      style: w400_12a(color: AppColor.c455A64),
                    ),
                    TextSpan(
                      text: 'LOGIN',
                      style: w500_14a(color: AppColor.red),
                      recognizer:
                          TapGestureRecognizer()
                            ..onTap = () {
                              Get.offAllNamed(RouteStrings.loginScreen);
                              print("Sign Up tapped");
                            },
                    ),
                  ],
                ),
              ),
            ),
            40.heightSizeBox,
            OrDivider(),
            18.heightSizeBox,
            SocialMedia(),
            60.heightSizeBox,
          ],
        ),
      ),
    );
  }
}
