
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/auth/view/auth_controller/auth_controller.dart';
import 'package:hiwash_customer/widgets/components/app_bg.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_text_field.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../widgets/components/bottom_sheet_bg.dart';
import '../../../widgets/components/hi_wash_button.dart';
import 'auth_widgets/bg_widget.dart';
import 'auth_widgets/or_widget.dart';
import 'auth_widgets/social_media.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  AuthController controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      body: AppBg(
        headingText: "kWelcomeBack".tr,
        subText: "kLogin".tr,
      showBackButton: false,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              114.heightSizeBox,
              HiWashTextField(
                keyboardType: TextInputType.emailAddress,

                hintText: "kEmail".tr,
                labelText: "kEmail".tr,

                validator: (value) {
                  return controller.validateEmail(value);
                },
              ),
              24.heightSizeBox,
              HiWashTextField(
                keyboardType: TextInputType.visiblePassword,
                hintText: "kPassword".tr,
                labelText: "kPassword".tr,

                validator: (value) {
                  return controller.validatePassword(value);
                },
              ),
              12.heightSizeBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteStrings.forgotPasswordScreen);
                    },
                    child: Text(
                      "kForgotPassword".tr,
                      style: w500_14a(color: AppColor.red),
                    ),
                  ),
                ],
              ),
              24.heightSizeBox,
              HiWashButton(
                text: "kLogIn".tr,
                onTap: () {
                  //Get.offNamed(RouteStrings.dashboardScreen);
                    if (formKey.currentState?.validate() ?? false) {


                  Get.offNamed(RouteStrings.dashboardScreen);
                  }
                },
              ),
              54.heightSizeBox,

              Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "kDontAaveAccount".tr,
                        style: w400_12a(color: AppColor.c455A64),
                      ),
                      TextSpan(
                        text: "SIGNUP".tr,
                        style: w500_14a(color: AppColor.red),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAllNamed(RouteStrings.signUpScreen);
                                print("Sign Up tapped");
                              },
                      ),
                    ],
                  ),
                ),
              ),
              18.heightSizeBox,
              OrDivider(),
              18.heightSizeBox,
              SocialMedia(),
              60.heightSizeBox,
            ],
          ),
        ),
      ),


    );
  }
}
