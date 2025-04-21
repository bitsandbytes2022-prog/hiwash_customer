  import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/dashboard/view/second_drawer/model/guides_response_model.dart';
import 'package:hiwash_customer/featuers/profile/model/terms_and_conditions_response_model.dart';
  import 'package:hiwash_customer/network_manager/repository.dart';
  import '../model/faq_response_model.dart';

  class SecondDrawerController extends GetxController {
    var isChecked = [true, false, false].obs;
    FaqResponseModel? faqResponse;
    GuidesResponseModel? guidesResponseModel;
    RxBool isLoading = true.obs;
    RxList<bool> isExpanded = <bool>[].obs;


    void toggleCheckbox(int index) {
      for (int i = 0; i < isChecked.length; i++) {
        isChecked[i] = (i == index);
      }
    }

    @override
    void onInit() {
      super.onInit();
      getFaq();
      getGuides();
    }

    void toggleExpand(int index) {
      isExpanded[index] = !isExpanded[index];
     print("gggg");
    }




    Future<void> getFaq() async {
      isLoading.value = true;
      try {
        int entityType = 0;
        faqResponse = await Repository().getFaq(entityType);

        isExpanded.value = List<bool>.filled(faqResponse?.data?.length ?? 0, false);
      } catch (error) {
        print("Error fetching FAQ: $error");
      } finally {
        isLoading.value = false;
      }
    }

/*    Future<FaqResponseModel?> getFaq() async {
      int entityType = 0;

      try {
        faqResponse = await Repository().getFaq(entityType);
        return faqResponse;
      } catch (error) {
        print("Error fetching FAQ: $error");
        return null;
      }
    }*/

    Future<GuidesResponseModel?> getGuides() async {
      int entityType = 0;

      try {
        guidesResponseModel = await Repository().getGuides(entityType);
        return guidesResponseModel;
      } catch (error) {
        print("Error fetching Guides: $error");
        return null;
      }
    }




  }