

  import 'package:get/get.dart';
  import 'package:get_storage/get_storage.dart';
  import 'package:hiwash_customer/featuers/subscription/model/get_subscription_model.dart';
  import '../../../network_manager/repository.dart';
  import '../../../network_manager/utils/api_response.dart';
import '../../wash_status/controller/wash_status_controller.dart';

  class SubscriptionController extends GetxController {
    GetSubscriptionModel? getSubscriptionModel;
    var apiResponse = ApiResponse().obs;
    final box = GetStorage();

    RxBool isPremiumSelected = false.obs;
    RxInt selectedIndex = 2.obs;

    bool loading = false;
    RxBool isLoading = false.obs;

    @override
    void onInit() {
      super.onInit();
      selectedIndex.value = 2;
      update();
    }


    void setPremiumStatus(bool status) {
      isPremiumSelected.value = status;
    }
    int selectedSubscriptionId = 1;

    void selectPlan(int index, String subscriptionId) {
      selectedIndex.value = index+1;
      selectedSubscriptionId = int.tryParse(subscriptionId) ?? 0;
    }



    getSubscription() {
      WashStatusController washStatusController = Get.find();

      loading = true;
      Repository()
          .getSubscription()
          .then((value) {
        loading = false;
        getSubscriptionModel = value;
           selectedIndex.value=  washStatusController.getCustomerData.value?.data?.subscriptionDetails?.subscriptionId ?? 2;

        update();
      })
          .catchError((error) {
        loading = false;
        print("Error fetching Subscription data: $error");
      });
    }

    Future<ApiResponse> getSubscriptionMembership(
        String subscriptionId,
        String transactionId,
        String carNumber,
        String status,
        ) async {
      Map<String, dynamic> params = {
        "subscriptionId": subscriptionId,
        "transactionId": transactionId,
        "carNumber": carNumber,
        "status": status,
      };

      try {
        isLoading.value = true;
        final response = await Repository().getSubscriptionMembership(params);
        apiResponse.value = response;
       // isLoading.value = false;
        return response;
      } catch (error) {
       // isLoading.value = false;
        print("Error --> ${error.toString()}");
        return ApiResponse(success: false, message: error.toString());
      } finally {
        isLoading.value = false;


      }
    }
  }

  /*
  import 'dart:ffi';

  import 'package:get/get.dart';
  import 'package:get/get_rx/src/rx_types/rx_types.dart';
  import 'package:get/get_state_manager/get_state_manager.dart';
  import 'package:get_storage/get_storage.dart';
  import 'package:hiwash_customer/featuers/subscription/model/get_subscription_membership_model.dart';
  import 'package:hiwash_customer/featuers/subscription/model/get_subscription_model.dart';
  import 'package:hiwash_customer/generated/assets.dart';

  import '../../../network_manager/repository.dart';
  import '../../../network_manager/utils/api_response.dart';

  class SubscriptionController extends GetxController {
    GetSubscriptionModel? getSubscriptionModel;
    var apiResponse = ApiResponse().obs;

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
    Future<ApiResponse> getSubscriptionMembership(
        String subscriptionId,
        String transactionId,
        String carNumber,
        String status,
        ) async {
      Map<String, dynamic> params = {
        "subscriptionId": subscriptionId,
        "transactionId": transactionId,
        "carNumber": carNumber,
        "status": status,
      };

      try {
        loading = true;

        final response = await Repository().getSubscriptionMembership(params);

        print("Success: ${response.success}");

        apiResponse.value = response;

        Get.back();

        return response;
      } catch (error) {
        loading = false;
        print("Error --> ${error.toString()}");

        return ApiResponse(success: false, message: error.toString());
      } finally {
        loading = false;
      }}
    }

  */
