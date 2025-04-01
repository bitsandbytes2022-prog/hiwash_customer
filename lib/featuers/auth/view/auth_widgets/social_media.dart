import 'package:flutter/material.dart';
import 'package:hiwash_customer/generated/assets.dart';
import 'package:hiwash_customer/widgets/components/image_view.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

class SocialMedia extends StatelessWidget {
  const SocialMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageView(
            path: Assets.iconsIcGoogle,
            height: 30,
            width: 32,
          ),
          18.widthSizeBox,
          ImageView(
            path: Assets.iconsIcApple,
            height: 30,
            width: 32,
          ),
          18.widthSizeBox,
          ImageView(
            path: Assets.iconsIcMeta,
            height: 30,
            width: 32,
          ),
        ],
      ),
    );
  }
}
