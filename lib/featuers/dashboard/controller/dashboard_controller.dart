import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hiwash_customer/widgets/components/loader.dart';

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

      final response = await Repository().rating(params);
      if (response != null) {
        apiResponse.value = response;
      } else {
        return null;
      }

      return apiResponse.value;
    } catch (e) {
      print("Error in controller: $e");
      hideLoader();
      return null;
    } finally {
      // loading.value = false;
    }
  }
}
