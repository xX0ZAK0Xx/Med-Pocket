import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_pocket/common/calculation/calculation.dart';
import 'package:med_pocket/common/widgets/get_height.dart';
import 'package:med_pocket/common/widgets/number_box.dart';
import 'package:med_pocket/common/widgets/text_box.dart';
import 'package:med_pocket/controller/user_info_controller.dart';
import 'package:med_pocket/data/dataList.dart';
import 'package:med_pocket/pages/navigation/navigation_page.dart';
import 'package:med_pocket/common/styles/styles.dart';

class CreateAccount extends StatelessWidget {
  CreateAccount({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController heightFTController = TextEditingController();
  final TextEditingController heightINController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  UserInfoController userInfoController = Get.put(UserInfoController());
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
                    GetHeight(
                        heightFTController: heightFTController,
                        heightINController: heightINController),
                    const SizedBox(
                      height: 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        bmi = Calculation.calculateBMI(heightFTController.text,
                            heightINController.text, weightController.text);
                        user.put('name', nameController.text);
                        user.put('weight', double.parse(weightController.text));
                        user.put('bmi', bmi);
                        DataList.addBMI([
                          '${DateTime.now().day}/${DateTime.now().month}',
                          bmi
                        ]);
                        userInfoController.fetchBMI();
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
}
