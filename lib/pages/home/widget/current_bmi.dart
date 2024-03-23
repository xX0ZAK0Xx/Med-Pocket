import 'package:flutter/material.dart';
import 'package:med_pocket/common/styles/styles.dart';
import 'package:med_pocket/data/dataList.dart';

class CurrentBMI extends StatefulWidget {
  const CurrentBMI({
    super.key,
  });

  @override
  State<CurrentBMI> createState() => _CurrentBMIState();
}

class _CurrentBMIState extends State<CurrentBMI> {

  @override
  Widget build(BuildContext context) {
    double bmi = DataList.allBMI.last[1];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Current BMI",
          style: headline(w: FontWeight.w600),
        ),
        Text(
          bmi.toString(),
          style: headline(
            s: 34.0,
            c: bmi > 18.5 && bmi < 24.9
                ? const Color.fromARGB(255, 5, 235, 166)
                : const Color.fromARGB(255, 252, 82, 82),
          ).copyWith(shadows: [
            Shadow(
              offset: const Offset(0.0, 0.0),
              blurRadius: 50.0,
              color: bmi > 18.5 && bmi < 24.9
                  ? const Color.fromARGB(120, 5, 235, 166)
                  : const Color.fromARGB(120, 252, 82, 82),
            ),
          ]),
        ),
      ],
    );
  }
}
