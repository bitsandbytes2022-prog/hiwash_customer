import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../network_manager/local_storage.dart';
import '../../../network_manager/repository.dart';
import '../../dashboard/model/get_customer_data_model.dart';
import '../model/wash_summry.dart';

class WashStatusController extends GetxController{
  RxBool isWashSelected=true.obs;
Rxn<WashSummaryModel>washSummaryModel=Rxn();
  bool loading = false;
 /* @override
  void onInit() {
    if(washSummaryModel.value==null){
      print("=======>${washSummaryModel.value}");
      washSummaryModel.value;
    }else{
      getWashSummary();
    }

    super.onInit();
  }*/
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


  Rxn<GetCustomerData> getCustomerData=Rxn();


  @override
  void onInit() {
   // var customerId = Get.arguments;
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

  }


  //bool  loading=true;


  Future<GetCustomerData?> getCustomerDataById(int id) async {
    // loading = true;\
    try {
      getCustomerData.value= await Repository().getCustomerData(id);

      getCustomerData.value;
      update();
    } catch (error) {
      // loading = false;
      print("Error fetching customer data: $error");
      return null;
    }
    return null;
  }

}