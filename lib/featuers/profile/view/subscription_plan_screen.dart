import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/components/data_formet.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../route/route_strings.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/get_start_button.dart';
import '../../../widgets/components/image_view.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../subscription/controller/subscription_controller.dart';
import '../../subscription/widgets/plan_container.dart';

class SubscriptionPlanScreen extends StatelessWidget {
  SubscriptionPlanScreen({super.key});

  DashboardController dashboardController = Get.find();
  SubscriptionController controller = Get.find();
  WashStatusController washStatusController = Get.find();



  @override
  Widget build(BuildContext context) {
    controller.getSubscription();
    final userData =
        washStatusController.getCustomerData.value?.data?.customerDetails;
    final userDataSub =
        washStatusController.getCustomerData.value?.data?.subscriptionDetails;
    final subscriptionEndDate = DateTime.tryParse(userDataSub?.endDate ?? '');

    final isExpired =
        subscriptionEndDate != null
            ? subscriptionEndDate.isBefore(DateTime.now())
            : false;
    final expiryDateStr = washStatusController.getCustomerData.value?.data?.subscriptionDetails?.endDate;
final daysLeft = controller.getDaysRemaining(expiryDateStr);
 final showRenewButton = controller.isRenewalAvailable(expiryDateStr);

    return AppHomeBg(
      padding: EdgeInsets.zero,
      headingText: "Subscription Plan",
      iconRight: SizedBox(),
      child: Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 16, right: 16),
                color: AppColor.white,

                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                              color: AppColor.blue.withOpacity(0.2),
                            ),
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
                                placeholder:
                                    (context, url) => SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Center(
                                        child: SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
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

                        washStatusController
                                    .getCustomerData
                                    .value
                                    ?.data
                                    ?.subscriptionDetails
                                    ?.subscriptionId ==
                                2
                            ? Container(
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
                            )
                            : SizedBox(),
                      ],
                    ),

                    10.heightSizeBox,
                    Text(
                      userData?.fullName ?? "",
                      style: w700_16a(color: AppColor.c2C2A2A),
                    ),
                    42.heightSizeBox,
                    subscriptionRowWidget(
                      title: 'Pack Name ',
                      packName: userDataSub?.subscriptionName ?? '',
                    ),
                    10.heightSizeBox,
                    DashedLineWidget(),
                    10.heightSizeBox,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Remaining wash",
                          style: w400_12p(color: AppColor.c455A64),
                        ),
                        userDataSub?.subscriptionId == 1
                            ? Text(
                              washStatusController
                                      .washSummaryModel
                                      .value
                                      ?.data
                                      ?.summary
                                      ?.remainingWashes ??
                                  ''.tr,
                              style: w500_12p(color: AppColor.c2C2A2A),
                            )
                            : Icon(
                              CupertinoIcons.infinite,
                              color: AppColor.c2C2A2A.withOpacity(0.7),
                            ),
                      ],
                    ),
                    10.heightSizeBox,
                    DashedLineWidget(),
                    10.heightSizeBox,
                    subscriptionRowWidget(
                      title: 'Expiry date ',
                      packName: formatDate(userDataSub?.endDate ?? ''),
                      color: AppColor.cC41949,
                    ),
                    40.heightSizeBox,
                  ],
                ),
              ),

              DashedLineWidget(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),

                width: Get.width,
                color: AppColor.cF6F7FF,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    26.heightSizeBox,
                    Text(
                      "upgrade your Plan now",
                      style: w600_14a(color: AppColor.c2C2A2A),
                    ),
                    16.heightSizeBox,
                    GetBuilder<SubscriptionController>(
                      builder: (controller) {
                        final list =
                            controller.getSubscriptionModel?.data ?? [];

                        if (controller.loading) {
                          return Center(child: CircularProgressIndicator());
                        }

                        if (list.isEmpty) {
                          return Center(child: Text("No plans available"));
                        }

                        return ListView.separated(
                          itemCount: list.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          separatorBuilder:
                              (context, index) => 15.heightSizeBox,
                          itemBuilder: (context, index) {
                            final subscription = list[index];

                            return PlansContainer(
                              index: index + 1,
                              heading: subscription.name ?? "",
                              subHeading: subscription.description ?? "",
                              qarText: subscription.currency?.trim() ?? "",
                              numberText: subscription.price?.toString() ?? '',
                              yearText: "/ Year",
                              imageShow: subscription.isPremium ?? false,
                                onTap: () {
                                  if (daysLeft <= 7) {
                                    controller.setPremiumStatus(subscription.isPremium ?? false);
                                    controller.selectedIndex.value = index + 1;
                                    print("99------>${controller.selectedIndex.value}");
                                  } else {
                                    Get.snackbar(
                                      "Renewal Not Available",
                                      "You can renew your subscription only within 7 days of expiry.",
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  }
                                }

                              // subscriptionId: subscription.id?.toString(),
                              // isViewOnly: false,
                            );
                          },
                        );
                      },
                    ),

                    30.heightSizeBox,
                    GetStartButton(
                      text: "Renew Now",
                      color: showRenewButton
                          ? AppColor.c1F9D70
                          : AppColor.c1F9D70.withOpacity(0.2),
                      boxShadowColor: showRenewButton
                          ? AppColor.c1F9D70.withOpacity(0.30)
                          : AppColor.c1F9D70.withOpacity(0.10),
                      onTap: () {
                        if (showRenewButton) {
                          final selectedSub = controller.getSubscriptionModel?.data
                              ?.elementAt(controller.selectedIndex.value - 1);

                          if (selectedSub == null) {
                            Get.snackbar("Plan Error", "No plan selected.",
                                backgroundColor: Colors.red, colorText: Colors.white);
                            return;
                          }
                          //Get.offNamed(RouteStrings.enterCardDetailScreen);
                        /*  controller.getSubscriptionMembership(
                            selectedSub.id.toString(),
                            "demo_transaction_id",
                            controller.carNumberController.text,
                            "success",
                          );*/
                          Get.toNamed(
                            RouteStrings.enterCardDetailScreen,
                            arguments: {
                              'carNumber': controller.carNumberController.text,
                              'subscriptionId': selectedSub.id.toString(),
                              'source': 'SubscriptionPlanScreen'
                            },
                          );

                        }
                      },
                    ),

                    /*  GetStartButton(
                      text: "Renew Now",
                      color:
                          isExpired
                              ? AppColor.c1F9D70
                              : AppColor.c1F9D70.withOpacity(0.2),
                      boxShadowColor:
                          isExpired
                              ? AppColor.c1F9D70.withOpacity(0.30)
                              : AppColor.c1F9D70.withOpacity(0.10),
                    ),*/
                    60.heightSizeBox,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget subscriptionRowWidget({
    required String title,
    Color? color,
    required String packName,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title.tr, style: w400_12p(color: AppColor.c455A64)),
        Text(packName.tr, style: w500_12p(color: color ?? AppColor.c2C2A2A)),
      ],
    );
  }
}
