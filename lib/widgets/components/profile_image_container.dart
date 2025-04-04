import 'package:flutter/material.dart';

import '../../generated/assets.dart';
import '../../styling/app_color.dart';

class ProfileImageContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double? radius;
  final String? imagePath;
  const ProfileImageContainer({super.key, this.height=34, this.width=34, this.radius=20, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColor.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: AppColor.c142293.withOpacity(0.1)),
      ),
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: AppColor.c142293.withOpacity(0.20),
          borderRadius: BorderRadius.circular(40),
        ),
        child: CircleAvatar(
          backgroundImage: AssetImage(imagePath ?? Assets.imagesDemoProfile),
          // Set your image here
          radius: radius,
        ),
      ),
    );
  }
}
