import 'package:flutter/material.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 12),
          alignment: Alignment.center,
          height: 65,
          width: 65,
          padding: EdgeInsets.symmetric(horizontal: 7, vertical: 17),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: AppColor.cC31848),
          ),
          child: ImageView(path: Assets.imagesPaymet1, height: 31, width: 51),
        ),
        Container(
          height: 26,
          width: 26,
          //margin: EdgeInsets.only(right: 11, top: 11),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: AppColor.c1F9D70,
              // color:controller.selectedIndex.value == index ? Colors.green : AppColor.c5C6B72.withOpacity(0.4),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: AppColor.c1F9D70,
              // color: controller.selectedIndex.value == index ? Colors.green : AppColor.c5C6B72.withOpacity(0.4),
              borderRadius: BorderRadius.circular(100),
            ),
            child: ImageView(path: Assets.iconsIcCheck, height: 7, width: 12),
          ),
        ),
      ],
    );
  }
}
