import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/widgets/components/doted_horizontal_line.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/data_formet.dart';
import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/doted_vertical_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../../widgets/components/profile_image_container.dart';
import '../../dashboard/view/second_drawer/chat_screen.dart';
import '../controller/notification_controller.dart';
import '../model/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/widgets/components/doted_horizontal_line.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/data_formet.dart';
import '../../../widgets/components/image_view.dart';
import '../../../widgets/components/profile_image_container.dart';
import '../controller/notification_controller.dart';
import '../model/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/widgets/components/doted_horizontal_line.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/data_formet.dart';
import '../../../widgets/components/image_view.dart';
import '../../../widgets/components/profile_image_container.dart';
import '../../dashboard/view/second_drawer/chat_screen.dart';
import '../controller/notification_controller.dart';
import '../model/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/notification_controller.dart';
import '../model/notification.dart';
import '../../../styling/app_color.dart';
import '../../../widgets/components/doted_horizontal_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../../widgets/components/profile_image_container.dart';
import '../../../widgets/sized_box_extension.dart';
import '../../../widgets/components/data_formet.dart';
import '../../../styling/app_font_anybody.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../generated/assets.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/data_formet.dart';
import '../../../widgets/components/doted_horizontal_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../../widgets/components/profile_image_container.dart';
import '../../../widgets/sized_box_extension.dart';
import '../../dashboard/view/second_drawer/chat_screen.dart';
import '../controller/notification_controller.dart';
import '../model/notification.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/notification_controller.dart';
import '../model/notification.dart';
import '../../../styling/app_color.dart';
import '../../../widgets/components/doted_horizontal_line.dart';
import '../../../widgets/components/image_view.dart';
import '../../../widgets/components/profile_image_container.dart';
import '../../../widgets/sized_box_extension.dart';
import '../../../widgets/components/data_formet.dart';
import '../../../styling/app_font_anybody.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final NotificationController controller = Get.put(NotificationController());

  WashStatusController washStatusController = Get.find();

  @override
  void initState() {
    controller.scrollController.addListener(controller.scrollListener);
    controller.fetchInitialNotifications();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          15.heightSizeBox,
          _buildNotificationHeader(),
          21.heightSizeBox,
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value &&
                  controller.notifications.isEmpty) {
                return _buildPaginationLoader();
              }

              if (controller.errorMessage.value.isNotEmpty) {
                return _buildPaginationLoader();
              }

              if (controller.notifications.isNotEmpty) {
                return ListView.separated(
                  controller: controller.scrollController,
                  padding: const EdgeInsets.only(top: 1, bottom: 40),
                  itemCount:
                      controller.notifications.length +
                      (controller.hasMore.value ? 1 : 0),
                  separatorBuilder: (context, index) => DotedHorizontalLine(),
                  itemBuilder: (context, index) {
                    if (index < controller.notifications.length) {
                      final item = controller.notifications[index];
                      return Obx(() => _notificationContainer(item, index));
                    } else {
                      return _buildPaginationLoader();
                    }
                  },
                );
              } else {
                return const Center(child: Text("No Notifications Found"));
              }
            }),
          ),
        ],
      ),
    );
  }

/*  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(child: CircularProgressIndicator()),
    );
  }*/

  Widget _buildPaginationLoader() {
    return Center(child: CircularProgressIndicator());
  }

/*  Widget _buildErrorMessage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            controller.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
          ElevatedButton(
            onPressed: () {
              controller.fetchInitialNotifications();
            },
            child: const Text("Retry"),
          ),
        ],
      ),
    );
  }*/

  Widget _buildNotificationHeader() {
    return Container(
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
              border: Border.all(color: AppColor.c000000.withOpacity(0.1)),
            ),
            child: ImageView(
              path: Assets.iconsIcBook,
              height: 24,
              width: 24,
              color: AppColor.white,
            ),
          ),
          10.widthSizeBox,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Your ',
                        style: w500_12p(
                          color: AppColor.white.withOpacity(0.70),
                        ),
                      ),
                      TextSpan(
                        text:
                            washStatusController
                                .getCustomerData
                                .value
                                ?.data
                                ?.subscriptionDetails
                                ?.subscriptionName ??
                            '',
                        style: w600_12p(color: AppColor.white),
                      ),
                      TextSpan(
                        text:
                            ' Pack Has\n Been Overdue Since ${formatDate(washStatusController.getCustomerData.value?.data?.subscriptionDetails?.endDate)}!',
                        style: w500_12p(
                          color: AppColor.white.withOpacity(0.70),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 16),
            child: ImageView(
              path: Assets.iconsIcForward,
              height: 10,
              width: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _notificationContainer(NotificationData item, int index) {
    return GestureDetector(
      onTap: () {
        controller.toggleSelection(index);
        controller.updateNotificationReadStatus(item, index);
      },
      child: Container(
        width: Get.width,
        color:
            controller.selectedStates[index].value
                ? AppColor.white
                : AppColor.cF6F7FF,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(

                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: AppColor.blue.withOpacity(0.2)),
                ),
                child:CircleAvatar(

                  backgroundColor: AppColor.c142293.withOpacity(0.2),
                  radius: 20,
              
                      child:Image.asset(item.notificationType==0?Assets.iconsIcAlert:Assets.iconsIcInfo,height: 20,width: 20,color: AppColor.c000000,),
                )


            ),
          /*  ProfileImageView(
              radiusStack: 5,
              isVisibleStack: false,
              radius: 20,
              imagePath: item.notificationType == 1 ? Assets.iconsIcAlert : null
            ),*/
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.message ?? '',
                    style: w500_12p(color: AppColor.c2C2A2A),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatDate(item.createdAt),
                    style: w400_10p(color: AppColor.c455A64),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
