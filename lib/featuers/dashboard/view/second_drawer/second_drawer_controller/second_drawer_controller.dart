import 'package:get/get.dart';
class SecondDrawerController extends GetxController {
  var isChecked = [true, false, false].obs;

  void toggleCheckbox(int index) {
    for (int i = 0; i < isChecked.length; i++) {
      isChecked[i] = (i == index);
    }
  }


  RxList<bool> isExpanded = <bool>[false, false, false].obs;

  void toggleExpand(int index) {
    isExpanded[index] = !isExpanded[index];
  }
}