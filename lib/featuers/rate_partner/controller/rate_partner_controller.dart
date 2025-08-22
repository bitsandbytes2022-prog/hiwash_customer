import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/language/String_constant.dart';

import '../../../network_manager/repository.dart';
import '../../../widgets/components/app_snack_bar.dart';
import '../../notification/model/notification.dart';
import '../model/rate_offer_model.dart';

class RatePartnerController extends GetxController {
  TextEditingController commentController = TextEditingController();
  RxInt userRating = 0.obs;
  RxBool isLoading = false.obs;

  Future<bool?> rateOffer(String rating, String id) async {
    isLoading.value = true;
    try {
      final response = await Repository().rateOffer({
        "rating": rating,
        "offerRedemptionId": id,
        "comment": commentController.text,
      });

      RateOfferModel model = response;
      isLoading.value = false;
      if (model.success ?? false) {
        return true;
      } else {
        appSnackBar(
          title: StringConstant.kError.tr,
          message: model.message ?? 'Something went wrong',
          backgroundColor: Colors.green,
        );
      }
    } catch (e) {
      isLoading.value = false;
      appSnackBar(
        title: StringConstant.kError.tr,
        message: 'Something went wrong',
        backgroundColor: Colors.green,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
