import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hiwash_customer/generated/assets.dart';

class SubscriptionController extends GetxController{

  final List<String> images = [
    Assets.imagesCard1,
    Assets.imagesCard1,
    Assets.imagesCard1,
  ];

  var selectedIndex = (2).obs;

  void selectPlan(int index) {
    selectedIndex.value = index;
  }
}