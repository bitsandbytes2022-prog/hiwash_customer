import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/dashboard/controller/dashboard_controller.dart';
import 'package:hiwash_customer/featuers/rewads/controller.dart';
import 'package:hiwash_customer/featuers/subscription/controller/subscription_controller.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/components/custom_bottomsheet.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_button.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_text_field.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/components/qr_dialog.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../route/route_strings.dart';
import '../../../styling/app_font_poppins.dart';
import '../../../widgets/components/app_dialog.dart';
import '../../../widgets/components/offers_grid_container.dart';
import '../../rewads/model/offer_response_model.dart';
import '../widgets/offer_card.dart';
import '../widgets/plan_container.dart';

class SubscriptionScreen extends StatelessWidget {
  SubscriptionScreen({super.key});

  DashboardController dashboardController = Get.find();
  SubscriptionController controller = Get.put(SubscriptionController());
  RewardController rewardController = Get.find();
WashStatusController washStatusController =Get.find();
  @override
  Widget build(BuildContext context) {
    final userData =
        dashboardController.getCustomerData.value?.data?.customerDetails;
    controller.getSubscription();
    return AppHomeBg(
      centerHeading: Container(
        margin: EdgeInsets.only(left: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(userData?.fullName??'', style: w400_16a(color: AppColor.white)),
            Text(
              "Full access subscription",
              style: w400_12a(color: AppColor.white.withOpacity(0.5)),
            ),
          ],
        ),
      ),
      childAppBar: Positioned(
        left: 46,
        bottom: -10,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.symmetric(horizontal: BorderSide.none),
          ),
          child: CircleAvatar(
            radius: 38,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(Assets.imagesDemoProfile),
            ),
          ),
        ),
      ),
      child: Stack(
        children: [
          ImageView(
            path: Assets.imagesSubscriptionBg,
            width: Get.width,
            height: Get.height / 1.4,
          ),
          Column(
            children: [
              17.heightSizeBox,
              Text("kChooseAPlan".tr, style: w700_22a(color: AppColor.c2C2A2A)),

              8.heightSizeBox,
              Text(
                "kGetBenefitsAcrossAll".tr,
                textAlign: TextAlign.center,
                style: w400_12p(color: AppColor.c455A64),
              ),
              30.heightSizeBox,
              OfferCardWidget(padding: EdgeInsets.symmetric(horizontal: 10)),
              25.heightSizeBox,
              viewOfferButton(() {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return CustomBottomSheet(
                      // padding: EdgeInsets.only(left: 16,right: 16),
                      child: bottomSheet(),
                    );
                  },
                );
              }),

              32.heightSizeBox,
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
                        onTap: () {
                          print("index Print---->${index + 1}");
                          controller.setPremiumStatus(
                            subscription.isPremium ?? false,
                          );

                          controller.selectedIndex.value = index + 1;
                        },
                      );
                    },
                  );
                },
              ),

              18.heightSizeBox,
              Obx(() {
                if (controller.selectedIndex.value == 1) {
                  return Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColor.cFF973B.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColor.cFF973B.withOpacity(0.4),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(Assets.iconsIcTAndC, height: 35, width: 35),
                        10.widthSizeBox,

                        Expanded(
                          child: Text(
                            "WashYourCarOnce".tr,
                            style: w400_12p(
                              color: AppColor.c455A64,
                            ).copyWith(height: 2),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (controller.selectedIndex.value == 2) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    child: Column(
                      children: [
                        Text(
                          "kCarRegistrationNumber".tr,
                          style: w500_12p(color: AppColor.c455A64),
                        ),
                        4.heightSizeBox,
                        Text(
                          "kUnlimitedWashesPlan".tr,
                          style: w500_12p(color: AppColor.c2C2A2A),
                        ),
                        15.heightSizeBox,
                        HiWashTextField(hintText: "kEnterCarNumber".tr),
                      ],
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
              40.heightSizeBox,
              HiWashButton(
                onTap: () {
                  String selectedId =
                      controller.selectedSubscriptionId.toString();

                  controller
                      .getSubscriptionMembership(
                        selectedId,
                        "7984187154",
                        "gJ18",
                        "Success",
                      )
                      .then((value) {
                        dashboardController.getCustomerDataById(
                          dashboardController
                                  .getCustomerData
                                  .value
                                  ?.data
                                  ?.customerDetails
                                  ?.id ??
                              0,
                        );
                        washStatusController.getWashSummary();
                        Get.toNamed(RouteStrings.enterCardDetailScreen);
                      });
                  print("seclectionId---->${selectedId}");
                },
                text: "kSubscribe".tr,
                margin: EdgeInsets.symmetric(horizontal: 30),
              ),

              30.heightSizeBox,
            ],
          ),
        ],
      ),
    );
  }

  Widget viewOfferButton(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 13, vertical: 12),
        decoration: BoxDecoration(
          color: AppColor.cC31848,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: AppColor.cC31848.withOpacity(0.3),
              spreadRadius: 0,
              blurRadius: 15,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Text("View All Offers", style: w600_14a(color: AppColor.white)),
      ),
    );
  }

  Widget bottomSheet() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            21.heightSizeBox,
            Text(
              "See All Exclusive Offers.",
              style: w700_16a(color: AppColor.c2C2A2A),
            ),

            27.heightSizeBox,
            OfferCardWidget(padding: EdgeInsets.symmetric(horizontal: 20)),
            25.heightSizeBox,
            Container(
              width: 158,
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9),
              decoration: BoxDecoration(
                //color: AppColor.c5C6B72.withOpacity(0.3),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(color: AppColor.c5C6B72.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  Text(
                    "Sort by Expiry",
                    style: w400_12p(color: AppColor.c2C2A2A),
                  ),
                  Spacer(),
                  ImageView(
                    path: Assets.iconsIcDropDown,
                    height: 5,
                    width: 9,
                    color: AppColor.c2C2A2A,
                  ),
                  //Icon(Icons.arrow_drop_down, size: 20),
                ],
              ),
            ),
            25.heightSizeBox,
            Obx(() {
              final List<Offers> data = rewardController.offerResponseModel.value?.data?.offers ?? [];

              if (data == null) {
                return Center(child: CircularProgressIndicator());
              }

              return SizedBox(
                height: Get.height,
                child:
                    data.isNotEmpty
                        ? GridView.builder(
                          shrinkWrap: true,
                          clipBehavior: Clip.hardEdge,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                              ),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return OffersGridContainer(offer: data[index]);
                          },
                        )
                        : Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Text(
                            'Data is not found',
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ),
              );
            }),
            /*  SizedBox(
                height: Get.height,
                child: GridView.builder(
                  shrinkWrap: true,

                  padding: EdgeInsets.only(left: 16, right: 16, bottom: 200),
                  clipBehavior: Clip.hardEdge,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                    // mainAxisExtent: Get.height * 0.22,
                  ),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return OffersGridContainer();
                  },
                ),
              ),*/
            60.heightSizeBox,
          ],
        ),
      ),
    );
  }
}
