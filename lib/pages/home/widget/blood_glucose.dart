import 'package:flutter/material.dart';
import 'package:med_pocket/common/styles/styles.dart';

class BloodGlucose extends StatelessWidget {
  const BloodGlucose({
    super.key,
    required this.screenWidth,
    required this.bloodGlucose,
  });

  final double screenWidth;
  final double bloodGlucose;

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
          Text(
            "Glucose Level",
            style: headline(s: 26.0),
          ),
          Text(
            bloodGlucose.toString(),
            style: headline(
              s: 34.0,
              c: bloodGlucose > 5.6 && bloodGlucose < 6.9
                  ? const Color.fromARGB(255, 5, 235, 166)
                  : const Color.fromARGB(255, 252, 82, 82),
            ).copyWith(shadows: [
              Shadow(
                offset: const Offset(0.0, 0.0),
                blurRadius: 50.0,
                color: bloodGlucose > 5.6 && bloodGlucose < 6.9
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
