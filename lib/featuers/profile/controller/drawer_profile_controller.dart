import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hiwash_customer/widgets/components/loader.dart';
import '../../../network_manager/repository.dart';
import '../model/terms_and_conditions_response_model.dart';
import 'package:image_picker/image_picker.dart';

class DrawerProfileController extends GetxController {
  var  imageFile = Rx<File?>(null);
  RxBool isLoading = false.obs;
  var isSwitchOn = false.obs;
  Future<void> imagePicker({required ImageSource source}) async {
    var pickedFile = await ImagePicker().pickImage(source: source,imageQuality: 20);

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path,  );
    } else {
      print("No file selected");
    }
  }
  Future<dio.FormData> getFormDataForUpload() async {
    final fileName = imageFile.value?.path.split('/').last;
    var file = await dio.MultipartFile.fromFile(
      imageFile.value!.path,
      filename: fileName,
    );
    return dio.FormData.fromMap({"file": file});
  }

  Future<void> uploadProfileImage() async {
    try {
      showLoader();
      final formData = await getFormDataForUpload();

      final response = await Repository().uploadProfilePictureRepo(formData);
      hideLoader();
      if (response != null) {
        print("Upload successful: $response");
      } else {
        print("Failed to upload image");
      }
    } catch (e) {
      //hideLoader();
      print("Upload error: $e");
    }
  }


  var currentDrawerSection = ''.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController carNumberController = TextEditingController();

  TextEditingController zoneController = TextEditingController(text:kDebugMode? "Zone 50":"");
  TextEditingController streetController = TextEditingController(
    text:kDebugMode?"al Matar Street":"",
  );
  TextEditingController buildingController = TextEditingController(
    text: kDebugMode?'Abcd':"",
  );
  TextEditingController unitController = TextEditingController(text:kDebugMode? 'Abcd':"");

  Rxn<TermsAndConditionsResponseModel> termsAndConditionsResponseModel = Rxn();

  void toggleDrawer(String section) {
    if (currentDrawerSection.value == section) {
      currentDrawerSection.value = '';
    } else {
      currentDrawerSection.value = section;
    }
  }


  Future<TermsAndConditionsResponseModel?> getTermsAndConditions() async {
    var entityType = 0;
    try {
      termsAndConditionsResponseModel.value = await Repository()
          .getTermsAndConditions(entityType);
      return termsAndConditionsResponseModel.value;
    } catch (error) {
      print("Error fetching Terms And Condition: $error");
      return null;
    }
  }

  Future<dynamic> uploadProfile(
    String fullName,
    String email,
    String mobileNumber,
    String zone,
    String street,
    String building,
    String unit,
    String profilePic,
    String carNumber,
  ) async {
    isLoading.value = true;
    try {
      Map<String, dynamic> requestBody = {
        "fullName": fullName,
        "email": email,
        "mobileNumber": mobileNumber,
        "zone": zone,
        "street": street,
        "building": building,
        "unit": unit,
        "profilePic": profilePic,
        "carNumber": carNumber,
      };
     // showLoader();
      final response = await Repository().uploadProfile(requestBody);
     // hideLoader();
      return response;
    } catch (e) {
      print("Update profile error: $e");

      Get.snackbar(
        "Error",
        "Something went wrong while updating profile",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
