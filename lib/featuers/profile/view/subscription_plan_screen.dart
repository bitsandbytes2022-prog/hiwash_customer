import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/components/data_formet.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/doted_line.dart';
import '../../../widgets/components/get_start_button.dart';
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
        dashboardController.getCustomerData.value?.data?.customerDetails;
    final userDataSub =
        dashboardController.getCustomerData.value?.data?.subscriptionDetails;
    return AppHomeBg(
      padding: EdgeInsets.zero,
      headingText: "Subscription Plan",
      iconRight: SizedBox(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(top: 20, left: 16, right: 16),
            color: AppColor.white,

            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColor.blue.withOpacity(0.2)),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(Assets.imagesDemoProfile),
                  ),
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
                subscriptionRowWidget(
                  title: 'Remaining wash',
                  packName:
                      washStatusController
                          .washSummaryModel
                          .value
                          ?.data
                          ?.summary
                          ?.remainingWashes ??
                      '',
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
                    final list = controller.getSubscriptionModel?.data ?? [];

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
                      separatorBuilder: (context, index) => 15.heightSizeBox,
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
                          subscriptionId: subscription.id?.toString(),
                        );
                      },
                    );
                  },
                ),

                20.heightSizeBox,
                GetStartButton(
                  text: "Renew Now",
                  color: AppColor.c1F9D70,
                  boxShadowColor: AppColor.c1F9D70.withOpacity(0.30),
                ),
                60.heightSizeBox,
              ],
            ),
          ),
        ],
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
