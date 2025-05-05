import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/featuers/rewads/controller.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../controller/subscription_controller.dart';

class OfferCardWidget extends StatelessWidget {
  EdgeInsets? padding;

  OfferCardWidget({super.key, this.padding});

  RewardController rewardController = Get.find();

  SubscriptionController controller =
      Get.isRegistered<SubscriptionController>()
          ? Get.find()
          : Get.put(SubscriptionController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,

      child: Row(
        mainAxisSize: MainAxisSize.min,

        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Left Image
          Expanded(
            child: Container(
              height: 128,
              child: Transform.rotate(
                angle: -10 * 3.14 / 180,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.c000000.withOpacity(0.15),
                        spreadRadius: 0,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      rewardController
                              .getOfferCategoriesModel
                              .value
                              ?.data?[0]
                              .image ??
                          '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          rewardController.images[0],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),

          20.widthSizeBox,
          Expanded(
            child: Transform.translate(
              offset: Offset(0, -14),
              child: Container(
                height: 128,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.c000000.withOpacity(0.15),
                      spreadRadius: 0,
                      blurRadius: 15,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    rewardController
                            .getOfferCategoriesModel
                            .value
                            ?.data?[1]
                            .image ??
                        '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        rewardController.images[1],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          /*ClipRRect(
                    borderRadius: BorderRadius.circular(10),child: Image.asset(controller.images[1], fit: BoxFit.cover)),
              ),
            ),
          ),*/
          20.widthSizeBox,
          Expanded(
            child: Container(
              height: 128,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.c000000.withOpacity(0.15),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Transform.rotate(
                angle: 10 * 3.14 / 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    rewardController
                            .getOfferCategoriesModel
                            .value
                            ?.data?[2]
                            .image ??
                        '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        rewardController.images[2],
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          /*ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(controller.images[2], fit: BoxFit.cover),
                ),*/
        ],
      ),
    );
  }
}
