import 'package:flutter/widgets.dart';
import 'package:hiwash_customer/widgets/components/app_home_bg.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

class StepByStepGuideDetailScreen extends StatelessWidget {
  const StepByStepGuideDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppHomeBg(
      iconRight: SizedBox(),
      child: Column(
        children: [15.heightSizeBox, Text("Step-by-Step Guide-Detail-Screen")],
      ),
    );
  }
}
