import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hiwash_customer/featuers/dashboard/view/second_drawer/second_drawer.dart';
import 'package:hiwash_customer/widgets/components/app_dialog.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/doted_horizontal_line.dart';
import '../../../widgets/components/doted_vertical_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../../widgets/components/profile_image_container.dart';
import '../../../widgets/components/star_rating.dart';
import '../../notification/view/notification_screen.dart';
import '../../profile/view/drawer_screen.dart';
import '../../rewads/view/reward_screen.dart';

import '../../../widgets/components/app_home_bg.dart';
import '../../wash_status/controller/wash_status_controller.dart';
import '../../wash_status/view/wash_status_screen.dart';
import '../controller/dashboard_controller.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _currentDrawer = 'first';
  final WashStatusController controller =
      Get.isRegistered<WashStatusController>()
          ? Get.find()
          : Get.put(WashStatusController());

  final List<Widget> _pages = [
    WashStatusScreen(),
    RewardScreen(),
    NotificationScreen(),
  ];

  final List<String> _headings = ["", "Offers For You", "Notification’s"];

  void _onItemTapped(int index) {
    if (index == 3) {
      _openDrawer('first');
    } else {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  void _openDrawer(String drawerType) {
    setState(() {
      _currentDrawer = drawerType;
    });
    if (_scaffoldKey.currentState != null) {
      _scaffoldKey.currentState?.openDrawer();
    } else {
      print("Drawer scaffold state is null.");
    }
  }

  DashboardController dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    final List<Widget> filledImages = [
      fillNavigationImage(image: Assets.iconsIcHomeFill),
      fillNavigationImage(image: Assets.iconsIcRewardFill),
      fillNavigationImage(image: Assets.iconsIcNotificationFill),
      ProfileImageView(isVisibleStack: false),
    ];

    final List<Widget> outlineImages = [
      ImageView(path: Assets.iconsIcHome, height: 23, width: 23),
      ImageView(path: Assets.iconsTrophy, height: 23, width: 23),
      ImageView(path: Assets.iconsIcNotification, height: 23, width: 23),
      ProfileImageView(isVisibleStack: false),
    ];

    return SafeArea(
      top: false,
      bottom: true,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: _currentDrawer == 'first' ? DrawerScreen() : SecondDrawer(),
        drawerEnableOpenDragGesture: false,

        body: AppHomeBg(
          iconLeft: SizedBox(),
          headingText: _headings[_currentIndex],
          padding:
              _currentIndex == 0 || _currentIndex == 2
                  ? EdgeInsets.zero
                  : EdgeInsets.symmetric(horizontal: 16),
          buttonPadding: _currentIndex==0? EdgeInsets.only(
            left: 16,
            right: 16,
            top: 40,
            bottom: 30

          ): EdgeInsets.only(
            left: 16,
            right: 16,
            top: 40,

          ),
          childAppBar:
              _currentIndex == 0
                  ? Obx(
                    () => Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.isWashSelected.value = true;
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                decoration: BoxDecoration(
                                  color:
                                      controller.isWashSelected.value
                                          ? AppColor.cF6F7FF
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "kWash".tr,
                                  style: w700_16a(
                                    color:
                                        controller.isWashSelected.value
                                            ? AppColor.c2C2A2A
                                            : AppColor.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          30.widthSizeBox,
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                controller.isWashSelected.value = false;
                              },
                              child: Container(
                                alignment: Alignment.center,
                                height: 30,
                                decoration: BoxDecoration(
                                  color:
                                      !controller.isWashSelected.value
                                          ? AppColor.cF6F7FF
                                          : Colors.transparent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "kLocations".tr,
                                  style: w700_16a(
                                    color:
                                        !controller.isWashSelected.value
                                            ? AppColor.c2C2A2A
                                            : AppColor.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  : SizedBox(),

          iconRight: GestureDetector(
            onTap: () {
              setState(() {
                _currentDrawer = 'second';
              });
              _openDrawer('second');
            },
            child: ImageView(
              height: 23,
              width: 23,
              path: Assets.iconsIcMessage,
            ),
          ),
          child: _pages[_currentIndex],
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          itemCount: filledImages.length,
          tabBuilder: (int index, bool isActive) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [isActive ? filledImages[index] : outlineImages[index]],
            );
          },
          activeIndex: _currentIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          onTap: _onItemTapped,
          backgroundColor: AppColor.blue,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GestureDetector(
          onTap: () {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AppDialog(bottomVisible: true, child: scanDialog());
              },
            );
          },
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColor.cC31848,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: AppColor.cC31848.withOpacity(0.60),
                  spreadRadius: 0,
                  blurRadius: 30,
                  offset: Offset(0, 15),
                ),
              ],
            ),
            child: Center(
              child: ImageView(
                path: Assets.iconsIcQr,
                height: 40,
                width: 40,
                color: AppColor.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget fillNavigationImage({required String image}) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColor.c000000.withOpacity(0.70),
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(0, 15),
          ),
        ],
      ),
      child: ImageView(path: image, height: 25, width: 25),
    );
  }

  Widget scanDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        37.heightSizeBox,

        Text("Redeem Wash!", style: w700_22a(color: AppColor.c2C2A2A)),
        Text(
          "Scan Your QR Code to\nEnjoy Your Wash.",
          style: w400_16p(color: AppColor.c455A64),
          textAlign: TextAlign.center,
        ),

        15.heightSizeBox,
        GestureDetector(
          onTap: () {
            Get.back();
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AppDialog(
                  padding: EdgeInsets.zero,

                  bottomVisible: true,
                  child: successDialog(),
                );
              },
            );
          },
          child: Image.asset(Assets.imagesImQr, height: 261, width: 261),
        ),

        46.heightSizeBox,
      ],
    );
  }

  Widget successDialog() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              30.heightSizeBox,
              Container(
                width: Get.width,

                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ImageView(
                        path: Assets.imagesImSussess,
                        width: Get.width,
                        fit: BoxFit.cover,
                        height: 180,
                      ),
                    ),
                  ],
                ),
              ),
              21.heightSizeBox,
              Text("Wash Complete! ", style: w700_22a(color: AppColor.c2C2A2A)),
              Text(
                "Share your feedback and\nrate the Customer.",
                textAlign: TextAlign.center,
                style: w400_16p(),
              ),
              9.heightSizeBox,
              StarRating(rating: 4),
              15.heightSizeBox,
              TextFormField(
                maxLines: 3,
                style: w400_14p(color: AppColor.c2C2A2A.withOpacity(0.9)),
                decoration: InputDecoration(
                  fillColor: AppColor.white,
                  hintText: "Enter your comment here...",
                  //  labelText: "Address",
                  filled: true,
                  //  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelStyle: w400_13a(color: AppColor.c455A64),
                  hintStyle: w400_14p(
                    color: AppColor.c2C2A2A.withOpacity(0.40),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.cEAE8E8.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.c5C6B72.withOpacity(0.30),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.c5C6B72.withOpacity(0.30),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.c5C6B72.withOpacity(0.30),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.c5C6B72.withOpacity(0.30),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColor.c5C6B72.withOpacity(0.30),
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              15.heightSizeBox,
              GestureDetector(
                onTap: () {
                  dashboardController
                      .getRating("6", "1", "1", "excellent")
                      .then((value) {
                        if (value != null) {
                          Get.back();
                        }
                      });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColor.c142293,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.c142293.withOpacity(0.30),
                        blurRadius: 15,
                        spreadRadius: 0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Text("Submit", style: w500_14a(color: AppColor.white)),
                ),
              ),
              18.heightSizeBox,
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.cF6F7FF,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              DotedHorizontalLine(),

              Padding(
                padding: EdgeInsets.only(top: 23, left: 19, bottom: 40),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ProfileImageView(
                      radius: 20,
                      radiusStack: 4,
                      isVisibleStack: false,
                    ),
                    9.widthSizeBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Ibrahim Bafqia",
                          style: w600_14a(color: AppColor.c2C2A2A),
                        ),
                        5.widthSizeBox,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ImageView(
                              path: Assets.iconsIcPlaceMarker,
                              height: 18,
                              width: 18,
                            ),

                            Text(
                              "09-May-2024",
                              style: w400_12a(color: AppColor.c455A64),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
