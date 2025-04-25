import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/multipart/multipart_file.dart';
import 'package:dio/dio.dart' as dio;
import '../../../network_manager/repository.dart';
import '../model/terms_and_conditions_response_model.dart';
import 'package:image_picker/image_picker.dart';

class DrawerProfileController extends GetxController {
  var imageFile = Rx<File?>(null);

  Future<void> imagePicker() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  var currentDrawerSection = ''.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController carNumberController = TextEditingController();
  Rxn<TermsAndConditionsResponseModel> termsAndConditionsResponseModel = Rxn();

  void toggleDrawer(String section) {
    if (currentDrawerSection.value == section) {
      currentDrawerSection.value = '';
    } else {
      currentDrawerSection.value = section;
    }
  }

  Future<dio.FormData> getFormDataForUpload() async {
    if (imageFile == null) throw Exception("Image not selected");

    final fileName = imageFile.value?.path.split('/').last;
    var file = await dio.MultipartFile.fromFile(
      imageFile.value!.path,
      filename: fileName,
    );
    return dio.FormData.fromMap({"file": file});
  }

  Future<dynamic> uploadProfileImage() async {
    try {
      final formData = await getFormDataForUpload();
      final response = await Repository().uploadProfilePicture(formData);
      return response;
    } catch (e) {
      print("Upload error: $e");
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
}
