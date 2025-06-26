import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hiwash_customer/featuers/dashboard/view/second_drawer/second_drawer.dart';
import 'package:hiwash_customer/language/String_constant.dart';
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
import '../../../widgets/components/qr_not_available_container.dart';
import '../../../widgets/components/star_rating.dart';
import '../../auth/auth_controller/auth_controller.dart';
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
  final WashStatusController washStatusController =
      Get.isRegistered<WashStatusController>()
          ? Get.find()
          : Get.put(WashStatusController());

  final List<Widget>  _pages = [
    WashStatusScreen(),
    RewardScreen(),
    NotificationScreen(),
  ];

   List<String> get _headings => ["", StringConstant.kOffersForYou.tr, StringConstant.kNotification.tr];


  void _onItemTapped(int index) {
    if (index == 3) {
      _openDrawer('first');
    } else {
      setState(() {
        _currentIndex = index;
        if (index == 0) {
          washStatusController.isWashSelected.value = true;
          washStatusController.selectedLocation.value = null;
          washStatusController.polylines.clear();
          washStatusController.polylines.refresh();
        }
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
  AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {

    final List<Widget> filledImages = [
      fillNavigationImage(image: Assets.iconsIcHomeFill),
      fillNavigationImage(image: Assets.iconsIcRewardFill),
      fillNavigationImage(image: Assets.iconsIcNotificationFill),
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColor.blue.withOpacity(0.2)),
        ),
        child: Obx(() {
          final imageUrl = washStatusController
              .getCustomerData
              .value
              ?.data
              ?.customerDetails
              ?.profilePicUrl;

          return ClipOval(
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? '',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              placeholder: (context, url) => Image.asset(
                Assets.imagesDemoProfile,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Image.asset(
                Assets.imagesDemoProfile,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          );
        }),
      )
    ];

    final List<Widget> outlineImages = [
      ImageView(path: Assets.iconsIcHome, height: 23, width: 23),
      ImageView(path: Assets.iconsTrophy, height: 23, width: 23),
      ImageView(path: Assets.iconsIcNotification, height: 23, width: 23),
      Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColor.blue.withOpacity(0.2)),
        ),
        child: Obx(() {
          final imageUrl = washStatusController
              .getCustomerData
              .value
              ?.data
              ?.customerDetails
              ?.profilePicUrl;

          return ClipOval(
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? '',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
             placeholder: (context, url) => SizedBox(
            width: 20,
            height: 20,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          ),
              errorWidget: (context, url, error) => Image.asset(
                Assets.imagesDemoProfile,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
          );
        }),
      )

    ];

    return WillPopScope
      (
      onWillPop: ()async {
        return await _showExitConfirmationDialog(context);
      },
      child: SafeArea(
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
            buttonPadding:
                _currentIndex == 0
                    ? EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 30)
                    : EdgeInsets.only(left: 16, right: 16, top: 40),
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
                                  washStatusController.isWashSelected.value = true;
                                /// here clear the select location
                                  washStatusController.selectedLocation.value = null;
                                  washStatusController.polylines.clear();
                                  washStatusController.polylines.refresh();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color:
                                        washStatusController.isWashSelected.value
                                            ? AppColor.cF6F7FF
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    StringConstant.kWash.tr,
                                    style: w700_16a(
                                      color:
                                          washStatusController
                                                  .isWashSelected
                                                  .value
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
                                  washStatusController.isWashSelected.value =
                                      false;
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color:
                                        !washStatusController.isWashSelected.value
                                            ? AppColor.cF6F7FF
                                            : Colors.transparent,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    StringConstant.kLocations.tr,
                                    style: w700_16a(
                                      color:
                                          !washStatusController
                                                  .isWashSelected
                                                  .value
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
                  return AppDialog(
                    bottomVisible: true,
                    child: scanDialog(),
                    remainingTextBottom:
                        washStatusController
                            .washSummaryModel
                            .value
                            ?.data
                            ?.summary
                            ?.remainingWashes ??
                        '',
                  );
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

        Text(StringConstant.kRedeemWash.tr, style: w700_22a(color: AppColor.c2C2A2A)),
        Text(
          StringConstant.kScanYourQR.tr,
          style: w400_16p(color: AppColor.c455A64),
          textAlign: TextAlign.center,
        ),

        15.heightSizeBox,
        GestureDetector(

          child: Obx(() {
            final qrCodeUrl =
                washStatusController
                    .getCustomerData
                    .value
                    ?.data
                    ?.subscriptionDetails
                    ?.qrCodeUrl;

            return CachedNetworkImage(
              imageUrl: qrCodeUrl ?? '',
              height: 261,
              width: 261,
              placeholder:
                  (context, url) => SizedBox(
                    height: 261,
                    width: 261,
                    child: Center(
                      child: SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),

              errorWidget:
                  (context, url, error) =>QrNotAvailableContainer(
                    height: 261,
                    width: 261,
                  ),

            );
          }),
        ),


        46.heightSizeBox,
      ],
    );
  }
  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(StringConstant.kConfirmExit.tr,style: w700_22a(color: AppColor.c2C2A2A),),
          content: Text(StringConstant.kDoYouReally.tr,style: w400_16p(),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text(StringConstant.kNo.tr),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(StringConstant.kYes.tr),
            ),
          ],
        );
      },
    ).then((value) => value ?? false); 
  }

}
