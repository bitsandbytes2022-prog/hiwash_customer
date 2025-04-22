import 'package:get/get.dart';

import '../../../network_manager/repository.dart';
import '../../../network_manager/utils/api_response.dart';

class DashboardController extends  GetxController{
  RxBool loading = false.obs;
  Rxn <ApiResponse> apiResponse = Rxn<ApiResponse>();
/*  giveRating(
      String rating,
      String workerId,
      String locationId,
      String comment,
      ) {

    loading = true;
    Map params = {
      "rating": "6",
      "workerId": "24",
      "locationId": "1",
      "comment" : "excellent"
    };
    Repository().rating(params).then((value) {
   if(value!=null){
     Get.back();
   }
    })
        .onError((error, stackTrace) {
      loading = false;
      print("Error${error.toString()}");
    });
  }

}*/

Future<ApiResponse?>getRating(String rating,String workerId,String locationId,String comment) async {
  Map params = {
    "rating": rating,
    "workerId": workerId,
    "locationId": locationId,
    "comment" : comment};
  try{
    print("Rating body--->: $params");
  //  loading.value = true;
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

/*  Future<GetTokenModel?> getToken(String phoneNumber) async {
    Map<String, dynamic> requestBody = {"mobileNumber": phoneNumber};
    print("Calling getToken with $phoneNumber");
    isLoading.value = true;

    try {
      final value = await Repository().getTokens(requestBody);

        print(" Value received in controller: $value");
        getTokenModel = value;
        LocalStorage token=LocalStorage();
         token.saveToken(value.data?.token??'');

    return value;
    } catch (error) {
      print(" Error in controller: $error");
      return null;
    } finally {
      isLoading.value = false;
    }
  }*/