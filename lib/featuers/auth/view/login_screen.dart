import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hiwash_customer/widgets/components/app_bg.dart';
import 'package:hiwash_customer/widgets/components/app_snack_bar.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_text_field.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../language/String_constant.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../widgets/components/bottom_sheet_bg.dart';
import '../../../widgets/components/hi_wash_button.dart';
import '../auth_controller/auth_controller.dart';
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
        headingText: StringConstant.kWelcomeBack.tr,
        subText: StringConstant.kLogin.tr,

        showBackButton: true,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              114.heightSizeBox,
              HiWashTextField(
                controller: controller.loginPhoneController,
                keyboardType: TextInputType.phone,

                hintText: StringConstant.kPhone.tr,
                labelText: StringConstant.kPhone.tr,

                validator: (value) {
                  return controller.validatePhoneNumberLogin(value);
                },
              ),

              54.heightSizeBox,
              Obx(() {
                return HiWashButton(
                  isLoading: controller.isLoading.value,
                  text: StringConstant.kLogIn.tr,
                  onTap: () {
                    if (formKey.currentState?.validate() ?? false) {
                      String phoneNumber = controller.loginPhoneController.text.trim();
                      controller.sendOtp(phoneNumber).then((value) {
                        if (value != null) {
                           Get.toNamed(
                            RouteStrings.loginOtpScreen,
                            arguments: phoneNumber,
                          );
                          controller.loginPhoneController.clear();
                        }
                      }).catchError((error) {
                        print("Error during OTP sending: $error");
                      });
                    }
                  },
                );
              }),


              54.heightSizeBox,

              OrDivider(),
              18.heightSizeBox,
              SocialMedia(
                googleTap: () async {
                  try {

                    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
                    if (googleUser == null) {
                      print("Google sign-in cancelled by user.");
                      return;
                    }

                    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

                    final String? idToken = googleAuth.idToken;
                    print("Id_token------>${idToken}");

                    if (idToken != null && idToken.isNotEmpty) {
                      final result = await controller.googleSignIn(idToken);

                      if (result != null) {
                        Get.offAllNamed(RouteStrings.dashboardScreen);
                      } else {
                        appSnackBar(title:  StringConstant.kLoginFailed.tr,message:  StringConstant.kSomethingWentWrongDuring.tr);
                      }
                    } else {
                      print("idToken is null");
                      appSnackBar(title:  StringConstant.kGoogleSignIn.tr,message:  StringConstant.kUnableToGetIDToken.tr);
                    }
                  } catch (e) {
                    print("Google Sign-In Error: $e");
                    appSnackBar(title:  StringConstant.kGoogleSignIn.tr,message:  StringConstant.kSomethingWentWrong.tr);
                  }
                },

                  fbTap: () async {
                    try {
                      final LoginResult result = await FacebookAuth.instance.login();

                      if (result.status == LoginStatus.success) {
                        final AccessToken accessToken = result.accessToken!;
                        print("Facebook login successful!");
                        print("Access Token: ${accessToken.tokenString}");

                        final userData = await FacebookAuth.instance.getUserData(
                          fields: "name,email,picture.width(200)",
                        );
                        print("User Data: $userData");

                        Get.snackbar(StringConstant.kLoginSuccessful.tr, "${StringConstant.kWelcome} ${userData['name']}");

                        Get.offAllNamed(RouteStrings.dashboardScreen);
                      } else if (result.status == LoginStatus.cancelled) {
                        print("Facebook login cancelled by user");
                        Get.snackbar(StringConstant.kLoginCancelled.tr, StringConstant.kUserCancelledLogin.tr);
                      } else {
                        print("Facebook login failed: ${result.message}");
                        Get.snackbar(StringConstant.kLoginFailed.tr, result.message ?? StringConstant.kSomethingWentWrong.tr);
                        Get.snackbar(StringConstant.kLoginFailed.tr, result.message ?? StringConstant.kSomethingWentWrong.tr);
                      }
                    } catch (e) {
                      print("Facebook Login Error: $e");
                      Get.snackbar(StringConstant.kFacebookLogin.tr, StringConstant.kSomethingWentWrong.tr);
                    }
                  }

              ),


              30.heightSizeBox,
            ],
          ),
        ),
      ),
    );
  }
}
