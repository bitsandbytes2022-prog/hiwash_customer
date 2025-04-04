import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/doted_vertical_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../../widgets/components/profile_image_container.dart';
import '../../profile/view/chat_screen.dart';
import '../controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  NotificationController controller = Get.put(NotificationController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        backgroundColor: AppColor.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            48.heightSizeBox,
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
            ImageView(path: Assets.imagesHelpSupport, height: 180),
            31.heightSizeBox,
            Text("Get Help?", style: w700_22a()),

            40.heightSizeBox,

            /// **Drawer Options**
            drawerRowWidget(onTap: () => {
              
              Get.to(ChatScreen())
            }, title: 'Chat with Support', image: Assets.iconsIcChat),
            drawerRowWidget(onTap: () => {}, title: 'Help Desk Ticket', image: Assets.iconsIcTicket),
            drawerRowWidget(onTap: () => {}, title: 'FAQ’s', image: Assets.iconsIcFaq),
            drawerRowWidget(
              onTap: () => {},
              title: 'Step-by-Step Guide',
              dashedLineWidget: false, image: Assets.iconsIcGuideBook,
            ),

            Spacer(),
            DashedLineWidget(),
            Container(
             // padding: EdgeInsets.only(bottom: 20),
              color: AppColor.cF6F7FF,
              alignment: Alignment.center,
              height: 86,
              child: Row(

                children: [
                  Expanded(
                    child: Column(

                      mainAxisAlignment:MainAxisAlignment.center ,
                      children: [
                        ImageView(height: 23, width: 23, path: Assets.iconsPhone),
                        Text("+974 7048 7070", style: w500_12a()),
                      ],
                    ),
                  ),
                  DottedLine(),
                 // Container(height: Get.height, width: 1, color: AppColor.c142293.withOpacity(0.10)),

                  Expanded(
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.center ,
                      children: [
                        ImageView(height: 23, width: 23, path: Assets.iconsIcAtSign),
                        Text("info@hiwash.com", style: w500_12a()),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColor.c142293,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    Text(
                      "Notification’s",
                      style: w700_16a(color: AppColor.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      child: ImageView(
                        height: 23,
                        width: 23,
                        path: Assets.iconsIcMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          30.heightSizeBox,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: AppColor.cC31848,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.cC31848.withOpacity(0.30),
                          spreadRadius: 0,
                          blurRadius: 15,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColor.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(40),
                            border: Border.all(
                              color: AppColor.c000000.withOpacity(0.1),
                            ),
                          ),
                          child: ImageView(
                            path: Assets.iconsIcBook,
                            height: 24,
                            width: 24,
                            color: AppColor.white,
                          ),
                        ),
                        10.widthSizeBox,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "kYourCurrentLocation".tr,
                              style: w400_12a(color: AppColor.c455A64),
                            ),
                            Text(
                              "2847 Poling Farm Road",
                              style: w500_14p(color: AppColor.c000000),
                            ),
                          ],
                        ),
                        Spacer(),
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(right: 8),
                          child: ImageView(
                            path: Assets.iconsIcForward,
                            height: 10,
                            width: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                  21.heightSizeBox,
                  Container(
                    width: Get.width,
                    height: 1,
                    color: AppColor.c142293.withOpacity(0.1),
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: 20,
                    separatorBuilder: (context, index) {
                      return Container(
                        // margin: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 26),
                        width: Get.width,
                        height: 1,
                        color: AppColor.c142293.withOpacity(0.1),
                      );
                    },
                    itemBuilder: (context, index) {
                      return Obx(() {
                        return notificationContainer(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerRowWidget({
    required VoidCallback onTap,
    required String title,
    bool dashedLineWidget = true,
    required String image
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, right: 12),
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
          18.heightSizeBox,
          dashedLineWidget ? DashedLineWidget() : SizedBox(),
          18.heightSizeBox,
        ],
      ),
    );
  }

  Widget notificationContainer(int index) {
    return GestureDetector(
      onTap: () {
        controller.toggleSelection(index);
      },
      child: Container(
        width: Get.width,
        color:
            controller.selectedIndices[index] ? Colors.white : AppColor.cF6F7FF,
        padding: EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 26),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileImageContainer(),
           /* Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColor.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: AppColor.c142293.withOpacity(0.1)),
              ),
              child: Container(
                height: 34,
                width: 34,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColor.c142293.withOpacity(0.20),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage(Assets.imagesDemoProfile),
                  // Set your image here
                  radius: 20,
                ),
              ),
            ),*/
            9.widthSizeBox,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "kDemoText".tr,
                    style: w500_12p(color: AppColor.c2C2A2A),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  4.heightSizeBox,
                  Text("12 am", style: w400_10p(color: AppColor.c455A64)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

