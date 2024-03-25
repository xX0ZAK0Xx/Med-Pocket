import 'package:flutter/material.dart';
import 'package:med_pocket/common/styles/styles.dart';

class MiniButton extends StatelessWidget {
  const MiniButton({
    super.key,
    required this.width,
    required this.text,
    this.onTap,
    required this.value,
  });

  final double width;
  final String text, value;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        width: width,
        decoration: BoxDecoration(
            gradient: pinkGradient(),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 1.5, color: Colors.red)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              textAlign: TextAlign.center,
              style: headline(),
            ),
            Text(
              (value != '0.0' && value != '0   0') ? value : "",
              style: headline(),
            ),
          ],
        ),
      ),
    );
  }
}
