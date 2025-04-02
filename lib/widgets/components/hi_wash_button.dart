import 'package:flutter/material.dart';
import 'package:hiwash_customer/styling/app_color.dart';
import '../../styling/app_font_anybody.dart';

class HiWashButton extends StatelessWidget {
  final Color? color;
  final void Function()? onTap;
  final String text;
  final double? width; // Keep this as nullable
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double radius;
  final bool isLoading;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Color? textColor;
  final Widget? prefix;

  const HiWashButton({
    super.key,
    this.padding,
    this.margin,
    this.color,
    this.textColor,
    this.borderColor,
    this.radius = 100,
    this.onTap,
    this.textStyle,
    this.height = 50,
    this.isLoading = false,
    required this.text,
    this.width, // Keep this as nullable
    this.prefix,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        width: width ?? double.infinity, // Default to full width
        margin: margin ?? EdgeInsets.zero,
        padding: padding ?? EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color ?? AppColor.blue,
          boxShadow: [
            BoxShadow(
              color: AppColor.blue.withOpacity(0.35),
              blurRadius: 15,
              spreadRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: isLoading
            ? Center(
          child: SizedBox(
            width: width,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: FittedBox(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        )
            : Center(
          child: Text(
            text,
            style: textStyle ?? w600_16a(color: AppColor.white),
          ),
        ),
      ),
    );
  }
}