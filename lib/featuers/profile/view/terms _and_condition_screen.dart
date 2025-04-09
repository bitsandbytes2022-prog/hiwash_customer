import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/components/app_home_bg.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHomeBg(
      headingText: "Terms and Condition",
      iconRight: SizedBox(),
      child: Column(children: [Text("kDemoText".tr)]),
    );
  }
}
