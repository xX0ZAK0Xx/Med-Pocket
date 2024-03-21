import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_pocket/controller/navigation_controller.dart';
import 'package:med_pocket/pages/home/widget/current_bmi.dart';
import 'package:med_pocket/pages/home/widget/graph.dart';
import 'package:med_pocket/pages/home/widget/home_header.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


class HomePage extends StatelessWidget {
  HomePage({super.key});
  var user = Hive.box('user');
  @override
  Widget build(BuildContext context) {
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
              Graph()

            ]),
      ),
    );
  }
}
