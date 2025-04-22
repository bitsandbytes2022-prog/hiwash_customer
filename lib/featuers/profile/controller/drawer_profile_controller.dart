import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../network_manager/repository.dart';
import '../model/terms_and_conditions_response_model.dart';
import 'package:image_picker/image_picker.dart';

class DrawerProfileController extends GetxController {
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

  File? imageFile;

  Future<void> imagePicker() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );


    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    update();
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
