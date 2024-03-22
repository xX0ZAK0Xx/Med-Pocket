import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_pocket/common/calculation/calculation.dart';
import 'package:med_pocket/common/styles/styles.dart';
import 'package:med_pocket/common/widgets/get_height.dart';
import 'package:med_pocket/common/widgets/number_box.dart';
import 'package:med_pocket/controller/navigation_controller.dart';
import 'package:med_pocket/data/dataList.dart';
import 'package:med_pocket/pages/add/widget/gradient_buton.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});
  TextEditingController weightController = TextEditingController();
  TextEditingController heightFTController = TextEditingController();
  TextEditingController heightINController = TextEditingController();
  NavigationController controller = Get.put(NavigationController());

  var user = Hive.box('user');
  var bmiList = Hive.box('bmiList');
  var bloodo2 = Hive.box('bloodo2');

  void cancel() {
    weightController.clear();
    heightFTController.clear();
    heightINController.clear();
    controller.changePage(0);
  }

  var bmi = 0.0, height = 0.0;
  void save() {
    bmi = Calculation.calculateBMI(heightFTController.text,
        heightINController.text, weightController.text);
    DataList.addBMI(['${DateTime.now().day}/${DateTime.now().month}', bmi]);
    controller.changePage(0);
    weightController.clear();
    heightFTController.clear();
    heightINController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(12),
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              //Weight
              Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.red,
                    child: Icon(
                      Iconsax.weight,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: NumberBox(
                          hint: 'Enter Your weight in Kgs',
                          controller: weightController)),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              //Height
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.red,
                    child: Image.asset(
                      'assets/icons/height-scale.png',
                      height: 25,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  GetHeight(
                      heightFTController: heightFTController,
                      heightINController: heightINController),
                ],
              ),
              Container(
                height: 300,
              ),
            ],
          ),
          //-----------------buttons---------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GradientButton(
                width: (screenWidth - 24) / 2 - 8,
                text: 'Cancel',
                onTap: cancel,
                bgGradient: pinkGradient(),
                textColor: Colors.red,
              ),
              GradientButton(
                width: (screenWidth - 24) / 2 - 8,
                text: 'Save',
                onTap: save,
                bgGradient: redGradient(),
                textColor: Colors.white,
              ),
            ],
          )
        ],
      )),
    );
  }
}
