import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../network_manager/repository.dart';
import '../model/get_customer_data_model.dart';
import '../model/wash_summry.dart';

class WashStatusController extends GetxController{
  RxBool isWashSelected=true.obs;
Rxn<WashSummaryModel>washSummaryModel=Rxn();
  bool loading = false;
  @override
  void onInit() {
    if(washSummaryModel.value==null){
      washSummaryModel.value;
    }else{
      getWashSummary();
    }

    super.onInit();
  }
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

}