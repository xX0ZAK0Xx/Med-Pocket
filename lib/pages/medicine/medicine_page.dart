import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:med_pocket/common/styles/styles.dart';
import 'package:med_pocket/controller/medicine_controller.dart';
import 'package:med_pocket/pages/medicine/widget/medicine_card.dart';
import 'package:med_pocket/pages/medicine/widget/medicine_info_sheet.dart';

class MedicinePage extends StatelessWidget {
  MedicinePage({super.key});

  MedicineController medicineController = Get.put(MedicineController());

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            //----------- Header -----------------
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
            //----------------- Medicine List ----------------
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
}
