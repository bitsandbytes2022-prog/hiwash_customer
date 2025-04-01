import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/subscription_controller.dart';

class OfferCardWidget extends StatelessWidget {
  OfferCardWidget({super.key});
  SubscriptionController controller =Get.find();
  @override
  Widget build(BuildContext context) {
   return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Left Image
        Container(
          height: 116,
          width: 88,
          child: Transform.rotate(
            angle: -10 * 3.14 / 180,
            child: Image.asset(
              controller.images[0],
              fit: BoxFit.cover,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0, -14),
          child: Container(
            height: 128,
            width: 97,
            child: Image.asset(
              controller. images[1],
              fit: BoxFit.cover,
            ),
          ),
        ),
        // SizedBox(width: 5), // Space between images
        Container(
          height: 116,
          width: 88,
          child: Transform.rotate(
            angle: 10 * 3.14 / 180,
            child: Image.asset(
              controller. images[2],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
