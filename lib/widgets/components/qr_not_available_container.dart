import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../language/String_constant.dart';
import '../../styling/app_color.dart';

class QrNotAvailableContainer extends StatelessWidget {
    final double? height;
    final double? width;
    final String? text;
  const QrNotAvailableContainer({super.key, this.height, this.width, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width:width?? 216,
      height:height?? 261,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(
            color: AppColor.c142293.withOpacity(0.25),
            blurRadius: 25,
            spreadRadius: 0,
          )]
      ),
      child: Center(child: Text(text?.tr??"${StringConstant.kQrNotGenerated.tr}",
        textAlign: TextAlign.center,
      )),
    );
  }
}
