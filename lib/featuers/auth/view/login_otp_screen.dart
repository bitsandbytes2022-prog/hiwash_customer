import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/widgets/components/app_snack_bar.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import 'package:pinput/pinput.dart';

import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/app_bg.dart';
import '../../../widgets/components/hi_wash_button.dart';
import '../auth_controller/auth_controller.dart';


class LoginOtpScreen extends StatelessWidget {
  LoginOtpScreen({super.key});

  final AuthController controller =
  Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final String phoneNumber = Get.arguments as String;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      controller.startTimer();
    await  controller.getFCMTokenIn();
    });

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.c5C6B72.withOpacity(0.49)),
        borderRadius: BorderRadius.circular(100),
      ),
    );

    return Scaffold(
      body: AppBg(
        headingText: StringConstant.kAuthentication.tr,
        subText: StringConstant.kOTP.tr,
        child: Column(
          children: [
            110.heightSizeBox,
            Text(StringConstant.kVerifyPhone.tr, style: w700_22a(color: AppColor.c2C2A2A)),
            14.heightSizeBox,
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: StringConstant.kCodeHasBeenSentTo.tr,
                    style: w400_12p(color: AppColor.c455A64),
                  ),
                  TextSpan(
                    text: phoneNumber,
                    style: w500_14p(
                      color: AppColor.blue,
                    ).copyWith(decoration: TextDecoration.underline),
                  ),
                ],
              ),
            ),
            28.heightSizeBox,
            Form(
              key: formKey,
              child: Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme.copyDecorationWith(
                  color: AppColor.c5C6B72.withOpacity(0.1),
                ),
                onCompleted: (pin) => controller.enteredOtp.value = pin,
                validator: (value) {
                  if (value == null || value.length != 4) {
                    return StringConstant.kEnterValidOTP;
                  }
                  return null;
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
              ),
            ),

            24.heightSizeBox,
            Obx(() {
              final seconds = controller.secondsRemaining.value;
              final formatted = "00:${seconds.toString().padLeft(2, '0')}";
              return Text(formatted, style: w400_12p(color: AppColor.red));
            }),
            52.heightSizeBox,
            Text(StringConstant.kDidGetOTPCode.tr, style: w400_12p(color: AppColor.c455A64)),
            5.heightSizeBox,

            Obx(() {
              final seconds = controller.secondsRemaining.value;
              final isActive = seconds == 0;

              return GestureDetector(
                onTap: isActive
                    ? () {
                  controller.sendOtp(phoneNumber);
                  controller.resetTimer();
                }
                    : null,
                child: Text(
                  StringConstant.kResendCode.tr,
                  style: w400_12p(
                    color: isActive ? AppColor.red : AppColor.c5C6B72,
                  ),
                ),
              );
            }),
            26.heightSizeBox,
            Obx(
                    () => HiWashButton(
                  isLoading: controller.isLoading.value,
                  text: StringConstant.kVerify.tr,
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      final enteredOtp = controller.enteredOtp.value.trim();
                      final serverOtp = controller.sendOtpModel.value.data?.otp?.toString();

                      // Debug logs
                      print("Entered OTP: $enteredOtp (${enteredOtp.runtimeType})");
                      print("Server OTP: $serverOtp (${serverOtp.runtimeType})");

                      if (enteredOtp == serverOtp) {
                     await   controller.getToken(phoneNumber,).then((value) {
                          if (value != null) {
                            Get.offAllNamed(RouteStrings.dashboardScreen);
                          }
                        });
                      } else {
                      appSnackBar(
                        title: StringConstant.kInvalidOTP.tr,
                        message: StringConstant.kPleaseEnterTheCorrectOTP.tr,

                      );
                      }
                    }
                  },
                )

            ),



            30.heightSizeBox,
          ],
        ),
      ),
    );
  }
}


