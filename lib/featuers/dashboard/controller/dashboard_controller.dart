import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../network_manager/repository.dart';
import '../../../network_manager/utils/api_response.dart';

class DashboardController extends  GetxController{
  RxBool loading = false.obs;
  Rxn <ApiResponse> apiResponse = Rxn<ApiResponse>();
  int userRating = 0;
  final TextEditingController commentController = TextEditingController();

Future<ApiResponse?>getRating(String rating,String workerId,String locationId,String comment) async {
  Map params = {
    "rating": rating,
    "workerId": workerId,
    "locationId": locationId,
    "comment" : comment

  };
  try{
    print("Rating body--->: $params");
  //  loading.value = true;
    apiResponse.value = await Repository().rating(params);
    return apiResponse.value;
  }catch(e){
    print("Error in controller: $e");
    return null;
  }finally{
   // loading.value = false;
  }
    return null;
  }
}

