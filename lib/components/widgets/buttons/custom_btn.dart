import 'package:flutter/material.dart';

class CustomBTN extends StatelessWidget {
  const CustomBTN(
      {Key? key,
      required this.title,
      this.height = 50.0,
      required this.fontSize,
      required this.backgroundColor,
      required this.onPressed,
      required this.fontColor,
      required this.borderRadius,
      required this.letterSpacing})
      : super(key: key);

  final String title;
  final double height;
  final double fontSize;
  final double borderRadius;
  final double letterSpacing;
  final Color fontColor;
  final Color backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(borderRadius),
            ),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
              letterSpacing: letterSpacing,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: fontColor),
        ),
      ),
    );
  }
}
