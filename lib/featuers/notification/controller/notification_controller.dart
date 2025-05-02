import 'package:get/get.dart';
import 'package:hiwash_customer/featuers/notification/model/notification.dart';

import '../../../network_manager/repository.dart';

class NotificationController extends GetxController {
  RxList<bool> selectedIndices = List.generate(20, (index) => false).obs;
@override
  void onInit() {
    getNotification();
    super.onInit();
  }
  void toggleSelection(int index) {
    if (index >= 0 && index < selectedIndices.length) {
      selectedIndices[index] = !selectedIndices[index];
    }
  }
  RxBool isWashSelected=true.obs;
  Rxn<NotificationModel>notificationModel=Rxn();
  bool loading = false;

  Future<NotificationModel?> getNotification() async {
    int id=0;
    try {

      notificationModel.value = await Repository().notificationRepo(id);
      return notificationModel.value;
    } catch (error) {
      loading = false;
      update();
      print("Error fetching Wash summary: $error");
    }
    return null;

  }

}