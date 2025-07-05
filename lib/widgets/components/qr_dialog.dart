import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/styling/app_font_anybody.dart';
import 'package:hiwash_customer/styling/app_font_poppins.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

class QrDialog extends StatelessWidget {
  QrDialog({super.key});

  WashStatusController washStatusController = Get.find();

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ClipPath(
            clipper: MultipleRoundedCurveClipper(),
            child: Container(
              margin: EdgeInsets.only(left: 21, right: 21, top: 30),
              width: Get.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),

                boxShadow: [
                  BoxShadow(
                    color: AppColor.c142293.withOpacity(0.25),
                    blurRadius: 25,
                    spreadRadius: 0,

                    offset: Offset(0, 5),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 27),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  40.heightSizeBox,
                  Image.asset(Assets.iconsIcCrown, height: 25, width: 27),
                  7.heightSizeBox,
                  Text(StringConstant.kSuccesss.tr, style: w700_22a(color: AppColor.c2C2A2A)),

                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: StringConstant.kYourPaymentIsComplete.tr,
                          style: w400_12p(color: AppColor.c455A64),
                        ),
                        TextSpan(
                          text:
                              washStatusController
                                  .getCustomerData
                                  .value
                                  ?.data
                                  ?.subscriptionDetails
                                  ?.subscriptionName ??
                              "",
                          style: w500_12p(color: AppColor.c2C2A2A),
                        ),
                        TextSpan(
                          text:StringConstant.kPlanIsNowActivated.tr,
                          style: w400_12p(color: AppColor.c455A64),
                        ),
                      ],
                    ),
                  ),
                  31.heightSizeBox,
                Obx(
                   () {
                    return CachedNetworkImage(
                      imageUrl:
                      washStatusController
                          .getCustomerData
                          .value
                          ?.data
                          ?.subscriptionDetails
                          ?.qrCodeUrl ??
                          "",
                      height: 215,
                      width: 215,
                      placeholder:
                          (context, url) => SizedBox(
                        height: 215,
                        width: 215,
                        child: Center(
                          child: SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2
                              ,color: Colors.blue,
                            ),
                          ),
                        ),
                      ),

                      errorWidget:
                          (context, url, error) => Container(
                        width: 216,
                        height: 261,
                        decoration: BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: AppColor.c142293.withOpacity(0.25),
                              blurRadius: 25,
                              spreadRadius: 0,
                            )]
                        ),
                        child: Center(child: Text(StringConstant.kQrNotGenerated.tr,
                          textAlign: TextAlign.center,
                        )),
                      ),
                    );
                  }
                ),

                  31.heightSizeBox,
                  Text(
                   StringConstant.kCongratulations.tr,
                    style: w600_14a(color: AppColor.c2C2A2A),
                  ),
                  9.heightSizeBox,
                  Text(
                   StringConstant.kScanToUnlockWeekly.tr,
                    textAlign: TextAlign.center,
                    style: w400_12p(color: AppColor.c455A64),
                  ),
                  50.heightSizeBox,
                ],
              ),
            ),
          ),
          Container(
            height: 59,
            width: 59,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: AppColor.c1F9D70.withOpacity(0.4),
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            padding: EdgeInsets.all(7),

            child: Image.asset(Assets.iconsIcVerify, height: 49, width: 49),
          ),
        ],
      ),
    );
  }
}

class MultipleRoundedCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    var curXPos = 0.0;
    var curYPos = size.height;
    var increment = size.width / 20;
    while (curXPos < size.width) {
      curXPos += increment;
      path.arcToPoint(Offset(curXPos, curYPos), radius: Radius.circular(5));
    }
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
