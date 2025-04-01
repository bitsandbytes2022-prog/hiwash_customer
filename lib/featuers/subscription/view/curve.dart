import 'package:flutter/material.dart';
import 'package:hiwash_customer/widgets/sized_box_extension.dart';
import '../../../generated/assets.dart';

class SlidingImagesPage extends StatefulWidget {
  @override
  _SlidingImagesPageState createState() => _SlidingImagesPageState();
}

class _SlidingImagesPageState extends State<SlidingImagesPage> {
  final List<String> images = [
    Assets.imagesCard1,
    Assets.imagesAppLogo,
    Assets.imagesCard1,
  ];

  int currentIndex = 1;

  void slideImages(int tappedIndex) {
    setState(() {
      // If user taps the left or right image, move it to the center
      currentIndex = tappedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Reorder the images based on the current index
    final reorderedImages = [
      images[(currentIndex + 0) % images.length], // Left image
      images[(currentIndex + 1) % images.length], // Center image
      images[(currentIndex + 2) % images.length], // Right image
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Sliding Images')),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => slideImages(0),
              child: Container(
                height: 90,
                width: 60,
                child: Transform.rotate(
                  angle: -10 * 3.14 / 180,
                  child: Image.asset(reorderedImages[0], fit: BoxFit.cover),
                ),
              ),
            ),
            10.widthSizeBox,
            GestureDetector(
              onTap: () => slideImages(1),
              child: Transform.translate(
                offset: Offset(0, -10),
                child: Container(
                  color: Colors.red,
                  height: 100,
                  width: 60,
                  child: Image.asset(reorderedImages[1], fit: BoxFit.cover),
                ),
              ),
            ),
            10.widthSizeBox,
            GestureDetector(
              onTap: () => slideImages(2),
              child: Container(
                height: 90,
                width: 60,
                child: Transform.rotate(
                  angle: 10 * 3.14 / 180,
                  child: Image.asset(reorderedImages[2], fit: BoxFit.cover),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
