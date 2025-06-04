import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hiwash_customer/featuers/wash_status/model/get_location_model.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import 'package:hiwash_customer/widgets/components/loader.dart';

import '../../../network_manager/local_storage.dart';
import '../../../network_manager/repository.dart';
import '../../dashboard/model/get_customer_data_model.dart';
import '../model/wash_summry.dart';

class WashStatusController extends GetxController {
  RxBool isWashSelected = true.obs;
  Rxn<WashSummaryModel> washSummaryModel = Rxn();
  bool loading = false;

  Future<WashSummaryModel?> getWashSummary() async {
    try {
     // showLoader();
      washSummaryModel.value = await Repository().washSummary();
     // hideLoader();
      return washSummaryModel.value;
    } catch (error) {

      print("Error fetching Wash summary: $error");
    }
    return null;
  }

  Rxn<GetCustomerData> getCustomerData = Rxn();

  @override
  void onInit() {

    final String? userIdStr = LocalStorage().getUserId();

    if (userIdStr != null) {
      final int? userId = int.tryParse(userIdStr);
      if (userId != null) {
        getCustomerDataById(userId);
      } else {
        print("User ID is not a valid integer");
      }
    } else {
      print("No valid customer ID provided");
    }
    getWashSummary();

    fetchCurrentAddress();
  }
/// Get Customer Data By Id
  Future<GetCustomerData?> getCustomerDataById(int id) async {
    try {
      //showLoader();
      getCustomerData.value = await Repository().getCustomerData(id);

      getCustomerData.value;
      getCustomerData.refresh();
    } catch (error) {
     // hideLoader();
      print("Error fetching customer data: $error");
      return null;
    }
    return null;
  }

  RxList<LocationData> locationList = <LocationData>[].obs;

  Future<void> getLocation(String latitude, String longitude) async {
    try {
      final result = await Repository().getLocationRepo({
        "latitude": latitude,
        "longitude": longitude,
      });

      if (result != null && result.locationData != null) {
        locationList.assignAll(result.locationData!);
      } else {
        locationList.clear();
      }
    } catch (e) {
      print("Error fetching location: $e");
    }
  }



  /// fetch Current Address
  RxString currentAddress = ''.obs;
  Future<void> fetchCurrentAddress() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        currentAddress.value = StringConstant.kLocationServicesAreDisabled.tr;
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          currentAddress.value = StringConstant.kLocationPermissionDenied.tr;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        currentAddress.value = StringConstant.kLocationPermissionPermanentlyDenied.tr;
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        currentAddress.value =
        "${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.postalCode ?? ''}";
      } else {
        currentAddress.value = StringConstant.kCouldNotRetrieveAddressDetails.tr;
      }

      await getLocation(position.latitude.toString(), position.longitude.toString());

    } catch (e) {
      print("Error fetching current address: $e");
      currentAddress.value = StringConstant.kLocationNotAvailable.tr;
    }
  }

}
