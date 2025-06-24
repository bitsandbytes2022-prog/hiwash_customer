import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/language/String_constant.dart';

import '../../generated/assets.dart';
import '../../styling/app_color.dart';
import '../../styling/app_font_poppins.dart';
import 'image_view.dart';

class AppDialog extends StatelessWidget {
  Widget? child;
  String? remainingTextBottom;
  String? remainingTextTop;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  TextStyle? remainingTextBottomStyle;
  bool? topVisible = false;
  bool? bottomVisible = false;

  AppDialog({
    super.key,
    this.child,
    this.margin,
    this.padding,
    this.topVisible,

    this.bottomVisible,
    this.remainingTextBottom,
    this.remainingTextTop,
    this.remainingTextBottomStyle,
  });

  WashStatusController washStatusController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,

        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      margin:
                          margin ??
                          EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 11,
                            top: 11,
                          ),
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: padding ?? EdgeInsets.symmetric(horizontal: 27),
                      child: child,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 22, top: 20),
                        child: ImageView(
                          path: Assets.iconsIcClose,
                          height: 28,
                          width: 32,
                        ),
                      ),
                    ),
                  ],
                ),

                if (bottomVisible == true)
                  Container(
                    padding: EdgeInsets.only(bottom: 0),
                    margin: EdgeInsets.only(left: 50, right: 50, top: 40),

                    /*  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(Assets.imagesDialogBottom),
                    ),*/
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(Assets.imagesDialogBottom),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              StringConstant.kRemainingWashes.tr,
                              style: w400_14p(color: AppColor.c2C2A2A),
                            ),

                            washStatusController
                                        .getCustomerData
                                        .value
                                        ?.data
                                        ?.subscriptionDetails
                                        ?.subscriptionId ==
                                    1
                                ? Text(
                                  remainingTextBottom ?? '',
                                  style: w400_16p(color: AppColor.cC31848),
                                )
                                : (washStatusController
                                        .getCustomerData
                                        .value
                                        ?.data
                                        ?.subscriptionDetails
                                        ?.subscriptionId ==
                                    2)
                                ? Icon(
                                  CupertinoIcons.infinite,
                                  color: AppColor.cC31848,
                                )
                                : Text(
                                  '',
                                  style: w400_16p(color: AppColor.cC31848),
                                ),
                          ],
                        ),


                      ],
                    ),
                  ),
              ],
            ),
            if (topVisible == true)
              Container(
                padding: EdgeInsets.only(top: 0),
                margin: EdgeInsets.only(left: 50, right: 50),

                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(Assets.imagesDiloagBgTop),

                    RichText(
                      text: TextSpan(
                        text: StringConstant.kRemainingWashes.tr,
                        style: w500_14p(color: AppColor.c2C2A2A),
                        children: <TextSpan>[
                          TextSpan(
                            text: '19',
                            style: w400_16p(color: AppColor.cC31848),
                          ),
                        ],
                      ),
                    ),
                    /* Text(
                    remainingTextBottom ?? ''.tr,
                    style: w500_14p(color: AppColor.c2C2A2A),
                  ),*/
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
