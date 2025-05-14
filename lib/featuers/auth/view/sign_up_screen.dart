import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/widgets/components/app_bg.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../widgets/components/bottom_sheet_bg.dart';
import '../../../widgets/components/hi_wash_button.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import '../auth_controller/auth_controller.dart';
import 'auth_widgets/or_widget.dart';
import 'auth_widgets/social_media.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  AuthController authController =
      Get.isRegistered<AuthController>()
          ? Get.find<AuthController>()
          : Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final phoneNumberSignUp = Get.arguments;

    String? phoneNumberString;
    if (phoneNumberSignUp is String) {
      phoneNumberString = phoneNumberSignUp;
    } else if (phoneNumberSignUp is int) {
      phoneNumberString = phoneNumberSignUp.toString();
    } else {
      phoneNumberString = null;
    }

    if (phoneNumberString != null) {
      authController.phoneController.text = phoneNumberString;
    } else {
      authController.phoneController.text = '';
    }
    return Scaffold(
      body: AppBg(
        headingText: "kHello".tr,
        subText: "SignUp".tr,
        showBackButton: false,
        heading: false,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              80.heightSizeBox,
              HiWashTextField(
                textCapitalization: TextCapitalization.sentences,

                controller: authController.nameController,
                keyboardType: TextInputType.name,
                labelText: "kName".tr,
                hintText: "kEnterYourFullName".tr,
                validator: (value) {
                  return authController.validateName(value);
                },
              ),
              20.heightSizeBox,
              HiWashTextField(
                controller: authController.emailSignUpController,
                keyboardType: TextInputType.emailAddress,
                labelText: "kEmail".tr,
                hintText: "kEnterYourEmail".tr,
                validator: (value) {
                  return authController.validateEmail(value);
                },
              ),
              20.heightSizeBox,
              HiWashTextField(
                controller: authController.phoneController,
                keyboardType: TextInputType.phone,
                labelText: "kPhone".tr,
                hintText: "kEnterPhoneNumber".tr,
                validator: (value) {
                  return authController.validatePhoneNumber(value);
                },
              ),
              20.heightSizeBox,
              HiWashTextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z0-9 .,@#&/\-':()+=]"),
                  ),
                ],
                keyboardType: TextInputType.text,
                controller: authController.zoneController,
                hintText: "Zone".tr,
                labelText: "Zone".tr,
                /*   obscure: true,
                obscuringCharacter: "*",
                validator: (value) {
                  return authController.validatePassword(value);
                },*/
              ),
              20.heightSizeBox,
              HiWashTextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z0-9 .,@#&/\-':()+=]"),
                  ),
                ],
                keyboardType: TextInputType.text,
                controller: authController.streetController,
                hintText: "Street".tr,
                labelText: "Street".tr,
              ),
              20.heightSizeBox,
              HiWashTextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z0-9 .,@#&/\-':()+=]"),
                  ),
                ],
                keyboardType: TextInputType.text,
                controller: authController.buildingController,
                hintText: "Building".tr,
                labelText: "Building".tr,
              ),
              20.heightSizeBox,
              HiWashTextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z0-9 .,@#&/\-':()+=]"),
                  ),
                ],
                controller: authController.unitController,
                hintText: "Unit".tr,
                labelText: "Unit".tr,
              ),

              35.heightSizeBox,

              Obx(
                () => HiWashButton(
                  isLoading: authController.isLoading.value,
                  text: "signUp".tr,
                  onTap: () {
                    String enteredPhone =
                        authController.phoneController.text.trim();

                    if (phoneNumberSignUp != null &&
                        phoneNumberSignUp != enteredPhone) {
                      Get.snackbar(
                        "Phone Number Changed",
                        "You have changed the phone number from the original one.",
                        backgroundColor: Colors.orangeAccent,
                        colorText: Colors.white,
                      );
                    }
                    // Get.toNamed(RouteStrings.dashboardScreen);
                    if (formKey.currentState?.validate() ?? false) {
                      authController
                          .signUp(
                            authController.nameController.text.trim(),
                            authController.phoneController.text.trim(),
                            authController.emailSignUpController.text.trim(),
                            authController.zoneController.text.trim(),
                            authController.streetController.text.trim(),
                            authController.buildingController.text.trim(),
                            authController.unitController.text.trim(),
                          )
                          .then((value) {
                            if (value != null) {
                              String phoneNumber =
                                  authController.phoneController.text.trim();
                              authController
                                  .sendOtp(phoneNumber)
                                  .then((otpValue) {
                                    if (otpValue != null) {
                                      Get.toNamed(
                                        RouteStrings.otpScreen,
                                        arguments: phoneNumber,
                                      );
                                      authController.phoneController.clear();
                                    }
                                  })
                                  .catchError((error) {
                                    print("Error during OTP sending: $error");
                                  });
                            }
                          });
                    }
                  },
                ),
              ),
              45.heightSizeBox,
              Center(
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Have an account? ",
                        style: w400_12a(color: AppColor.c455A64),
                      ),
                      TextSpan(
                        text: 'LOGIN',
                        style: w500_14a(color: AppColor.red),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(RouteStrings.loginScreen);
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
              30.heightSizeBox,
            ],
          ),
        ),
      ),
    );
  }
}
