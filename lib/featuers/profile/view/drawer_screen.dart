import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/image_view.dart';
import '../terms _and_condition_screen.dart';
import 'controller/drawer.dart';

class DrawerScreen extends StatelessWidget {
  final DrawerControllerX drawerController = Get.put(DrawerControllerX());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Drawer(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
            ),
            child:
                drawerController.currentDrawerSection.value == ''
                    ? mainDrawerUI()
                    : sectionDrawerUI(
                      drawerController.currentDrawerSection.value,
                    ),
          ),
        );
      }),
    );
  }

  /// **Main Drawer**
  Widget mainDrawerUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        50.heightSizeBox,
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(Assets.imagesDemoProfile),
        ),
        Text("Ibrahim Bafqia"),
        4.heightSizeBox,
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(text: 'Your ', style: w400_12p(color: AppColor.c455A64)),
              TextSpan(
                text: 'Unlimited Washes',
                style: w600_14p(color: AppColor.cC31848),
              ),
              TextSpan(
                text: ' pack\nexpiring in ',
                style: w400_12p(color: AppColor.c455A64),
              ),
              TextSpan(
                text: '15-oct-2025',
                style: w600_12p(color: AppColor.c455A64),
              ),
            ],
          ),
        ),
        39.heightSizeBox,

        /// **Drawer Options**
        rowWidget(
          onTap: () => drawerController.toggleDrawer('My Account'),
          title: 'My Account',
        ),
        rowWidget(
          onTap: () => drawerController.toggleDrawer('Subscription Plan'),
          title: 'Subscription Plan',
        ),
        rowWidget(
          onTap: () => drawerController.toggleDrawer('Theme'),
          title: 'Theme',
        ),
        rowWidget(
          onTap: () => drawerController.toggleDrawer('Language'),
          title: 'Language',
        ),
        rowWidget(
          onTap: () => drawerController.toggleDrawer('Privacy Settings'),
          title: 'Privacy Settings',
        ),
        rowWidget(
          onTap: () => Get.to(TermsAndConditionScreen()),
          title: 'Terms and Condition',
        ),

        Spacer(),
        GestureDetector(
          onTap: () {
            Get.offAllNamed(RouteStrings.loginScreen);
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
                Text("Logout", style: w500_14a(color: AppColor.c142293)),
              ],
            ),
          ),
        ),
        40.heightSizeBox,
      ],
    );
  }

  /// **Dynamic Section UI**
  Widget sectionDrawerUI(String section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        50.heightSizeBox,

        Align(
          alignment: Alignment.topLeft,
          child: GestureDetector
            (

              onTap: (){
                drawerController.toggleDrawer('');
                print("object");
              },
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ImageView(
                                      path: Assets.iconsIcArrow,
                                      height: 15,
                                      width: 15,
                                      color: AppColor.blue,
                                    ),
                      10.widthSizeBox,
                      Text(section, style: w500_14a(color: AppColor.c2C2A2A)),
                    ],
                  ))),
        ),
       // Text(section, style: w600_18p(color: AppColor.c142293)),
        20.heightSizeBox,

        /// **Content According to Section**
        if (section == 'My Account') myAccountUI(),
        if (section == 'Subscription Plan') subscriptionPlanUI(),
        if (section == 'Theme') themeUI(),
        if (section == 'Language') languageUI(),
        if (section == 'Privacy Settings') privacySettingsUI(),

        20.heightSizeBox,
      ],
    );
  }

  /// **Individual Section UIs**
  Widget myAccountUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        50.heightSizeBox,
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(Assets.imagesDemoProfile),
        ),
        Text("Ibrahim Bafqia"),
        4.heightSizeBox,
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(text: 'Your ', style: w400_12p(color: AppColor.c455A64)),
              TextSpan(
                text: 'Unlimited Washes',
                style: w600_14p(color: AppColor.cC31848),
              ),
              TextSpan(
                text: ' pack\nexpiring in ',
                style: w400_12p(color: AppColor.c455A64),
              ),
              TextSpan(
                text: '15-oct-2025',
                style: w600_12p(color: AppColor.c455A64),
              ),
            ],
          ),
        ),
        39.heightSizeBox,
      ],
    );
  }

  Widget subscriptionPlanUI() {
    return Text("Your current plan: Premium\nExpires on: 15-Oct-2025");
  }

  Widget themeUI() {
    return Column(
      children: [
        Text("Select Theme"),
        10.heightSizeBox,

      ],
    );
  }

  Widget languageUI() {
    return Column(
      children: [
        Text("Select Language"),

      ],
    );
  }

  Widget privacySettingsUI() {
    return Column(
      children: [
        Text("Privacy Settings"),

      ],
    );
  }

  /// **Reusable Row Widget**
  Widget rowWidget({required VoidCallback onTap, required String title}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, right: 12),
            child: Row(
              children: [
                ImageView(path: Assets.iconsIcAccount, height: 20, width: 20),
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
          12.heightSizeBox,
          DashedLineWidget(),
          12.heightSizeBox,
        ],
      ),
    );
  }
}
