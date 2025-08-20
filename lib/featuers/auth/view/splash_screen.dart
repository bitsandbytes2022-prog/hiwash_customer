import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/auth/auth_controller/auth_controller.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../network_manager/local_storage.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

AuthController authController=Get.put(AuthController());
  void _checkLoginStatus() async {
    final LocalStorage localStorage = LocalStorage();
    await Future.delayed(Duration(seconds: 1));
    final token = localStorage.getToken();
    if (token != null && token.isNotEmpty) {
      await authController.refreshToken();
      WashStatusController washStatusController =
      Get.isRegistered<WashStatusController>()
          ? Get.find<WashStatusController>()
          : Get.put(WashStatusController());

      await washStatusController
          .getCustomerDataById(int.parse(localStorage.getUserId().toString()));
      print("User ID: ${washStatusController.getCustomerData.value?.data?.customerDetails?.id??''}");

      final subscriptionId =
          washStatusController.getCustomerData.value?.data?.subscriptionDetails?.subscriptionId;
      final price =
          washStatusController.getCustomerData.value?.data?.subscriptionDetails?.price;

      if (subscriptionId == null ||
          subscriptionId == 0 ||
          price == null ||
          price == 0) {
        await washStatusController
            .getCustomerDataById(int.parse(localStorage.getUserId().toString()));

        Get.offNamed(RouteStrings.subscribeMainScreen);
      } else {
        Get.offNamed(RouteStrings.dashboardScreen);
      }
    } else {
      Get.offNamed(RouteStrings.welcomeScreen);
    }


  }


  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      body: Stack(
        children: [
          ImageView(
            path: Assets.imagesSplashBg,
            width: Get.width,
            fit: BoxFit.cover,
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: Get.width,
                  margin: EdgeInsets.only(left: 56, right: 56),

                  decoration: BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(200),
                      topRight: Radius.circular(200),
                      bottomLeft: Radius.circular(200),
                      bottomRight: Radius.circular(200),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.c000000.withOpacity(0.25),
                        spreadRadius: 0,
                        blurRadius: 25,
                        offset: Offset(0, 25),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 115, left: 20, right: 20),

                        child: ImageView(
                          path: Assets.imagesAppLogo,
                          height: 55,
                        ),
                      ),

                      30.heightSizeBox,
                      DottedLine(),

                      Container(
                        width: Get.width,
                        padding: EdgeInsets.only(bottom: 115, top: 25),

                        decoration: BoxDecoration(
                          color: AppColor.cF6F7FF,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(200),
                            bottomRight: Radius.circular(200),
                          ),
                        ),

                        child: Column(
                          children: [
                            Text(
                              StringConstant.kWelcomeToThe.tr,
                              style: w400_22a(color: AppColor.c2C2A2A),
                            ),
                            Text(
                              StringConstant.kHiWASH.tr,
                              style: w900_24a(color: AppColor.c2C2A2A),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: Text(
                  StringConstant.kWeComeToYouTo.tr,
                  style: w500_16a(color: AppColor.white.withOpacity(0.4)),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DottedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.0,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColor.c142293.withOpacity(0.2),
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(40, (index) {
          return Container(
            width: 5.0,
            height: 1.0,
            color:
                index % 4 == 0
                    ? AppColor.c142293.withOpacity(0.2)
                    : Colors.transparent,
          );
        }),
      ),
    );
  }
}

