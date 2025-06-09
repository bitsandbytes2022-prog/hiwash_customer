import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/dashboard/view/second_drawer/model/guides_response_model.dart';
import 'package:hiwash_customer/featuers/profile/model/terms_and_conditions_response_model.dart';
import 'package:hiwash_customer/network_manager/repository.dart';
import '../model/faq_response_model.dart';

class SecondDrawerController extends GetxController {
  var isChecked = [true, false, false].obs;
  Rxn<FaqResponseModel> faqResponse = Rxn();
  Rxn<GuidesResponseModel> guidesResponseModel = Rxn();
  RxBool isLoading = true.obs;
  RxList<bool> isExpanded = <bool>[].obs;
  RxString searchQuery = ''.obs;

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

  void toggleExpand(int index) {
    isExpanded[index] = !isExpanded[index];
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
