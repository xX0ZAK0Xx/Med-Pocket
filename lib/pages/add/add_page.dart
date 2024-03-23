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
import 'package:med_pocket/pages/add/widget/gradient_buton.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});
  TextEditingController weightController = TextEditingController();
  TextEditingController heightFTController = TextEditingController();
  TextEditingController heightINController = TextEditingController();
  TextEditingController bloodO2Controller = TextEditingController();
  TextEditingController bloodGlucoseController = TextEditingController();
  NavigationController controller = Get.put(NavigationController());
  ButtonInfoController buttonInfoController = Get.put(ButtonInfoController());

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
  void saveBloodO2() {
    var value = double.parse(bloodO2Controller.text);
    double bloodO2 = double.parse(value.toStringAsFixed(1));
    DataList.addBloodO2(bloodO2);
    buttonInfoController.changeBloodO2(bloodO2);
    bloodO2Controller.clear();
  }

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
                              bloodO2Controller, saveBloodO2);
                        },
                        // value: D,ataList.allBloodO2.isEmpty
                        //     ? ""
                        //     : DataList.allBloodO2.last.toString(),
                        value: buttonInfoController.bloodO2.toString(),
                      ),
                      MiniButton(
                        width: (screenWidth - 24) / 3 - 10,
                        text: 'Glucose Level',
                        onTap: () {},
                        value: '',
                      ),
                      MiniButton(
                        width: (screenWidth - 24) / 3 - 10,
                        text: 'Pressure',
                        onTap: () {},
                        value: '',
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

  Future<dynamic> dialoge(BuildContext context, String title,
      TextEditingController controller, Function() save) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              actions: [
                NumberBox(hint: "", controller: controller),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                        onPressed: () {
                          controller.clear();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Cancel",
                          style: headline(
                              c: const Color.fromARGB(255, 255, 157, 150)),
                        )),
                    TextButton(
                        onPressed: () {
                          save();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Save",
                          style: headline(),
                        ))
                  ],
                )
              ],
            ));
  }
}

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
              value!='0.0' ? value : "",
              style: headline(),
            ),
          ],
        ),
      ),
    );
  }
}
