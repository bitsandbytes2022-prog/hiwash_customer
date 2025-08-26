import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hiwash_customer/featuers/subscription/model/get_subscription_model.dart';
import 'package:hiwash_customer/featuers/wash_status/controller/wash_status_controller.dart';
import 'package:hiwash_customer/network_manager/repository.dart';
import 'package:hiwash_customer/network_manager/utils/api_response.dart';
import 'package:hiwash_customer/widgets/components/payment_screen.dart';

class SubscriptionController extends GetxController {
  GetSubscriptionModel? getSubscriptionModel;
  TextEditingController carNumberController = TextEditingController();
  var apiResponse = ApiResponse().obs;
  final box = GetStorage();
  Timer? _paymentCheckTimer;

  RxBool isPremiumSelected = false.obs;
  RxInt selectedIndex = 2.obs;

  bool loading = false;
  RxBool isLoading = false.obs;
  Rx<LatLng?> currentLatLng = Rx<LatLng?>(null);
  late GoogleMapController mapController;
  var isPlanSelectionEnabled = true.obs;

  @override
  void onInit() {
    super.onInit();
    selectedIndex.value = 2;
    update();
    _fetchCurrentLocation();
  }

  @override
  void onClose() {
    _paymentCheckTimer?.cancel();
    super.onClose();
  }

  void setPremiumStatus(bool status) {
    isPremiumSelected.value = status;
  }

  int selectedSubscriptionId = 1;

  void selectPlan(int index, String subscriptionId) {
    if (!isPlanSelectionEnabled.value) return;

    selectedIndex.value = index + 1;
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
    WashStatusController washStatusController =
    Get.isRegistered<WashStatusController>()
        ? Get.find<WashStatusController>()
        : Get.put(WashStatusController());
    loading = true;
    Repository()
        .getSubscription()
        .then((value) {
          loading = false;
          getSubscriptionModel = value;
          selectedIndex.value =
              washStatusController
                  .getCustomerData
                  .value
                  ?.data
                  ?.subscriptionDetails
                  ?.subscriptionId ??
              2;

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

    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    currentLatLng.value = LatLng(pos.latitude, pos.longitude);
  }

  Future<void> paymentMethod(String carNumber, String   subscriptionId) async {
    Map<String, dynamic> params = {
      "carNumber": carNumber,
      "subscriptionId": subscriptionId,
    };
    try {
      isLoading.value = true;
      final htmlResponse = await Repository().paymentRepo(params);
      Get.to(() => PaymentWebViewScreen(htmlData: htmlResponse));
      await Future.delayed(Duration(seconds: 3));
      isPlanSelectionEnabled.value = true;
    } catch (error) {
      print("Error payment--> ${error.toString()}");
    } finally {
      isLoading.value = false;
    }
  }



}

/*  void startPaymentCheck() {
    _paymentCheckTimer?.cancel();

    _paymentCheckTimer = Timer.periodic(Duration(seconds: 1), (timer) async {
      try {
        WashStatusController washStatusController = Get.find();
        await washStatusController.getCustomerDataById(
          washStatusController
                  .getCustomerData
                  .value
                  ?.data
                  ?.customerDetails
                  ?.id ??
              0,
        );

        final subscriptionId =
            washStatusController
                .getCustomerData
                .value
                ?.data
                ?.subscriptionDetails
                ?.subscriptionId;

        if (subscriptionId != null && subscriptionId != 0) {
          timer.cancel();
          _showPaymentDialog(true);
        }
      } catch (e) {
        print("Error while checking payment: $e");
      }
    });

    Future.delayed(Duration(seconds: 60), () {
      if (_paymentCheckTimer != null && _paymentCheckTimer!.isActive) {
        _paymentCheckTimer?.cancel();
        _showPaymentDialog(false);
      }
    });
  }

  void _showPaymentDialog(bool success) {
    Get.defaultDialog(
      title: success ? "Payment Successful" : "Payment Failed",
      middleText:
          success
              ? "Your subscription is activated."
              : "Something went wrong, please retry.",
      textConfirm: "OK",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back();
        if (success) {
          Get.offAllNamed(RouteStrings.dashboardScreen);
        }
      },
    );
  }*/

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
