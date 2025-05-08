import 'package:flutter/material.dart';

import '../../styling/app_color.dart';

class QrNotGenerated extends StatelessWidget {
  const QrNotGenerated({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 216,
      height: 261,
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(
            color: AppColor.c142293.withOpacity(0.1),
            blurRadius: 25,
            spreadRadius: 0,
          )]
      ),
      child: Center(child: Text("Qr Not\nGenerated",
        textAlign: TextAlign.center,
      )),
    );
  }
}
