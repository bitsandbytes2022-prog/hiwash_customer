import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../network_manager/repository.dart';
import '../../../network_manager/utils/api_response.dart';
import '../../wash_status/model/get_customer_data_model.dart';

class DashboardController extends GetxController {
  RxBool loading = false.obs;
  Rxn<ApiResponse> apiResponse = Rxn<ApiResponse>();
  int userRating = 0;
  final TextEditingController commentController = TextEditingController();
Rxn<GetCustomerData> getCustomerData=Rxn();
  //bool  loading=true;
  @override
  void onInit() {
    var customerId = Get.arguments;
    if (customerId is int ) {
      getCustomerDataById(customerId);
    }/* else if (customerId is String) {
    getCustomerDataById(customerId.toString());
  }*/ else {
      print("No valid customer ID provided");
    }
  }


  Future<GetCustomerData?> getCustomerDataById(int id) async {
    // loading = true;\
    try {
       getCustomerData.value= await Repository().getCustomerData(id);
      // loading = false;

      if (getCustomerData.value?.data != null) {
        int? customerId = getCustomerData.value?.data!.customerDetails?.id;
        print("Customer ID: $customerId");
      }

      return getCustomerData.value;
    } catch (error) {
      // loading = false;
      print("Error fetching customer data: $error");
      return null;
    }
  }


  Future<ApiResponse?> getRating(
    String rating,
    String workerId,
    String locationId,
    String comment,
  ) async {
    Map params = {
      "rating": rating,
      "workerId": workerId,
      "locationId": locationId,
      "comment": comment,
    };
    try {
      print("Rating body--->: $params");
      //  loading.value = true;
      apiResponse.value = await Repository().rating(params);
      return apiResponse.value;
    } catch (e) {
      print("Error in controller: $e");
      return null;
    } finally {
      // loading.value = false;
    }

  }
}
