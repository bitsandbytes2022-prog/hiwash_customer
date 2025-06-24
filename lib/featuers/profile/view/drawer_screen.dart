import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hiwash_customer/featuers/dashboard/view/second_drawer/chat_screen.dart';
import 'package:hiwash_customer/featuers/profile/view/subscription_plan_screen.dart';
import 'package:hiwash_customer/featuers/profile/view/widget/custome_switch.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/widgets/components/data_formet.dart';
import 'package:hiwash_customer/widgets/components/get_start_button.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_text_field.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../network_manager/local_storage.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/doted_horizontal_line.dart';
import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../auth/auth_controller/auth_controller.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../subscription/controller/subscription_controller.dart';
import '../../subscription/widgets/plan_container.dart';
import '../../wash_status/controller/wash_status_controller.dart';
import '../controller/drawer_profile_controller.dart';
import 'my_account_screen.dart';
import 'terms _and_condition_screen.dart';

class DrawerScreen extends StatelessWidget {
  final DrawerProfileController drawerController = Get.put(
    DrawerProfileController(),
  );
  final SubscriptionController controller =
      Get.isRegistered<SubscriptionController>()
          ? Get.find<SubscriptionController>()
          : Get.put(SubscriptionController());
  DashboardController dashboardController = Get.find();
  AuthController authController = Get.isRegistered<AuthController>()?Get.find<AuthController>():Get.put(AuthController());
  WashStatusController washStatusController = Get.find();

