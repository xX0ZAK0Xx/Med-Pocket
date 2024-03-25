import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_pocket/common/calculation/calculation.dart';
import 'package:med_pocket/common/styles/styles.dart';
import 'package:med_pocket/common/widgets/get_height.dart';
import 'package:med_pocket/common/widgets/number_box.dart';
import 'package:med_pocket/controller/button_info_controller.dart';
import 'package:med_pocket/controller/navigation_controller.dart';
import 'package:med_pocket/data/dataList.dart';
import 'package:med_pocket/pages/add/widget/dialog1.dart';
import 'package:med_pocket/pages/add/widget/dialog2.dart';
import 'package:med_pocket/pages/add/widget/gradient_buton.dart';
import 'package:med_pocket/pages/add/widget/mini_button.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});
  TextEditingController weightController = TextEditingController();
  TextEditingController heightFTController = TextEditingController();
  TextEditingController heightINController = TextEditingController();
  TextEditingController bloodO2Controller = TextEditingController();
  TextEditingController bloodGlucoseController = TextEditingController();
  TextEditingController highController = TextEditingController();
  TextEditingController lowController = TextEditingController();
  NavigationController controller = Get.put(NavigationController());
  ButtonInfoController buttonInfoController = Get.put(ButtonInfoController());

  var user = Hive.box('user');
  var bmiList = Hive.box('bmiList');
  var bloodo2 = Hive.box('bloodo2');

  void clearControllerAndMove() {
    weightController.clear();
    heightFTController.clear();
    heightINController.clear();
    bloodO2Controller.clear();
    bloodGlucoseController.clear();
    highController.clear();
    lowController.clear();
    controller.changePage(0);
  }

  var bmi = 0.0, height = 0.0;
  void saveBloodO2Text() {
    double value;
    try {
      value = double.parse(bloodO2Controller.text);
    } catch (e) {
      value = 0.0;
    }
    double bloodO2 = double.parse(value.toStringAsFixed(1));
    buttonInfoController.changeBloodO2(bloodO2);
  }

  void saveBloodO2() {
    DataList.addBloodO2(buttonInfoController.bloodO2.value);
    buttonInfoController.changeBloodO2(0.0);
  }

  void saveBloodGlucose() {
    DataList.addBloodGlucose(buttonInfoController.bloodGlucose.value);
    buttonInfoController.changeBloodGlucose(0.0);
  }

  void saveBloodGlucoseText() {
    double value;
    try {
      value = double.parse(bloodGlucoseController.text);
    } catch (e) {
      value = 0.0;
    }
    double bloodGlucose = double.parse(value.toStringAsFixed(1));
    buttonInfoController.changeBloodGlucose(bloodGlucose);
  }

  void savePressure() {
    DataList.addPressure(buttonInfoController.highPressure.value,
        buttonInfoController.lowPressure.value);
    buttonInfoController.changePressure(0, 0);
  }

  void savePressureText() {
    int highPressure, lowPressure;
    try {
      highPressure = double.parse(highController.text).toInt();
      lowPressure = double.parse(lowController.text).toInt();
    } catch (e) {
      highPressure = 0;
      lowPressure = 0;
    }
    buttonInfoController.changePressure(highPressure, lowPressure);
  }

  void saveBMI() {
    bmi = Calculation.calculateBMI(heightFTController.text,
        heightINController.text, weightController.text);
    DataList.addBMI(['${DateTime.now().day}/${DateTime.now().month}', bmi]);
  }

  void save() {
    if (heightFTController.text != "" &&
        heightINController.text != "" &&
        weightController.text != "") {
      saveBMI();
    }
    if (bloodGlucoseController.text != "") {
      saveBloodGlucose();
    }
    if (bloodO2Controller.text != "") {
      saveBloodO2();
    }
    if (highController.text != "" && lowController.text != "") {
      savePressure();
    }
    clearControllerAndMove();
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
              const SizedBox(
                height: 50,
              ),
              //------------- Blood o2, Glucose, pressure add Button----------------
              Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MiniButton(
                        width: (screenWidth - 24) / 3 - 10,
                        text: 'Blood O2',
                        onTap: () {
                          dialoge(context, "Add new blood O2",
                              bloodO2Controller, saveBloodO2Text);
                        },
                        value: buttonInfoController.bloodO2.toString(),
                      ),
                      MiniButton(
                        width: (screenWidth - 24) / 3 - 10,
                        text: 'Glucose Level',
                        onTap: () {
                          dialoge(context, "Add new Gloocose",
                              bloodGlucoseController, saveBloodGlucoseText);
                        },
                        value: buttonInfoController.bloodGlucose.toString(),
                      ),
                      MiniButton(
                        width: (screenWidth - 24) / 3 - 10,
                        text: 'Pressure',
                        onTap: () {
                          dialoge2(context, "Add new Pressure", highController,
                              lowController, savePressureText);
                        },
                        value:
                            '${buttonInfoController.highPressure}   ${buttonInfoController.lowPressure}',
                      ),
                    ],
                  ))
            ],
          ),
          //-----------------buttons---------------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GradientButton(
                width: (screenWidth - 24) / 2 - 8,
                text: 'Cancel',
                onTap: clearControllerAndMove,
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
