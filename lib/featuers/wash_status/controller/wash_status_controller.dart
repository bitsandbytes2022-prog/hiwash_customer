import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hiwash_customer/featuers/wash_status/model/get_location_model.dart';

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
      washSummaryModel.value = await Repository().washSummary();
      return washSummaryModel.value;
    } catch (error) {
      loading = false;
      update();
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
    //fetchAndSetLocation();
    fetchCurrentAddress();
  }
/// Get Customer Data By Id
  Future<GetCustomerData?> getCustomerDataById(int id) async {
    try {
      getCustomerData.value = await Repository().getCustomerData(id);

      getCustomerData.value;
      getCustomerData.refresh();
    } catch (error) {
      print("Error fetching customer data: $error");
      return null;
    }
    return null;
  }

  Rxn<GetLocationModel> getLocationModel = Rxn();


  Future<GetLocationModel?>getLocation(String latitude,String longitude) async {
    try{
      getLocationModel.value=await Repository().getLocationRepo({

        "latitude":latitude,
        "longitude":longitude,
      });

    }catch(e){
      print("Error fetching location: $e");
      return null;
    }
    return null;
  }
  /// fetch Current Address
  RxString currentAddress = ''.obs;
  Future<void> fetchCurrentAddress() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        currentAddress.value = "Location services are disabled";
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          currentAddress.value = "Location permission denied";
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        currentAddress.value = "Location permission permanently denied";
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
        currentAddress.value = "Could not retrieve address details";
      }
    } catch (e) {
      print("Error fetching current address: $e");
      currentAddress.value = "Location not available";
    }
  }

/*
  Future<void> fetchAndSetLocation() async {
    try {
      Position position = await determinePosition();
      final latitude = position.latitude.toString();
      final longitude = position.longitude.toString();

      final location = await getLocation(latitude, longitude);
      if (location != null) {
        getLocationModel.value = location;
        update();
      }
    } catch (e) {
      print("Error getting location: $e");
    }
  }*/

/*  Future<Position> determinePosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }*/


}
