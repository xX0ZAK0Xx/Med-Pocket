import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_pocket/data/dataList.dart';
import 'package:med_pocket/pages/navigation/navigation_page.dart';
import 'package:med_pocket/styles/styles.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController heightFTController = TextEditingController();
  final TextEditingController heightINController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  var bmi = 0.0, weight = 0.0, height = 0.0;
  @override
  Widget build(BuildContext context) {
    var user = Hive.box('user');
    return Container(
      decoration: BoxDecoration(gradient: bgGradient()),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Hero(
                        tag: 'logo',
                        child: Image.asset(
                          "assets/icons/medical-check.png",
                          height: 150,
                        )),
                    const SizedBox(
                      height: 30,
                    ),
                    TextBox(
                      hint: 'Enter your name',
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    NumberBox(
                      hint: "Weight in kgs",
                      controller: weightController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Height:  ",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 80,
                          child: NumberBox(
                            hint: "",
                            controller: heightFTController,
                          ),
                        ),
                        const Text(
                          "ft",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 80,
                          child: NumberBox(
                            hint: "",
                            controller: heightINController,
                          ),
                        ),
                        const Text(
                          "inch",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        calculateBMI(heightFTController.text,
                            heightINController.text, weightController.text);
                        user.put('name', nameController.text);
                        user.put('height', height);
                        user.put('weight', weight);
                        user.put('bmi', bmi);
                        DataList.addBMI(
                            ['${DateTime.now().day}/${DateTime.now().month}', bmi]);
                        Get.offAll(() => const NavigationPage());
                      },
                      child: Container(
                        height: 70,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: redGradient(),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                            child: Text(
                          "Let's Start",
                          style: headline(c: Colors.white),
                        )),
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void calculateBMI(String ft, String inch, String wt) {
    print('$ft $inch $wt');

    try {
      weight = double.parse(wt);
      height = double.parse(ft) * 0.3048 + int.parse(inch) * 0.0254;
      bmi = weight / (height * height);

      // Round the BMI to one decimal point
      String roundedBMI = bmi.toStringAsFixed(1);
      bmi = double.parse(roundedBMI);
    } catch (e) {
      bmi = 0.0;
    }
    print('BMI: $bmi');
  }
}

class TextBox extends StatelessWidget {
  const TextBox({
    super.key,
    required this.hint,
    required this.controller,
  });
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.red,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade50, width: 1),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade100, width: 1),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}

class NumberBox extends StatelessWidget {
  const NumberBox({
    super.key,
    required this.hint,
    required this.controller,
  });
  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      cursorColor: Colors.red,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade50, width: 1),
            borderRadius: BorderRadius.circular(20)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade100, width: 1),
            borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
