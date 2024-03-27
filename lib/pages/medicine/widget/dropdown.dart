
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';
import 'package:med_pocket/controller/dropdown_controller.dart';

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
