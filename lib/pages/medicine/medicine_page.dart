import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:med_pocket/common/styles/styles.dart';
import 'package:med_pocket/common/widgets/text_box.dart';
import 'package:med_pocket/controller/chip_controller.dart';
import 'package:med_pocket/controller/dropdown_controller.dart';
import 'package:med_pocket/controller/medicine_controller.dart';
import 'package:med_pocket/models/medicine_model.dart';
import 'package:med_pocket/pages/medicine/widget/medicine_card.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  MedicineController medicineController = Get.put(MedicineController());
  // TextEditingController nameController = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   var medicine = Medicine(type: '1', name: "Napa", time: "After Breakfast");
  //   medicineController.addMedicine(medicine);
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "All Medicine",
                  style: headline(),
                ),
                TextButton(
                    onPressed: () {
                      medicineInfo(context, true);
                    },
                    child: Text(
                      "Add new",
                      style: headline(c: Colors.red.shade300, s: 18.0),
                    ))
              ],
            ),
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemCount: medicineController.medicines.length,
                  itemBuilder: (context, index) {
                    var medicine = medicineController.medicines[index];
                    return Slidable(
                      direction: Axis.horizontal,
                      endActionPane:
                          ActionPane(motion: const ScrollMotion(), children: [
                        //-----------edit-----------
                        SlidableAction(
                          autoClose: true,
                          onPressed: (context) {
                            medicineInfo(context, false,
                                index: index, existingMedicine: medicine);
                          },
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor:
                              const Color.fromARGB(255, 64, 84, 128),
                          icon: Icons.edit,
                        ),
                        //---------------- delete -----------
                        SlidableAction(
                          autoClose: true,
                          onPressed: (context) {
                            medicineController.deleteMedicine(index);
                          },
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor: Colors.red.shade300,
                          icon: Icons.delete,
                        )
                      ]),
                      child: MedicineCard(
                        type: medicine[0],
                        name: medicine[1],
                        time: medicine[2],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }

  Future<dynamic> medicineInfo(BuildContext context, bool isNew,
      {int index = 0, List<String>? existingMedicine}) {
    ChipController chipController = Get.put(ChipController());
    DropDownController dropDownController = Get.put(DropDownController());

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
                    if (name.text != "" &&
                        dropDownController.time.value != "") {
                      var med = Medicine(
                          name: name.text,
                          type: chipController.name.value,
                          time: dropDownController.time.value);
                      if (isNew) {
                        medicineController.addMedicine(med);
                      } else {
                        medicineController.editMedicine(index, med);
                      }
                      name.clear();
                      chipController.name.value = "tablet";
                      chipController.selected.value = 0;
                      dropDownController.time.value = "";

                      var user = Hive.box('user');
                      if (user.get('new') == null) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: Lottie.asset(
                                      'assets/gif/swipe_left.json'),
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
                    Navigator.pop(context);
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
}

class DropDown extends StatelessWidget {
  DropDown(
      {super.key,
      required this.dropDownController,
      required this.initialValue});

  final allTimes = [
    'Before Breakfast',
    'After Breakfast',
    'Before Lunch',
    'After Lunch',
    'Before Evening Snacks',
    'After Evening Snacks',
    'Before Dinner',
    'After Dinner',
  ];

  final DropDownController dropDownController;
  final String initialValue;

  @override
  Widget build(BuildContext context) {
    return Obx(() => DropdownButton(
          icon: Icon(
            Iconsax.arrow_down_14,
            color: Colors.pink.shade300,
          ),
          value: dropDownController.time.value == ""
              ? initialValue == ""
                  ? null
                  : initialValue
              : dropDownController.time.value,
          items: allTimes.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(color: Colors.pink.shade300, fontSize: 18),
              ),
            );
          }).toList(),
          onChanged: (item) {
            dropDownController.setTime(item!);
          },
        ));
  }
}

class Selector extends StatelessWidget {
  const Selector({
    Key? key,
    required this.chipController,
    required this.name,
    required this.index,
    required this.icon,
    required this.isNew,
    this.selectedType,
  }) : super(key: key);

  final ChipController chipController;
  final String name;
  final int index;
  final IconData icon;
  final bool isNew;
  final String? selectedType;
  @override
  Widget build(BuildContext context) {
    if (!isNew) {
      chipController.selected.value = selectedType!.toLowerCase() == "tablet"
          ? 0
          : selectedType!.toLowerCase() == "syrup"
              ? 1
              : 2;
      chipController.name.value = selectedType!.toLowerCase();
    }
    return Obx(() => GestureDetector(
          onTap: () {
            chipController.selected.value = index;
            chipController.name.value = name;
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                color: chipController.selected.value == index
                    ? Colors.red
                    : Colors.pink.shade100,
              ),
            ),
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  name,
                  style: const TextStyle(fontSize: 15),
                ),
              ],
            ),
          ),
        ));
  }
}
