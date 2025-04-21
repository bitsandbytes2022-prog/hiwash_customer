import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../network_manager/repository.dart';
import '../model/terms_and_conditions_response_model.dart';

class DrawerProfileController extends GetxController {
  var currentDrawerSection = ''.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController carNumberController = TextEditingController();
  TermsAndConditionsResponseModel? termsAndConditionsResponseModel;
  void toggleDrawer(String section) {
    if (currentDrawerSection.value == section) {
      currentDrawerSection.value = '';
    } else {
      currentDrawerSection.value = section;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getTermsAndConditions();
  }


  Future<TermsAndConditionsResponseModel?> getTermsAndConditions() async {
    var entityType = 0;

    try {
      termsAndConditionsResponseModel = await Repository().getTermsAndConditions(entityType);
      return termsAndConditionsResponseModel;
    } catch (error) {
      print("Error fetching Terms And Condition: $error");
      return null;
    }
  }

}
