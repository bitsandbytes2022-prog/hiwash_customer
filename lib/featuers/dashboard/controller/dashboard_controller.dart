import 'package:get/get.dart';

import '../../../network_manager/repository.dart';

class DashboardController extends  GetxController{
  bool loading = false;
  giveRating(
      String rating,
      String workerId,
      String locationId,
      String comment,
      ) {

    loading = true;
    Map params = {
      "rating": "3",
      "workerId": "24",
      "locationId": "1",
      "comment" : "excellent"
    };

    Repository().rating(params).then((value) {
      print("${value.success}");
      Get.back();
    })
        .onError((error, stackTrace) {
      loading = false;
      print("Error${error.toString()}");
    });
  }

}