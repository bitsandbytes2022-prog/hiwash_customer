import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/dashboard/view/second_drawer/model/guides_response_model.dart';
import 'package:hiwash_customer/network_manager/repository.dart';
import 'package:image_picker/image_picker.dart';
import '../model/faq_response_model.dart';

class SecondDrawerController extends GetxController {
  var isChecked = [true, false, false].obs;
  Rxn<FaqResponseModel> faqResponse = Rxn();
  Rxn<GuidesResponseModel> guidesResponseModel = Rxn();
  RxBool isLoading = true.obs;
  RxList<bool> isExpanded = <bool>[].obs;
  RxString searchQuery = ''.obs;
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void toggleCheckbox(int index) {
    for (int i = 0; i < isChecked.length; i++) {
      isChecked[i] = (i == index);
    }
  }

  @override
  void onInit() {
    super.onInit();

    getGuides();
  }

  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImage({required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source, imageQuality: 70);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  void clearImage() {
    selectedImage.value = null;
  }

  void toggleExpand(int index) {
    isExpanded[index] = !isExpanded[index];
  }

  void resetAll() {
    subjectController.clear();
    descriptionController.clear();
    clearImage();
    isChecked.value = [false, false, false];
  }

  Future<FaqResponseModel?> getFaq() async {
    isLoading.value = true;
    try {
      int entityType = 0;
      faqResponse.value = await Repository().getFaq(entityType);

      isExpanded.value = List<bool>.filled(
        faqResponse.value?.data?.length ?? 0,
        false,
      );
    } catch (error) {
      print("Error fetching FAQ: $error");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<GuidesResponseModel?> getGuides() async {
    int entityType = 0;
    try {
      guidesResponseModel.value = await Repository().getGuides(entityType);
      return guidesResponseModel.value;
    } catch (error) {
      print("Error fetching Guides: $error");
    }
    return null;
  }
}