  @override
  Widget build(BuildContext context) {

    return Obx(() {
      return Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.horizontal(
              right: Radius.circular(15),
            ),
          ),
          child:
               mainDrawerUI()


        ),
      );
    });
  }

  /// **Main Drawer**
  Widget mainDrawerUI() {
    final userData =
        washStatusController.getCustomerData.value?.data?.subscriptionDetails;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          40.heightSizeBox,
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Align(
                alignment: Alignment.topRight,
                child: ImageView(
                  path: Assets.iconsIcClose,
                  height: 28,
                  width: 32,
                ),
              ),
            ),
          ),

          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColor.blue.withOpacity(0.2)),
                ),
                child: Obx(() {
                  final imageUrl =
                      washStatusController
                          .getCustomerData
                          .value
                          ?.data
                          ?.customerDetails
                          ?.profilePicUrl;

                  return ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: imageUrl ?? '',
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => SizedBox(
                        height: 100,
                        width: 100,
                        child: Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        ),
                      ),
                      errorWidget:
                          (context, url, error) => Image.asset(
                            Assets.imagesDemoProfile,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                    ),
                  );
                }),
              ),

          washStatusController.getCustomerData.value?.data?.subscriptionDetails?.subscriptionId==2?
          Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColor.cE8E9F4),
                ),

                child: ImageView(
                  path: Assets.iconsIcCrown,
                  height: 17,
                  width: 17,
                ),
              ):SizedBox(),
            ],
          ),
          11.heightSizeBox,
          Text(
            washStatusController
                    .getCustomerData
                    .value
                    ?.data
                    ?.customerDetails
                    ?.fullName ??
                "",
            style: w700_16a(color: AppColor.c2C2A2A),
          ),
          4.heightSizeBox,
         if(userData!=null) RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: StringConstant.kYour.tr,
                  style: w400_12p(color: AppColor.c455A64),
                ),
                TextSpan(
                  text: userData?.subscriptionName ?? "",
                  style: w600_14p(color: AppColor.cC31848),
                ),
                TextSpan(
                  text: StringConstant.kPackExpiringIn.tr,
                  style: w400_12p(color: AppColor.c455A64),
                ),
                TextSpan(
                  text: formatDate(userData?.endDate),
                  style: w600_12p(color: AppColor.c455A64),
                ),
              ],
            ),
          ),
          39.heightSizeBox,

          /// **Drawer Options**
          drawerRowWidget(
            onTap: () => Get.toNamed(RouteStrings.myAccountScreen),
            title: StringConstant.kMyAccount.tr,
            image: Assets.iconsIcAccount,
          ),
          drawerRowWidget(
            onTap: () {
              if (userData?.subscriptionId == null) {
                Get.toNamed(RouteStrings.subscribeMainScreen);
              } else {
                Get.toNamed(RouteStrings.subscriptionPlanScreen);
              }
            },
            title: StringConstant.kSubscriptionPlan.tr,
            image: Assets.iconsIcSubscriptionPlan,
          ),


          Obx(() => drawerRowForTheme(
            title: StringConstant.kTheme.tr,
            image: Assets.iconsIcTheme,
            switchValue: drawerController.isSwitchOn.value,
            onSwitchChanged: (bool value) {
              drawerController.isSwitchOn.value = value;


            },
          )),


          drawerRowWidget(
            onTap: () => Get.toNamed(RouteStrings.languageScreen),
            title: StringConstant.kLanguage.tr,
            image: Assets.iconsIcLanguage,
          ),
          drawerRowWidget(
            onTap: () => Get.toNamed(RouteStrings.privacySettingScreen),
            title: StringConstant.kPrivacySettings.tr,
            image: Assets.iconsIcPrivacy,
          ),
          drawerRowWidget(
            onTap: () => Get.to(TermsAndConditionScreen()),
            title: StringConstant.kTermsAndCondition.tr,
            image: Assets.iconsIcTermscondition,
          ),
          80.heightSizeBox,
          GestureDetector(
            onTap: () async {
              await LocalStorage().removeToken();
              var deviceLocale = Get.deviceLocale ?? const Locale('en', 'US');
              Get.updateLocale(deviceLocale);
              Get.offAllNamed(RouteStrings.welcomeScreen);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 31, vertical: 10),
              decoration: BoxDecoration(
                color: AppColor.cF6F7FF,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColor.cD83030),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ImageView(path: Assets.iconsIcLogout, height: 20, width: 20),
                  5.widthSizeBox,
                  Text(StringConstant.kLogout.tr, style: w500_14a(color: AppColor.c142293)),
                ],
              ),
            ),
          ),
          40.heightSizeBox,
        ],
      ),
    );
  }


  /// **Reusable Row Widget**
  Widget drawerRowWidget({
    required VoidCallback onTap,
    required String title,
    required String image,
    bool dashedLineWidget = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            color: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.only(
                left: 18,
                right: 12,
                top: 15,
                bottom: 15,
              ),
              child: Row(
                children: [
                  ImageView(path: image, height: 20, width: 20),
                  10.widthSizeBox,
                  Text(title, style: w500_14a(color: AppColor.c2C2A2A)),
                  Spacer(),
                  ImageView(
                    path: Assets.iconsBlackForwardArrow,
                    height: 13,
                    width: 13,
                  ),
                ],
              ),
            ),
          ),
          dashedLineWidget ? DotedHorizontalLine() : SizedBox(),
          /*   18.heightSizeBox,
          dashedLineWidget ? DashedLineWidget() : SizedBox(),
          18.heightSizeBox,*/
        ],
      ),
    );
  }

  Widget drawerRowForTheme({
    required String title,
    required String image,
    required bool switchValue,
    required ValueChanged<bool> onSwitchChanged,
    bool dashedLineWidget = true,
  }) {
    return Column(
      children: [
        Container(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
            child: Row(
              children: [
                ImageView(path: image, height: 20, width: 20),
                const SizedBox(width: 10),
                Text(title, style: w500_14a(color: AppColor.c2C2A2A)),
                const Spacer(),
                CustomContainerSwitch(
                  value: switchValue,
                  onChanged: onSwitchChanged,
                ),
              ],
            ),
          ),
        ),
        dashedLineWidget ? DotedHorizontalLine() : const SizedBox(),
      ],
    );
  }

}
