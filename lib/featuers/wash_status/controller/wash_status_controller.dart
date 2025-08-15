import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:hiwash_customer/featuers/wash_status/model/get_location_model.dart';
import 'package:hiwash_customer/language/String_constant.dart';
import '../../../network_manager/local_storage.dart';
import '../../../network_manager/repository.dart';
import '../../dashboard/model/get_customer_data_model.dart';
import '../model/wash_summry.dart';


class WashStatusController extends GetxController {
  RxBool isWashSelected = true.obs;
  Rxn<WashSummaryModel> washSummaryModel = Rxn();
  Rxn<GetCustomerData> getCustomerData = Rxn();

  Rx<LatLng?> currentLatLng = Rx<LatLng?>(null);
  RxString currentAddress = ''.obs;

  RxSet<Marker> markers = <Marker>{}.obs;
  RxSet<Polyline> polylines = <Polyline>{}.obs;
  late GoogleMapController googleMapController;

  RxList<LocationData> locationList = <LocationData>[].obs;
  Rx<LocationData?> selectedLocation = Rx<LocationData?>(null);

  @override
  void onInit() {
    super.onInit();
    final userIdStr = LocalStorage().getUserId();
    if (userIdStr != null && int.tryParse(userIdStr) != null) {
      getCustomerDataById(int.parse(userIdStr));
    }
    getWashSummary();
   // fetchCurrentAddress();
    Future.delayed(Duration(milliseconds: 200), () {
      fetchCurrentAddress();
    });

  }

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

      currentLatLng.value = LatLng(position.latitude, position.longitude);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        currentAddress.value =
        "${place.street ?? ''}, ${place.subLocality ?? ''}, ${place.locality ?? ''}, ${place.postalCode ?? ''}";
      }

      await getLocation(
        position.latitude.toString(),
        position.longitude.toString(),
      );
    } catch (e) {
      print("Error: $e");
      currentAddress.value = StringConstant.kLocationNotAvailable.tr;
    }
  }

  Future<void> drawRouteFromCurrentTo(LatLng destination) async {
    if (currentLatLng.value == null) return;

    final start = currentLatLng.value!;
    final end = destination;

    polylines.clear();
    polylines.refresh();

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: 'AIzaSyBzNOVeplXlxtY2jYUug5dhCUYSg5MSCA0',
      request: PolylineRequest(
        origin: PointLatLng(start.latitude, start.longitude),
        destination: PointLatLng(end.latitude, end.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      polylines.add(Polyline(
        polylineId: PolylineId("selected_route"),
        color: Colors.blue,
        width: 4,
        points: result.points.map((p) => LatLng(p.latitude, p.longitude)).toList(),
      ));

      polylines.refresh();
    } else {
      print("No points for line");
    }
  }

  Future<void> getLocation(String latitude, String longitude) async {
    try {
      final result = await Repository().getLocationRepo({
        "latitude": latitude,
        "longitude": longitude,
      });

      if (result != null && result.locationData != null) {
        locationList.assignAll(result.locationData!);

        markers.clear();

        for (var loc in locationList) {
          final lat = double.tryParse(loc.lattitude ?? '');
          final lng = double.tryParse(loc.longitude ?? '');
          if (lat != null && lng != null) {
            final marker = Marker(
              markerId: MarkerId(loc.id.toString()),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(title: loc.name),
              onTap: () async {
                selectedLocation.value = loc;
                await drawRouteFromCurrentTo(LatLng(lat, lng));
                selectedLocation.refresh();
                polylines.refresh();
              },
            );

            markers.removeWhere((m) => m.markerId == marker.markerId);
            markers.add(marker);
            markers.refresh();
          }
        }
      } else {
        locationList.clear();
      }
    } catch (e) {
      print("Location fetch error: $e");
    }
  }
  var isLoading = true.obs;
  Future<WashSummaryModel?> getWashSummary() async {
    isLoading.value = true;
    try {
      washSummaryModel.value = await Repository().washSummary();
      return washSummaryModel.value;
    } catch (e) {
      print("Summary error: $e");
    }finally
    {
      isLoading.value = false;
    }
    return null;
  }

  Future<GetCustomerData?> getCustomerDataById(int id) async {
    try {
      getCustomerData.value = await Repository().getCustomerData(id);
      getCustomerData.refresh();
    } catch (e) {
      print("Customer fetch error: $e");
    }
    return null;
  }
}



