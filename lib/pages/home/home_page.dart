import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_pocket/controller/navigation_controller.dart';
import 'package:med_pocket/pages/home/widget/blood_glucose.dart';
import 'package:med_pocket/pages/home/widget/blood_oxygen.dart';
import 'package:med_pocket/pages/home/widget/current_bmi.dart';
import 'package:med_pocket/pages/home/widget/graph.dart';
import 'package:med_pocket/pages/home/widget/home_header.dart';
import 'package:med_pocket/pages/home/widget/pressure_text.dart';
import 'package:med_pocket/common/styles/styles.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  var user = Hive.box('user');
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    int bloodo2 = user.get('bloodo2') ?? 98;
    double bloodGlucose = user.get('bloodo2') ?? 6.5;
    int highPressure = user.get('highPressure') ?? 125;
    int lowPressure = user.get('lowPressure') ?? 82;
    NavigationController navigationController = Get.put(NavigationController());
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //--------- Header ---------
              HomeHeader(navigationController: navigationController),
              const SizedBox(
                height: 20,
              ),
              //--------- Current BMI --------
              CurrentBMI(),
              const SizedBox(
                height: 20,
              ),
              //--------- Graph --------
              Graph(),
              const SizedBox(
                height: 20,
              ),
              //-------- Others --------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //--------- Blood O2, Glucose ----------
                  Column(
                    children: [
                      BloodOxygen(screenWidth: screenWidth, bloodo2: bloodo2),
                      const SizedBox(
                        height: 20,
                      ),
                      BloodGlucose(
                          screenWidth: screenWidth, bloodGlucose: bloodGlucose),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    height: 220,
                    width: (screenWidth - 24) / 2 - 8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        PressureText(value: highPressure),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: redGradient(),
                          ),
                          child: Center(
                              child: Text(
                            "Pressure",
                            style: headline(c: Colors.white),
                          )),
                        ),
                        PressureText(value: lowPressure),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
