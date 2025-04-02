import 'package:flutter/material.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';

import '../../../generated/assets.dart';
import '../../../styling/app_color.dart';
import '../../../styling/app_font_anybody.dart';
import '../../../widgets/components/image_view.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  color: AppColor.c142293,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.only(left: 16, right: 16, top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(""),
                    Text(
                      "Notification’s",
                      style: w700_16a(color: AppColor.white),
                    ),
                    ImageView(
                      height: 23,
                      width: 23,
                      path: Assets.iconsIcMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
          30.heightSizeBox,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [


                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
