
import 'package:flutter/material.dart';
import 'package:med_pocket/common/styles/styles.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.width,
    required this.onTap,
    required this.text,
    required this.bgGradient,
    required this.textColor,
  });
  final LinearGradient bgGradient;
  final void Function()? onTap;
  final String text;
  final double width;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: bgGradient,
          border: Border.all(width: 1.5, color: Colors.red),
        ),
        child: Center(
          child: Text(
            text,
            style: headline(c: textColor),
          ),
        ),
      ),
    );
  }
}
