import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:med_pocket/common/styles/styles.dart';
import 'package:med_pocket/controller/chip_controller.dart';
import 'package:med_pocket/controller/dropdown_controller.dart';
import 'package:med_pocket/controller/medicine_controller.dart';
import 'package:med_pocket/models/medicine_model.dart';
import 'package:med_pocket/common/widgets/text_box.dart';
import 'package:med_pocket/pages/medicine/widget/dropdown.dart';
import 'package:med_pocket/pages/medicine/widget/selector.dart';

Future<dynamic> medicineInfo(BuildContext context, bool isNew,
    {int index = 0, List<String>? existingMedicine}) {
  ChipController chipController = Get.put(ChipController());
  DropDownController dropDownController = Get.put(DropDownController());
  MedicineController medicineController = Get.put(MedicineController());

  TextEditingController name = TextEditingController();
  String selectedType = '';
  String selectedTime = '';

  if (!isNew) {
    selectedType = existingMedicine![0];
    name.text = existingMedicine[1];
    selectedTime = existingMedicine[2];
    dropDownController.time.value = selectedTime;
  }

  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(15),
          height: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  TextBox(hint: 'Name of the Medicine', controller: name),
                  const SizedBox(
                    height: 25,
                  ),
                  Text("Select the type of medicine",
                      style: headline(
                          c: Colors.pink.shade300, w: FontWeight.w500)),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Selector(
                        chipController: chipController,
                        name: 'Tablet',
                        index: 0,
                        icon: FontAwesomeIcons.pills,
                        isNew: isNew,
                        selectedType: selectedType,
                      ),
                      Selector(
                        chipController: chipController,
                        name: 'Syrup',
                        index: 1,
                        icon: FontAwesomeIcons.bottleDroplet,
                        isNew: isNew,
                        selectedType: selectedType,
                      ),
                      Selector(
                        chipController: chipController,
                        name: 'Injection',
                        index: 2,
                        icon: FontAwesomeIcons.syringe,
                        isNew: isNew,
                        selectedType: selectedType,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select time: ",
                          style: headline(
                              c: Colors.pink.shade300, w: FontWeight.w500)),
                      DropDown(
                        dropDownController: dropDownController,
                        initialValue: selectedTime,
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (name.text != "" && dropDownController.time.value != "") {
                    var med = Medicine(
                        name: name.text,
                        type: chipController.name.value,
                        time: dropDownController.time.value);
                    if (isNew) {
                      medicineController.addMedicine(med);
                    } else {
                      medicineController.editMedicine(index, med);
                    }
                    Navigator.pop(context);
                    name.clear();
                    chipController.name.value = "tablet";
                    chipController.selected.value = 0;
                    dropDownController.time.value = "";

                    var user = Hive.box('user');
                    print(user.get('new'));
                    if (user.get('new') == null) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                child:
                                    Lottie.asset('assets/gif/swipe_left.json'),
                              ),
                              actions: [
                                Center(
                                    child: Text(
                                  "Swipe left the medicine for more options",
                                  style: headline(w: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                )),
                              ],
                            );
                          });
                      user.put('new', 'no');
                    }
                  }
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: redGradient(),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      isNew ? "Add" : "Save",
                      style: headline(c: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      });
}
