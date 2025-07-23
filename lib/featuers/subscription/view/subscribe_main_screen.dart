import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hiwash_customer/featuers/subscription/controller/subscription_controller.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/route/route_strings.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/styling/app_font_poppins.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/components/hi_wash_button.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import '../../../widgets/components/image_view.dart';
import '../../dashboard/controller/dashboard_controller.dart';
import '../../rewads/controller.dart';

class SubscribeMainScreen extends StatelessWidget {
   SubscribeMainScreen({super.key});
  DashboardController dashboardController = Get.isRegistered<DashboardController>() ? Get.find<DashboardController>() : Get.put(DashboardController());
  WashStatusController washStatusController = Get.isRegistered() ? Get.find<WashStatusController>() : Get.put(WashStatusController());
    RewardController rewardController = Get.isRegistered()? Get.find()<RewardController>() : Get.put(RewardController());
   final SubscriptionController subscriptionController =Get.isRegistered()? Get.find<SubscriptionController>() : Get.put(SubscriptionController());

   @override
  Widget build(BuildContext context) {
     rewardController.getOfferCategoriesMethod();

     final userData = washStatusController.getCustomerData.value?.data?.customerDetails;
    return AppHomeBg(
      padding: EdgeInsets.zero,

      centerHeading: Container(
        margin: EdgeInsets.only(left: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text( userData?.fullName ?? '', style: w400_16a(color: AppColor.white)),
            Text(
              StringConstant.kFullAccessSubscription.tr,
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
            color: AppColor.cF6F7FF,
            // border: Border.symmetric(horizontal: BorderSide.none),
            border: Border.all(color: AppColor.cF6F7FF, width: 10),
          ),
          child: Obx(() {
            final profilePicUrl = washStatusController
                .getCustomerData
                .value
                ?.data
                ?.customerDetails
                ?.profilePicUrl;

            final hasValidUrl = profilePicUrl?.isNotEmpty ?? false;

            return CircleAvatar(
              radius: 28,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: hasValidUrl ? profilePicUrl! : '',
                  cacheKey: "uniqueKey-${DateTime.now().millisecondsSinceEpoch}",
                  fit: BoxFit.cover,
                  height: 56, // radius * 2
                  width: 56,
                  placeholder: (context, url) => Center(
                    child: SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2,color: Colors.blue,),
                    ),
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    Assets.imagesDemoProfile,
                    fit: BoxFit.cover,
                    height: 56,
                    width: 56,
                  ),
                ),
              ),
            );
          }),

        ),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
        /*  ImageView(
            path: Assets.imagesImMap,
            width: Get.width,
            height:Get.height/1.4,
            fit: BoxFit.cover,
          ),*/
          Obx(() {
            final latLng = subscriptionController.currentLatLng.value;
            if (latLng == null) {
              return SizedBox(
                width: Get.width,
                height: Get.height / 1.4,
                child: Center(child: CircularProgressIndicator(  strokeWidth: 2
                  ,color: Colors.blue,)),
              );
            }
            return SizedBox(
              width: Get.width,
              height: Get.height / 1.4,
              child: GoogleMap(
                initialCameraPosition: CameraPosition(target: latLng, zoom: 15),
                onMapCreated: (gmc) {
                  subscriptionController.mapController = gmc;
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: {
                  Marker(markerId: MarkerId('me'), position: latLng),
                },
              ),
            );
          }),


          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ImageView(
                path: Assets.imagesSubscribeBottome,
                width: Get.width,
                //height:Get.height/1.4,
                fit: BoxFit.cover,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(StringConstant.kWashWin.tr,style: w700_22a(color: AppColor.c2C2A2A),),
                 15.heightSizeBox,
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: StringConstant.kGetYourCarWashed.tr,
                          style: w400_16p(color: AppColor.c455A64),
                        ),
                        TextSpan(
                          text: StringConstant.k100locations.tr,
                          style: w400_16p(color: AppColor.c2C2A2A),
                        ),
                        TextSpan(
                          text: StringConstant.kUnlock.tr,
                          style: w400_16p(color: AppColor.c455A64),
                        ),
                        TextSpan(
                          text: StringConstant.kExclusiveOffers.tr,
                          style: w400_16p(color: AppColor.c2C2A2A),
                        ),
                      ],
                    ),
                  ),
                  24.heightSizeBox,
                  HiWashButton(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    text: StringConstant.kSubscribeNow,
                    onTap: (){
                      Get.toNamed(RouteStrings.subscriptionScreen);
                    },
                  ),
                  20.heightSizeBox,
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
