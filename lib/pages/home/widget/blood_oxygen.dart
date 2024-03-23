import 'package:flutter/material.dart';
import 'package:med_pocket/common/styles/styles.dart';

class BloodOxygen extends StatelessWidget {
  const BloodOxygen({
    super.key,
    required this.screenWidth,
    required this.bloodo2,
  });

  final double screenWidth;
  final double bloodo2;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 100,
      width: (screenWidth - 24) / 2 - 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        // gradient: pinkGradient(),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.red.shade100,
              blurRadius: 10,
              offset: const Offset(0, 0),
              spreadRadius: 0),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Blood O',
                  style: headline(),
                ),
                TextSpan(
                    text: '2',
                    style: headline(s: 10.0).copyWith(
                        fontFeatures: [const FontFeature.subscripts()])),
              ],
            ),
          ),
          Text(
            bloodo2.toString(),
            style: headline(
              s: 34.0,
              c: bloodo2 > 95 && bloodo2 < 99
                  ? const Color.fromARGB(255, 5, 235, 166)
                  : const Color.fromARGB(255, 252, 82, 82),
            ).copyWith(shadows: [
              Shadow(
                offset: const Offset(0.0, 0.0),
                blurRadius: 50.0,
                color: bloodo2 > 95 && bloodo2 < 99
                    ? const Color.fromARGB(120, 5, 235, 166)
                    : const Color.fromARGB(120, 252, 82, 82),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
