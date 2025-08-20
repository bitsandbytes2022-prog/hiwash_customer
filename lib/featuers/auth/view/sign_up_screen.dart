
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/widgets/components/app_bg.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/hi_wash_button.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import '../auth_controller/auth_controller.dart';
import 'auth_widgets/or_widget.dart';
import 'auth_widgets/social_media.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthController authController = Get.put(AuthController());

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
        headingText: StringConstant.kHello.tr,
        subText: StringConstant.kSignUp.tr,
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
                labelText: StringConstant.kName.tr,
                hintText: StringConstant.kEnterYourFullName.tr,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z ]")),
                ],
                validator: (value) => authController.validateName(value),
              ),
              20.heightSizeBox,
              HiWashTextField(
                controller: authController.emailSignUpController,
                keyboardType: TextInputType.emailAddress,
                labelText: StringConstant.kEmail.tr,
                hintText: StringConstant.kEnterYourEmail.tr,
                validator: (value) => authController.validateEmail(value),
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
                hintText: StringConstant.kZone.tr,
                labelText: StringConstant.kZone.tr,
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
                hintText: StringConstant.kStreet.tr,
                labelText: StringConstant.kStreet.tr,
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
                hintText: StringConstant.kBuilding.tr,
                labelText: StringConstant.kBuilding.tr,
              ),
              20.heightSizeBox,
              HiWashTextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z0-9 .,@#&/\-':()+=]"),
                  ),
                ],
                controller: authController.unitController,
                hintText: StringConstant.kUnit.tr,
                labelText: StringConstant.kUnit.tr,
              ),
              20.heightSizeBox,

              ///  Gender Field
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Text(
                      "Gender",
                      style: w400_14p(color: AppColor.c455A64),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          gender(
                            genderText: 'Female',
                            isSelected: authController.selectedGender.value == 'F',
                            onTap: () => authController.selectedGender.value = 'F',
                          ),
                          gender(
                            genderText: 'Male',
                            isSelected: authController.selectedGender.value == 'M',
                            onTap: () => authController.selectedGender.value = 'M',
                          ),
                          gender(
                            genderText: 'Other',
                            isSelected: authController.selectedGender.value == 'O',
                            onTap: () => authController.selectedGender.value = 'O',
                          ),
                        ],
                      );
                    }),
                  ),

                  Obx(() => authController.showGenderError.value
                      ?  Padding(
                    padding: EdgeInsets.only(left: 20, top: 5),
                    child: Text(
                      "Please select gender",
                      style: w400_12a(color: AppColor.red),
                    ),
                  )
                      : const SizedBox.shrink()),
                ],
              ),

              35.heightSizeBox,

              /// Sign Up Button
              Obx(
                    () => HiWashButton(
                  isLoading: authController.isLoading.value,
                  text: StringConstant.signUp.tr,
                  onTap: () {
                    if (formKey.currentState?.validate() ?? false) {
                      if (authController.selectedGender.value.isEmpty) {
                        authController.showGenderError.value = true;
                        return;
                      } else {
                        authController.showGenderError.value = false;
                      }

                      authController
                          .signUp(
                        authController.nameController.text.trim(),
                        authController.phoneController.text.trim(),
                        authController.emailSignUpController.text.trim(),
                        authController.zoneController.text.trim(),
                        authController.streetController.text.trim(),
                        authController.buildingController.text.trim(),
                        authController.unitController.text.trim(),
                        authController.selectedGender.value.trim(),
                      )
                          .then((value) async {
                        if (value != null) {
                          String phoneNumber =
                          authController.phoneController.text.trim();
                          authController.sendOtp(phoneNumber).then((otpValue) {
                            if (otpValue != null) {
                              authController.sendOtpModel.value = otpValue;
                              Get.toNamed(
                                RouteStrings.otpScreen,
                                arguments: {"phoneNo": phoneNumber},
                              );
                              authController.phoneController.clear();
                            }
                          }).catchError((error) {
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
                        text: StringConstant.kHaveAnAccount.tr,
                        style: w400_12a(color: AppColor.c455A64),
                      ),
                      TextSpan(
                        text: StringConstant.LOGIN,
                        style: w500_14a(color: AppColor.red),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.toNamed(RouteStrings.loginScreen);
                          },
                      ),
                    ],
                  ),
                ),
              ),
              18.heightSizeBox,
              OrDivider(),
              18.heightSizeBox,

              /// Social Login
              SocialMedia(
                googleTap: () async {
                  try {
                    final GoogleSignInAccount? googleUser =
                    await GoogleSignIn().signIn();
                    if (googleUser == null) return;

                    final GoogleSignInAuthentication googleAuth =
                    await googleUser.authentication;
                    final String? idToken = googleAuth.idToken;

                    if (idToken != null && idToken.isNotEmpty) {
                      final result = await authController.googleSignIn(idToken);
                      if (result != null) {
                        Get.offAllNamed(RouteStrings.dashboardScreen);
                      } else {
                        Get.snackbar("Login Failed",
                            "Something went wrong during login.");
                      }
                    }
                  } catch (e) {
                    Get.snackbar("Google Sign-In", "Login failed. Try again.");
                  }
                },
                fbTap: () async {
                  try {
                    final LoginResult result =
                    await FacebookAuth.instance.login();
                    if (result.status == LoginStatus.success) {
                      final userData = await FacebookAuth.instance.getUserData(
                        fields: "name,email,picture.width(200)",
                      );
                      Get.snackbar(StringConstant.kLoginSuccessful.tr,
                          "${StringConstant.kWelcome} ${userData['name']}");
                      Get.offAllNamed(RouteStrings.dashboardScreen);
                    } else if (result.status == LoginStatus.cancelled) {
                      Get.snackbar(StringConstant.kLoginCancelled.tr,
                          StringConstant.kUserCancelledLogin.tr);
                    } else {
                      Get.snackbar("Login Failed",
                          result.message ?? "Unknown error");
                    }
                  } catch (e) {
                    Get.snackbar(StringConstant.kFacebookLogin.tr,
                        StringConstant.kSomethingWentWrong.tr);
                  }
                },
              ),
              30.heightSizeBox,
            ],
          ),
        ),
      ),
    );
  }

  /// Gender Widget
  Widget gender(
      {required String genderText,
        required bool isSelected,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        color: Colors.transparent,
        child: Row(
          children: [
            Text(
              genderText,
              style: w400_14p(color: AppColor.c2C2A2A),
            ),
            5.widthSizeBox,
            Container(
              alignment: Alignment.center,
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                color: isSelected ? AppColor.c2C2A2A : Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: AppColor.c2C2A2A.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.check,
                color: isSelected ? AppColor.white : AppColor.c2C2A2A,
                size: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/widgets/components/app_bg.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/bottom_sheet_bg.dart';
import '../../../widgets/components/hi_wash_button.dart';
import '../../../widgets/components/hi_wash_text_field.dart';
import '../auth_controller/auth_controller.dart';
import 'auth_widgets/or_widget.dart';
import 'auth_widgets/social_media.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  AuthController authController = Get.put(AuthController());

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
        headingText: StringConstant.kHello.tr,
        subText: StringConstant.kSignUp.tr,
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
                labelText: StringConstant.kName.tr,
                hintText: StringConstant.kEnterYourFullName.tr,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z ]")),
                ],
                validator: (value) {
                  return authController.validateName(value);
                },
              ),
              20.heightSizeBox,
              HiWashTextField(
                controller: authController.emailSignUpController,
                keyboardType: TextInputType.emailAddress,
                labelText: StringConstant.kEmail.tr,
                hintText: StringConstant.kEnterYourEmail.tr,
                validator: (value) {
                  return authController.validateEmail(value);
                },
              ),
              //  20.heightSizeBox,
              20.heightSizeBox,
              HiWashTextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z0-9 .,@#&/\-':()+=]"),
                  ),
                ],
                keyboardType: TextInputType.text,
                controller: authController.zoneController,
                hintText: StringConstant.kZone.tr,
                labelText: StringConstant.kZone.tr,
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
                hintText: StringConstant.kStreet.tr,
                labelText: StringConstant.kStreet.tr,
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
                hintText: StringConstant.kBuilding.tr,
                labelText: StringConstant.kBuilding.tr,
              ),
              20.heightSizeBox,
              HiWashTextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r"[a-zA-Z0-9 .,@#&/\-':()+=]"),
                  ),
                ],
                controller: authController.unitController,
                hintText: StringConstant.kUnit.tr,
                labelText: StringConstant.kUnit.tr,
              ),
              20.heightSizeBox,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Text(
                      "Gender",
                      style: w400_14p(color: AppColor.c455A64),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28),
                    */
