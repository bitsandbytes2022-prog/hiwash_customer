import 'package:flutter/material.dart';
import 'package:hiwash_customer/generated/assets.dart';

class PaymentSelectionScreen extends StatefulWidget {
  @override
  _PaymentSelectionScreenState createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
  int selectedIndex = 2;

  final List<String> paymentIcons = [

    Assets.assetsImagesWelcomeBg,
   Assets.imagesDemoProfile,
    Assets.imagesDemo2,
    Assets.imagesDemo,
    Assets.imagesDemo2,

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(paymentIcons.length, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Container(
                height: 100,width: 100,
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: selectedIndex == index ? Colors.red : Colors.transparent,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image.asset(paymentIcons[index], width: 50),
                    if (selectedIndex == index)
                      Positioned(
                        bottom: -8,
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 12,
                          child: Icon(Icons.check, color: Colors.white, size: 16),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}