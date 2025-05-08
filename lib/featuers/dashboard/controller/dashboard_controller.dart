import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../network_manager/local_storage.dart';
import '../../../network_manager/repository.dart';
import '../../../network_manager/utils/api_response.dart';
import '../model/get_customer_data_model.dart';

class DashboardController extends GetxController {
  RxBool loading = false.obs;
  Rxn<ApiResponse> apiResponse = Rxn<ApiResponse>();
  int userRating = 0;
  final TextEditingController commentController = TextEditingController();

  final String? userId = LocalStorage().getUserId();

  @override
  Future<void> onInit() async {
    super.onInit();

  }


  Future<ApiResponse?> getRating(
    String rating,
    String washId,
    String comment,
  ) async {
    Map params = {"rating": rating, "washId": washId, "comment": comment};
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