/*  border: Border.all(
                        color: AppColor.c5C6B72.withOpacity(0.5),
                      ),*//*

                    ),

                    child: Obx(
                       () {
                        return Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            gender(genderText: 'Female', isSelected:authController.selectedGender.value == 'F', onTap: () {
                              authController.selectedGender.value = 'F';

                            }),



                            gender(genderText: 'Male', isSelected: authController.selectedGender.value == 'M', onTap: () {
                              authController.selectedGender.value = 'M';

                            }),
                            gender(genderText: 'Other', isSelected: authController.selectedGender.value == 'O', onTap: () {
                              authController.selectedGender.value = 'O';

                            }),
                          ],
                        );
                      }
                    ),
                  ),
                ],
              ),

              35.heightSizeBox,

              Obx(
                () => HiWashButton(
                  isLoading: authController.isLoading.value,
                  text: StringConstant.signUp.tr,
                  onTap: () {
                    String enteredPhone =
                        authController.phoneController.text.trim();

                    if (phoneNumberSignUp != null &&
                        phoneNumberSignUp != enteredPhone) {}
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
                          authController.selectedGender.value.trim()
                          )
                          .then((value) async {
                            if (value != null) {
                              String phoneNumber =
                                  authController.phoneController.text.trim();
                              authController
                                  .sendOtp(phoneNumber)
                                  .then((otpValue) {
                                    if (otpValue != null) {
                                      authController.sendOtpModel.value =
                                          otpValue;
                                      Get.toNamed(
                                        RouteStrings.otpScreen,
                                        arguments: {"phoneNo": phoneNumber},
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
                        text: StringConstant.kHaveAnAccount.tr,
                        style: w400_12a(color: AppColor.c455A64),
                      ),
                      TextSpan(
                        text: StringConstant.LOGIN,
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
              SocialMedia(
                googleTap: () async {
                  try {
                    final GoogleSignInAccount? googleUser =
                        await GoogleSignIn().signIn();
                    if (googleUser == null) {
                      print("Google sign-in cancelled by user.");
                      return;
                    }

                    final GoogleSignInAuthentication googleAuth =
                        await googleUser.authentication;

                    final String? idToken = googleAuth.idToken;
                    print("Id_token------>${idToken}");

                    if (idToken != null && idToken.isNotEmpty) {
                      final result = await authController.googleSignIn(idToken);

                      if (result != null) {
                        Get.offAllNamed(RouteStrings.dashboardScreen);
                      } else {
                        Get.snackbar(
                          "Login Failed",
                          "Something went wrong during login.",
                        );
                      }
                    } else {
                      print("idToken is null");
                      Get.snackbar("Google Sign-In", "Unable to get ID Token.");
                    }
                  } catch (e) {
                    print("Google Sign-In Error: $e");
                    Get.snackbar("Google Sign-In", "Login failed. Try again.");
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
                        Get.snackbar("Login Failed", result.message ?? "Unknown error");
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
  Widget gender({required String genderText, required bool isSelected,required VoidCallback onTap}){
    return        GestureDetector(
      onTap: onTap,
      child: Container(

        padding: EdgeInsets.symmetric(
        //  horizontal: 12,
          vertical: 12,
        ),

        color: Colors.transparent,
        child: Row(
          children: [
            Text(
              genderText,
              style: w400_14p(color: AppColor.c2C2A2A),
            ),
            5.widthSizeBox,
            Container(
              alignment: Alignment.center,
              height: 15,
              width: 15,
              decoration: BoxDecoration(
                color: isSelected?AppColor.c2C2A2A:Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: AppColor.c2C2A2A.withOpacity(0.5),
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.check,
                color: isSelected?AppColor.white:AppColor.c2C2A2A,
                size: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
