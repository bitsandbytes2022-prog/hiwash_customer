
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../styling/app_color.dart';

showLoader() {
  Get.dialog(
      barrierDismissible: true,
       AbsorbPointer(
          child: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,

        ),
      )));
}

hideLoader() {
  if (Get.isDialogOpen ?? false) {
    Get.back();
  }
}
