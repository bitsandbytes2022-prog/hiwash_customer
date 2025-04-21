import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../../network_manager/repository.dart';
import '../model/get_customer_data_model.dart';

class WashStatusController extends GetxController{
  RxBool isWashSelected=true.obs;
GetCustomerData? getCustomerData;
bool  loading=true;
@override
@override
void onInit() {
  var customerId = Get.arguments;
  if (customerId is int ) {
    getCustomerDataById(customerId);
  } /*else if (customerId is int) {
    getCustomerDataById(customerId.toString());
  }*/ else {
    print("No valid customer ID provided");
  }
}


  void getCustomerDataById(int id) {
    loading = true;
    Repository().getCustomerData(id).then((value) {
      getCustomerData = value;
      loading = false;
      update();
      if (getCustomerData?.data != null && getCustomerData!.data!.isNotEmpty) {
        int? customerId = getCustomerData!.data![0].id;
        print("Customer ID: $customerId");
      }
    }).catchError((error) {
      loading = false;
      print("Error fetching customer data: $error");
    });
  }
}