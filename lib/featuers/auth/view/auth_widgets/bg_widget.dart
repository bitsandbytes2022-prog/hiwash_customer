import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../widgets/components/image_view.dart';

class BgWidget extends StatelessWidget {
  String imagePath;

  BgWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
     return Positioned(
       top: 0,
       right: 0,
       left: 0,
       child: Column(
         children: [
           ImageView(path: imagePath),
           Container(
             width: Get.width,
             height: double.maxFinite,
             color: Colors.black,)
         ],
       ),
     );
  }
}
