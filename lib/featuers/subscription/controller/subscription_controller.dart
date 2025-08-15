

  import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
  import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
  import 'package:hiwash_customer/featuers/subscription/model/get_subscription_model.dart';
import 'package:hiwash_customer/widgets/components/payment_screen.dart';
  import '../../../network_manager/repository.dart';
  import '../../../network_manager/utils/api_response.dart';
import '../../wash_status/controller/wash_status_controller.dart';

  class SubscriptionController extends GetxController {
    GetSubscriptionModel? getSubscriptionModel;
    TextEditingController carNumberController = TextEditingController();
    var apiResponse = ApiResponse().obs;
    final box = GetStorage();

    RxBool isPremiumSelected = false.obs;
    RxInt selectedIndex = 2.obs;

    bool loading = false;
    RxBool isLoading = false.obs;
    Rx<LatLng?> currentLatLng = Rx<LatLng?>(null);
    late GoogleMapController mapController;

    @override
    void onInit() {
      super.onInit();
      selectedIndex.value = 2;
      update();
      _fetchCurrentLocation();
    }


    void setPremiumStatus(bool status) {
      isPremiumSelected.value = status;
    }
    int selectedSubscriptionId = 1;

    void selectPlan(int index, String subscriptionId) {
      selectedIndex.value = index+1;
      selectedSubscriptionId = int.tryParse(subscriptionId) ?? 0;
    }

    bool isRenewalAvailable(String? expiryDateStr) {
      if (expiryDateStr == null || expiryDateStr.isEmpty) return false;

      try {
        final expiryDate = DateTime.parse(expiryDateStr);
        final today = DateTime.now();
        final daysLeft = expiryDate.difference(today).inDays;
        return daysLeft <= 7 && daysLeft >= 0;
      } catch (e) {
        return false;
      }
    }

    int getDaysRemaining(String? expiryDateStr) {
      if (expiryDateStr == null || expiryDateStr.isEmpty) return 0;

      try {
        final expiryDate = DateTime.parse(expiryDateStr);
        final today = DateTime.now();
        return expiryDate.difference(today).inDays;
      } catch (e) {
        return 0;
      }
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
        return response;
      } catch (error) {
        print("Error --> ${error.toString()}");
        return ApiResponse(success: false, message: error.toString());
      } finally {
        isLoading.value = false;


      }
    }

    Future<void> _fetchCurrentLocation() async {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return;

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return;
      }
      if (permission == LocationPermission.deniedForever) return;

      Position pos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      currentLatLng.value = LatLng(pos.latitude, pos.longitude);
    }



    Future<void> paymentMethod(String carNumber, String subscriptionId) async {
      Map<String, dynamic> params = {
        "carNumber": carNumber,
        "subscriptionId": subscriptionId,
      };

      try {
        isLoading.value = true;
        final htmlResponse = await Repository().paymentRepo(params);

        Get.to(() => PaymentWebViewScreen(htmlData: htmlResponse));
      } catch (error) {
        print("Error payment--> ${error.toString()}");
      } finally {
        isLoading.value = false;
      }
    }


/*
    Future<void> paymentMethod(String carNumber, String subscriptionId) async {
      Map<String, dynamic> params = {
        "carNumber": carNumber,
        "subscriptionId": subscriptionId,
      };

      try {
        isLoading.value = true;
        final response =  await Repository().paymentRepo(params);

     return response;
      } catch (error) {
        print("Error payment--> ${error.toString()}");
      } finally {
        isLoading.value = false;
      }
    }
*/

  }


