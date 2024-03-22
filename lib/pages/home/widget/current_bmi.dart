import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_pocket/common/styles/styles.dart';
import 'package:med_pocket/controller/user_info_controller.dart';

class CurrentBMI extends StatefulWidget {
  const CurrentBMI({
    super.key,
  });

  @override
  State<CurrentBMI> createState() => _CurrentBMIState();
}

class _CurrentBMIState extends State<CurrentBMI> {
  var user = Hive.box('user');
  UserInfoController userInfoController = UserInfoController();
  @override
  void initState() {
    super.initState();
    userInfoController.fetchBMI();
  }

  @override
  Widget build(BuildContext context) {
    double bmi = userInfoController.bmi.value;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Current BMI",
          style: headline(w: FontWeight.w600),
        ),
        // Obx(() => 
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
            // )
      ],
    );
  }
}
