import 'dart:ffi';

import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hiwash_customer/featuers/subscription/model/get_subscription_model.dart';
import 'package:hiwash_customer/generated/assets.dart';

import '../../../network_manager/repository.dart';

class SubscriptionController extends GetxController {
  GetSubscriptionModel? getSubscriptionModel;
  final box = GetStorage();
  @override
  void onInit() {
    selectedIndex.value = 1;

    super.onInit();
  }

  RxBool isPremiumSelected = false.obs;

  void setPremiumStatus(bool status) {
    isPremiumSelected.value = status;
  }

  final List<String> images = [
    Assets.demoOffer1,
    Assets.demoOffer2,
    Assets.demoOffer3,
  ];

  var selectedIndex = 1.obs;
  bool get isSubscribed => box.read('isSubscribed') ?? false;

  void selectPlan(int index) {
    if (index != selectedIndex.value) {
      box.write('isSubscribed', true);

      selectedIndex.value = index;
    }

  }

  bool loading = false;

   getSubscription() {
    loading = true;
    Repository()
        .getSubscription()
        .then((value) {
          loading = false;
          getSubscriptionModel = value;
          update();
          print(
            "Customer data fetched successfully: ${value.data?.length} items",
          );
        })
        .catchError((error) {
          loading = false;
          print("Error fetching Subscription data: $error");
        });
  }

   getSubscriptionMembership(
    String subscriptionId,
    String transactionId,
    String carNumber,
    String status,
  ) {
    Map params = {
      "subscriptionId": "${subscriptionId}",
      "transactionId": "7984187154",
      "status": status,
      "carNumber": "gJ18",
    };
    loading = true;

    Repository()
        .getSubscriptionMembership(params)
        .then((value) {
          print("${value.success}");
          Get.back();
        })
        .onError((error, stackTrace) {
          loading = false;
          print("Error${error.toString()}");
        });
  }
}
