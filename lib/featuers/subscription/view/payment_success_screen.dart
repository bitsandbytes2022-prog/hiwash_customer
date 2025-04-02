import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hiwash_customer/widgets/components/get_start_button.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import 'package:lottie/lottie.dart';

import '../../../generated/assets.dart';
import '../../../widgets/components/qr_dialog.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 140,
                decoration: const BoxDecoration(
                  color: Color(0xFF002D9C),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 40,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.back();
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 111),
                    Text(
                      "Hello, Ibrahim",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 46,
                bottom: -17,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.symmetric(horizontal: BorderSide.none),
                  ),
                  child: CircleAvatar(
                    radius: 38,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: AssetImage(
                          Assets.imagesDemoProfile
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Lottie.network(
                      'https://assets1.lottiefiles.com/private_files/lf30_QLsD8M.json',
                      height: 200,
                      fit: BoxFit.cover,
                      repeat: true,
                      reverse: false,
                      animate: true,
                    ),
                  ),
                  Column(
                    children: [
                      19.heightSizeBox,
                      QrDialog(),
                  20.heightSizeBox,
                      GetStartButton(text: "kGetStarted"),
                    ],
                  ),


                ],
              ),
            ),
          )
        /*  Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Stack(
                  children: [
                    Column(
                    children: [
                        QrDialog(),
                      30.heightSizeBox,
                      GetStartButton(text: "kGetStarted")
                    ],
                    ),

                  ],
                ),
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
