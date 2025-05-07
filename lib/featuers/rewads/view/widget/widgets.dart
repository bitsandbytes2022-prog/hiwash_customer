
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class Base64ImageWidget extends StatelessWidget {
  final String? base64String;
  final double height;
  final double width;
  final BoxFit fit;
  final BorderRadius borderRadius;

  const Base64ImageWidget({
    Key? key,
    required this.base64String,
    required this.height,
    required this.width,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (base64String == null || base64String!.isEmpty) {
      imageWidget = Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: borderRadius,
          border: Border.all(color: Colors.grey),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              size: height * 0.5,
              color: Colors.grey[600],
            ),
            SizedBox(height: 4),
            Text(
              'Image not available',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: height * 0.15,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      try {
        final cleanedBase64 = base64String!.contains(',')
            ? base64String!.split(',').last
            : base64String!;
        final Uint8List imageBytes = base64Decode(cleanedBase64);
        imageWidget = Image.memory(
          imageBytes,
          height: height,
          width: width,
          fit: fit,
        );
      } catch (e) {
        imageWidget = Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: borderRadius,
            border: Border.all(color: Colors.grey),
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.broken_image,
                size: height * 0.5,
                color: Colors.grey[600],
              ),
              SizedBox(height: 4),
              Text(
                'Invalid image',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: height * 0.15,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: imageWidget,
    );
  }
}

/*

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hiwash_customer/generated/assets.dart';

Widget buildQRCodeWidget(String? base64String) {
  if (base64String == null || base64String.isEmpty) {
    return Image.asset(
      Assets.imagesDemo,
      height: 157,
      width: 157,
      fit: BoxFit.fitWidth,
    );
  }

  try {
    final cleanedBase64 = base64String.contains(',')
        ? base64String.split(',').last
        : base64String;

    final Uint8List imageBytes = base64Decode(cleanedBase64);
    return Image.memory(
      imageBytes,
      height: 157,
      width: 157,
      fit: BoxFit.fitWidth,
    );
  } catch (e) {
    print("Base64 decode error: $e");
    return Image.asset(
      Assets.imagesDemo,
      height: 157,
      width: 157,
      fit: BoxFit.fitWidth,
    );
  }
}
*/
