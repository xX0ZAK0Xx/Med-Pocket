
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:med_pocket/controller/chip_controller.dart';

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
